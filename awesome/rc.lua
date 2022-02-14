-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local appmenu = require("appmenu")
package.path = package.path .. ';' .. os.getenv("HOME") ..
        '/.local/lib/python3.10/site-packages/powerline/bindings/awesome/?.lua'

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

local dpi = beautiful.xresources.apply_dpi
awesome.set_preferred_icon_size(32)

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

-- start powerline daemon
awful.spawn.with_shell('powerline-daemon -q')

local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local logout_menu_widget = require(
        "awesome-wm-widgets.logout-menu-widget.logout-menu")
local awesomebuttons = require("awesome-buttons.awesome-buttons")
local github_activity_widget = require(
        "awesome-wm-widgets.github-activity-widget.github-activity-widget")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
local batteryarc_widget = require(
        "awesome-wm-widgets.batteryarc-widget.batteryarc")

local lain = require("lain")
local markup = lain.util.markup

local omegavoid = require('omegavoid')
local powerline = omegavoid.util.powerline

--require('powerline')
powerline_widget = wibox.widget {
    align = 'right',
    valign = 'center',
    widget = wibox.widget.textbox,
    divider_font = powerline.settings.divider_font,
}
time = wibox.widget {
    format = '<span foreground="#9e9e9e"> %Y-%m-%d </span>',
    widget = wibox.widget.textclock
}

--[[
<span foreground="#121212"> </span>
<span foreground="#9e9e9e" background="#121212"> ↑  21h 19m 38s</span>
<span foreground="#303030" background="#121212"> </span>
<span foreground="#9e9e9e" background="#303030"> 2022-02-14</span>
<span foreground="#626262" background="#303030"> </span>
<span foreground="#d0d0d0" background="#303030" font_weight="bold"> 11:33 </span>

]]


--powerline_widget.font = beautiful.powerline_font
--[[local function powerline_callback()
    local file,err = io.open("dump2.txt",'w')
    --powerline_widget:set_markup(...)

    --powerline_widget:set_markup_silently(string.gsub(powerline_widget.markup,"([])","<span rise='3pt' font='"..beautiful.powerline_font..">%1</span>"))
    file:write(powerline_widget.text)
    file:close()
end
powerline_widget:connect_signal("widget::redraw_needed", powerline_callback)]]

--powerline_widget.font = beautiful.powerline_font
--powerline_widget.text = string.gsub(powerline_widget.text,"([%g])","<span font='"..beautiful.font.."'>%1</span>")


-- local baticon = wibox.widget.imagebox(theme.widget_battery)
-- local mybattery = lain.widget.bat({
--     settings = function()
--         if bat_now.status and bat_now.status ~= "N/A" then
--             if bat_now.ac_status == 1 then
--                 baticon:set_image(beautiful.widget_ac)
--             elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
--                 baticon:set_image(beautiful.widget_battery_empty)
--             elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
--                 baticon:set_image(beautiful.widget_battery_low)
--             else
--                 baticon:set_image(beautiful.widget_battery)
--             end
--             widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
--         else
--             widget:set_markup(markup.font(beautiful.font, " AC "))
--             baticon:set_image(beautiful.widget_ac)
--         end
--     end
-- })


local cal = lain.widget.cal({
    attach_to = { powerline_widget, time },
    notification_preset = { font = beautiful.font, fg = beautiful.fg_normal, bg = beautiful.bg_normal },
    cal = "/usr/bin/env TERM=linux /usr/bin/cal --color=always"
})
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local mycpu = lain.widget.cpu({
    settings = function()
        -- widget:set_markup(markup.font(beautiful.font, " " .. string.format("%3s",cpu_now.usage) .. "% "))
        widget:set_markup(markup.font(beautiful.font, " " .. cpu_now.usage .. "% "))
    end
})
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local mymem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. mem_now.used .. "MB "))
    end
})

local separators = lain.util.separators
-- -- Separators
local spr = wibox.widget.textbox(' ')
local arrl_dl = beautiful.powerline_hard.right(beautiful.bg_focus, beautiful.bg_normal)
local arrl_ld = beautiful.powerline_hard.right(beautiful.bg_normal, beautiful.bg_focus)
local arrr_dl = beautiful.powerline_hard.left(beautiful.bg_focus, beautiful.bg_normal)
local arrr_ld = beautiful.powerline_hard.left(beautiful.bg_normal, beautiful.bg_focus)
local freedesktop = require("freedesktop")


-- autostart functionality for various desktop daemons 
-- needed since we're just using awesome rather than a full-blown DE
-- awful.spawn("nextcloud")
-- awful.spawn("picom --daemon") -- start compositor compton as a daemon
-- the following scans the /etc/xdg/autostart directory and starts anything
-- there
-- local pfile = io.popen("find /etc/xdg/autostart -maxdepth 1 -print0")
-- fileblob = pfile:read("*a")
-- pfile:close()
-- -- the find program returned a string with NULLs at the end of each file name
-- for file in fileblob:gmatch("[^\0]+") do
--     -- the first file in the list is just the /etc/xdg/autostart dir, so make 
--     -- sure we skip it
--     if file:find("/etc/xdg/autostart/.+") then
--         local f = io.open(file)
--         local text = f:read("*a")
--         f:close()
--         -- run the program
--         awful.spawn(text:match("[\r\n]Exec=(.-)[\r\n]"))
--     end
-- end



-- This is used later as the default terminal and editor to run.
terminal = "wezterm"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating, awful.layout.suit.tile,
    awful.layout.suit.tile.left, awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top, awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle, awful.layout.suit.max,
    awful.layout.suit.max.fullscreen, awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    }, { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart }, { "quit", function()
        awesome.quit()
    end }
}
mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon }
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal }
        -- other triads can be put here
    }
})

--[[-- Create the rule that we will use to match for the application.
for group_name, group_data in pairs({
    ["wezterm: misc"] = { color = "#009F00", rule_any = { class = { "org.wezfurlong.wezterm" } } }
}) do
    hotkeys_popup.widget.add_group_rules(group_name, group_data)
end

-- Table with all of our hotkeys
local wezterm = {

    ["wezterm: misc"] = {{
                             modifiers = { "Mod1" },
                             keys = {
                                 ["1..9"] = "go to tab"
                             }
                         }, {
                             modifiers = { "Ctrl" },
                             keys = {
                                 t = "new tab",
                                 w = 'close tab',
                                 ['Tab'] = "next tab"
                             }
                         }, {
                             modifiers = { "Ctrl", "Shift" },
                             keys = {
                                 ['Tab'] = "previous tab"
                             }
                         }}
}

hotkeys_popup.widget.add_hotkeys(wezterm)]]

-- DESKTOP_SESSION
-- mymainmenu.

-- mymainmenu = awful.menu({ items = { {"applications", appmenu.Appmenu}, { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "open terminal", terminal }
--                                   }
--                         })



mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()
-- {{{ Wibar
-- Create a textclock widget

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t)
            t:view_only()
        end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end), awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end),
        awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

local tasklist_buttons = gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end), awful.button({}, 3, function(c)
            -- awful.menu.client_list({ theme = { width = 250 } })
            c:emit_signal("smart_borders::right_click")
        end), awful.button({}, 4, function()
            awful.client.focus.byidx(1)
        end),
        awful.button({}, 5, function()
            awful.client.focus.byidx(-1)
        end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- freedesktop.desktop.add_icons({screen = s})

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    awful.tag.add("6", { layout = awful.layout.suit.tile, screen = s })
    awful.tag.add("7", { layout = awful.layout.suit.tile, screen = s })
    awful.tag.add("8", { layout = awful.layout.suit.tile.left, screen = s })
    awful.tag.add("9", { layout = awful.layout.suit.tile, screen = s })

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(gears.table.join(
            awful.button({}, 1,
                    function()
                        awful.layout.inc(1)
                    end),
            awful.button({}, 3,
                    function()
                        awful.layout.inc(-1)
                    end), awful.button({}, 4, function()
                awful.layout.inc(1)
            end),
            awful.button({}, 5,
                    function()
                        awful.layout.inc(-1)
                    end)))
    -- Create a taglist widget
    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        --shape = gears.shape.powerline
    }


    -- Create a tasklist widget
    --[[s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = -12,
            spacing_widget = {
                color = '#dddddd',
                shape = gears.shape.powerline,
                widget = wibox.widget.separator
            },
            layout = wibox.layout.fixed.horizontal
        }
    }]]
    s.tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            --shape  = gears.shape.rounded_bar,
            shape = gears.shape.powerline,
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget = wibox.container.margin,
                    },
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
    }
    -- Create the wibox
    s.topbar = awful.wibar({ position = "top", screen = s })
    s.bottombar = awful.wibar({ position = "bottom", screen = s })

    s.systray = wibox.widget.systray()
    -- s.mysystray:set_base_size(32)
    -- Add widgets to the wibox
    s.powerbutton = awesomebuttons.with_icon {
        icon = 'power',
        color = '#f88',
        onclick = function()
            awful.spawn.with_shell("~/.config/rofi/applets/menu/powermenu.sh")
        end
    }

    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- statuslinew(<widget>, <fontcolor>, <bg-left-shape>, <bg-color>, <bg-right-shape>)
            --powl,
            powerline.container("left", beautiful.fg_normal, beautiful.bg_normal, {
                powerline.colorize(mylauncher, beautiful.fg_normal, beautiful.bg_focus),
            }),
            powerline.container("left", beautiful.fg_normal, beautiful.bg_normal, {
                powerline.colorize(s.taglist, beautiful.fg_normal, beautiful.bg_normal),
            }),

            s.promptbox,
        },
        nil,
        {
            layout = wibox.layout.fixed.horizontal,
            --powerline.container(wibox.widget.textbox('a'),wibox.widget.textbox('b'))

            -- s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                powerline.container("right", beautiful.fg_normal, beautiful.bg_normal, {
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        s.powerbutton
                    }, beautiful.bg_normal, "#121212"),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        {
                            format = '<span foreground="#d0d0d0"> %H:%M </span>',
                            widget = wibox.widget.textclock
                        }
                    }, "#626262", "#303030"),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        time,
                    }, "#626262", "#303030"),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        s.layoutbox
                    }, beautiful.bg_normal, beautiful.bg_focus),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        volume_widget()
                    }, beautiful.bg_normal, beautiful.bg_focus),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        s.systray
                    }, beautiful.bg_normal, beautiful.bg_normal),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        cpuicon,
                        mycpu,
                    }, beautiful.bg_normal, beautiful.bg_focus),
                    powerline.colorize({
                        layout = wibox.layout.fixed.horizontal,
                        memicon,
                        mymem,
                    }, beautiful.bg_normal, beautiful.bg_focus),
                }),
            }
        }
    }
    s.bottombar:setup {
        layout = wibox.layout.align.horizontal,
        s.tasklist,
    }
end)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3,
        function()
            mymainmenu:toggle()
        end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(awful.key({ modkey }, "s", hotkeys_popup.show_help,
        {
            description = "show help",
            group = "awesome"
        }), awful.key({ modkey }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
        awful.key({ modkey }, "Right", awful.tag.viewnext, {
            description = "view next",
            group = "tag"
        }), awful.key({ modkey }, "Escape", awful.tag.history.restore,
                { description = "go back", group = "tag" }),
        awful.key({ modkey }, "j", function()
            awful.client.focus.byidx(1)
        end, { description = "focus next by index", group = "client" }),
        awful.key({ modkey }, "k", function()
            awful.client.focus.byidx(-1)
        end, { description = "focus previous by index", group = "client" }),
        awful.key({ modkey }, "w",
                function()
                    mymainmenu:show()
                end, {
                    description = "show main menu",
                    group = "awesome"
                }), -- Layout manipulation
        awful.key({ modkey, "Shift" }, "j", function()
            awful.client.swap.byidx(1)
        end,
                { description = "swap with next client by index", group = "client" }),
        awful.key({ modkey, "Shift" }, "k", function()
            awful.client.swap.byidx(-1)
        end, { description = "swap with previous client by index", group = "client" }),
        awful.key({ modkey, "Control" }, "j", function()
            awful.screen.focus_relative(1)
        end, { description = "focus the next screen", group = "screen" }),
        awful.key({ modkey, "Control" }, "k", function()
            awful.screen.focus_relative(-1)
        end, { description = "focus the previous screen", group = "screen" }),
        awful.key({ modkey }, "u",
                awful.client.urgent.jumpto, {
                    description = "jump to urgent client",
                    group = "client"
                }), awful.key({ modkey }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, { description = "go back", group = "client" }), -- Standard program
        awful.key({ modkey }, "Return", function()
            awful.spawn.with_shell(terminal)
        end,
                { description = "open a terminal", group = "launcher" }),
        awful.key({ modkey, "Control" }, "r",
                awesome.restart, {
                    description = "reload awesome",
                    group = "awesome"
                }), awful.key({ modkey, "Shift" }, "q", awesome.quit,
                { description = "quit awesome", group = "awesome" }),

        awful.key({ modkey }, "l", function()
            awful.tag.incmwfact(0.05)
        end, { description = "increase master width factor", group = "layout" }),
        awful.key({ modkey }, "h", function()
            awful.tag.incmwfact(-0.05)
        end, { description = "decrease master width factor", group = "layout" }),
        awful.key({ modkey, "Shift" }, "h", function()
            awful.tag.incnmaster(1, nil, true)
        end, { description = "increase the number of master clients", group = "layout" }),
        awful.key({ modkey, "Shift" }, "l", function()
            awful.tag.incnmaster(-1, nil, true)
        end, { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ modkey, "Control" }, "h", function()
            awful.tag.incncol(1, nil, true)
        end, { description = "increase the number of columns", group = "layout" }),
        awful.key({ modkey, "Control" }, "l", function()
            awful.tag.incncol(-1, nil, true)
        end, { description = "decrease the number of columns", group = "layout" }),
        awful.key({ modkey }, "space",
                function()
                    awful.layout.inc(1)
                end, {
                    description = "select next",
                    group = "layout"
                }), awful.key({ modkey, "Shift" }, "space", function()
            awful.layout.inc(-1)
        end,
                { description = "select previous", group = "layout" }),

        awful.key({ modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end, { description = "restore minimized", group = "client" }), -- Prompt
        awful.key({ modkey }, "r", function()
            awful.spawn.with_shell("~/.config/rofi/bin/launcher_misc")
        end, { description = "run prompt", group = "launcher" }),
        awful.key({ modkey }, "x", function()
            awful.prompt.run {

                prompt = markup.fontcolor(powerline.settings.divider_font,beautiful.bg_normal,beautiful.bg_focus,"")..
                        markup.bg.color(beautiful.bg_focus,"<span rise=\"3pt\" > awesome </span>")..
                        markup.fontcolor(powerline.settings.divider_font,beautiful.bg_focus,"#3465a4","")..
                        markup.color("#2e3436","#3465a4","<span rise=\"3pt\" > lua".._VERSION.." </span>")..
                        markup.fontcolor(powerline.settings.divider_font,"#3465a4",beautiful.bg_normal,"").."  ",
                textbox = awful.screen.focused().promptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end, { description = "lua execute prompt", group = "awesome" }), -- Menubar
        awful.key({ modkey }, "p", function()
            menubar.show()
        end,
                { description = "show the menubar", group = "launcher" }), awful.key({},
                "Print",
                function()
                    awful.util.spawn("flameshot gui", false)
                end), awful.key({ "Mod1", }, "Tab",
                function()
                    beautiful.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
                end),

        awful.key({ "Mod1", "Shift" }, "Tab",
                function()
                    beautiful.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
                end)
)

clientkeys = gears.table.join(awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ modkey, "Shift" }, "c",
                function(c)
                    c:kill()
                end, {
                    description = "close",
                    group = "client"
                }), awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
                { description = "toggle floating", group = "client" }),
        awful.key({ modkey, "Control" }, "Return",
                function(c)
                    c:swap(awful.client.getmaster())
                end, { description = "move to master", group = "client" }),
        awful.key({ modkey }, "o",
                function(c)
                    c:move_to_screen()
                end, {
                    description = "move to screen",
                    group = "client"
                }), awful.key({ modkey }, "t", function(c)
            c.ontop = not c.ontop
        end,
                { description = "toggle keep on top", group = "client" }),
        awful.key({ modkey }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ modkey, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ modkey, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys, -- View tag only.
            awful.key({ modkey }, "#" .. i + 9, function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                    function()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                            awful.tag.viewtoggle(tag)
                        end
                    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                    function()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
            awful.key({ modkey, "Control", "Shift" },
                    "#" .. i + 9, function()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:toggle_tag(tag)
                            end
                        end
                    end, { description = "toggle focused client on tag #" .. i, group = "tag" }))
end

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
end), awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
end), awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- require("titlebar")
require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
    -- awful.ewmh.client_geometry_requests(c, , {})

    if awesome.startup and not c.size_hints.user_position and
            not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::press", function(c)
    c:emit_signal("request::activate", "mouse_press", { raise = false })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)


-- }}}

-- for s in screen do
-- 	freedesktop.desktop.add_icons({screen = s})
-- end

awful.spawn.with_shell('powerline wm.awesome')
-- path = system.pathForFile("highScore.txt", system.DocumentsDirectory)
-- local file,err = io.open("dump.txt",'w')
-- if file then
--     for s in screen do
--         --file:write(json.encode(s))
--         file:write(s.index.."=")
-- 		for o,a in pairs(s.outputs) do
-- 			file:write(tostring(o).."{\n")
-- 				for k,v in pairs(a) do
-- 					file:write("\t"..tostring(k).."="..tostring(v)..",\n")
-- 				end
-- 			
-- 			file:write("\t},\n")
-- 		end
--     end
--     file:close()
-- else
--     print("error:", err) -- not so hard?
-- end
-- awful.spawn.easy_async("ls", function(stdout, err) require("mobdebug").start() end)

