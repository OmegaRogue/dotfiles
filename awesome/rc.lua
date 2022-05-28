-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awesome = awesome

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

package.path = package.path .. ';' .. os.getenv("HOME") ..
        '/.local/lib/python3.10/site-packages/powerline/bindings/awesome/?.lua'

naughty.config.icon_formats = { "png", "gif", "svg", "symbolic.png" }

-- Error handling
require('errors')



-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")



-- This is used later as the default Terminal and Editor to run.
Terminal = "wezterm"
Editor = os.getenv("EDITOR") or "nvim"
Editor_cmd = Terminal .. " -e " .. Editor

-- Default Modkey.
Modkey = "Mod4"


local bling = require("bling")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	bling.layout.centered,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left, awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top, awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal, awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle, awful.layout.suit.max,
    awful.layout.suit.max.fullscreen, awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
	bling.layout.mstab
}

Flags = {
    webcam = true,
    touchpad = true
}

Screenorder = {1,2,3}
for s in screen do
	for k,v in pairs(s.outputs) do
		if k == 'HDMI-0' then
			Screenorder[1] = v.viewport_id
		elseif k == 'DP-3' then
			Screenorder[2] = v.viewport_id
		elseif k == 'DP-5' then
			Screenorder[3] = v.viewport_id
		end
	end
end

local awesomebuttons = require("awesome-buttons.awesome-buttons")

local lain = require("lain")
local markup = lain.util.markup
local omegavoid = require('omegavoid')
local powerline = omegavoid.widget.powerline
local foggy = require('foggy')
local dpi = beautiful.xresources.apply_dpi
awesome.set_preferred_icon_size(dpi(32))
local modalawesome = require("modalawesome")
local widgets = require('widgets')



-- }}}


-- Menu
local menu = require('menu')

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
        awful.button({}, 1, function(t)
            t:view_only()
        end),
        awful.button({ Modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end), awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ Modkey }, 3, function(t)
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
    awful.tag({ "1", "2", "3", "4", "5" }, s, bling.layout.centered)

    awful.tag.add("6", { layout = awful.layout.suit.tile, screen = s })
    awful.tag.add("7", { layout = awful.layout.suit.tile, screen = s })
    awful.tag.add("8", { layout = awful.layout.suit.tile.left, screen = s })
    awful.tag.add("9", { layout = awful.layout.suit.tile, screen = s })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
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
	}
    s.tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape_border_width = 1,
            shape_border_color = '#777777',
            shape = gears.shape.powerline,
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
        {
			{
				{
					{
						{
							id     = "icon_role",
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget  = wibox.container.margin,
					},
					{
						id     = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 10,
				right = 10,
				widget = wibox.container.margin
			},
			id     = "background_role",
			widget = wibox.container.background,
        },

        layout = wibox.layout.align.vertical,
    },
    }
    -- Create the wibox
    s.topbar = awful.wibar({ position = "top", screen = s })
    s.bottombar = awful.wibar({ position = "bottom", screen = s })

    s.systray = wibox.widget.systray()
    -- Add widgets to the wibox
    s.powerbutton = awesomebuttons.with_icon {
        icon = 'power',
        color = '#f88',
        onclick = function()
            awful.spawn.with_shell("rofi -show power-menu")
        end
    }
    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            id = "topbar_left",
            layout = wibox.layout.fixed.horizontal,
            powerline.segment(true, beautiful.bg_focus, "#afd700", nil, widgets.launcher),
            s.taglist,
            wibox.widget.textbox(markup.fontbg(beautiful.powerline_font, "#afd700", " ")),
            powerline.segment(true, "#afd700", nil, "#005f00", modalawesome.active_mode),
            s.mypromptbox,
        },
		nil,

        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            modalawesome.sequence,
            powerline.segment(false, beautiful.bg_focus, nil, nil, widgets.memicon, widgets.mem),
            powerline.segment(false, nil, beautiful.bg_focus, nil, widgets.cpuicon, widgets.cpu),
            powerline.segment(false, beautiful.bg_focus, nil, nil, widgets.baticon, widgets.bat),
			powerline.segment(false, nil, beautiful.bg_focus, nil, awful.widget.keyboardlayout),
            powerline.segment(false, beautiful.bg_focus, nil, nil, s.systray),
            powerline.segment(false, nil, beautiful.bg_focus, nil, s.layoutbox),
            powerline.segment(false, "#303030", nil, "#626262", widgets.time),
            powerline.segment(false, "#303030", "#303030", "#626262", wibox.widget {
                format = '<span foreground="#d0d0d0"> %H:%M </span>',
                widget = wibox.widget.textclock
            }),
            powerline.segment(false, "#121212", "#303030", nil, s.powerbutton),
        }

    }
    s.bottombar:setup {
        layout = wibox.layout.fixed.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.tasklist,
        }
    }

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3,
        function()
            menu:toggle()
        end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
Globalkeys = gears.table.join(
		awful.key({ Modkey }, "s", hotkeys_popup.show_help,
        {
            description = "show help",
            group = "awesome"
        }),
		awful.key({},"Help", hotkeys_popup.show_help),
		awful.key({ Modkey }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
        awful.key({ Modkey }, "Right", awful.tag.viewnext, {
            description = "view next",
            group = "tag"
        }),
		awful.key({ Modkey }, "Escape", awful.tag.history.restore,
                { description = "go back", group = "tag" }),
        awful.key({ Modkey }, "j", function()
            awful.client.focus.byidx(1)
        end, { description = "focus next by index", group = "client" }),
        awful.key({ Modkey }, "k", function()
            awful.client.focus.byidx(-1)
        end, { description = "focus previous by index", group = "client" }),
        awful.key({ Modkey }, "w",
                function()
                    menu:show()
                end, {
                    description = "show main menu",
                    group = "awesome"
                }),
		awful.key({}, "XF86HomePage", function()menu:show()end),
		-- Layout manipulation
        awful.key({ Modkey, "Shift" }, "j", function()
            awful.client.swap.byidx(1)
        end,
                { description = "swap with next client by index", group = "client" }),
        awful.key({ Modkey, "Shift" }, "k", function()
            awful.client.swap.byidx(-1)
        end, { description = "swap with previous client by index", group = "client" }),
        awful.key({ Modkey, "Control" }, "j", function()
            awful.screen.focus_relative(1)
        end, { description = "focus the next screen", group = "screen" }),
        awful.key({ Modkey, "Control" }, "k", function()
            awful.screen.focus_relative(-1)
        end, { description = "focus the previous screen", group = "screen" }),
        awful.key({ Modkey }, "u",
                awful.client.urgent.jumpto, {
                    description = "jump to urgent client",
                    group = "client"
                }), awful.key({ Modkey }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, { description = "go back", group = "client" }), -- Standard program
        awful.key({ Modkey }, "Return", function()
            awful.spawn.with_shell(Terminal)
        end,
                { description = "open a Terminal", group = "launcher" }),
        awful.key({ Modkey, "Control" }, "r",
                awesome.restart, {
                    description = "reload awesome",
                    group = "awesome"
                }), awful.key({ Modkey, "Shift" }, "q", awesome.quit,
                { description = "quit awesome", group = "awesome" }),

        awful.key({ Modkey }, "l", function()
            awful.tag.incmwfact(0.05)
        end, { description = "increase master width factor", group = "layout" }),
        awful.key({ Modkey }, "h", function()
            awful.tag.incmwfact(-0.05)
        end, { description = "decrease master width factor", group = "layout" }),
        awful.key({ Modkey, "Shift" }, "h", function()
            awful.tag.incnmaster(1, nil, true)
        end, { description = "increase the number of master clients", group = "layout" }),
        awful.key({ Modkey, "Shift" }, "l", function()
            awful.tag.incnmaster(-1, nil, true)
        end, { description = "decrease the number of master clients", group = "layout" }),
        awful.key({ Modkey, "Control" }, "h", function()
            awful.tag.incncol(1, nil, true)
        end, { description = "increase the number of columns", group = "layout" }),
        awful.key({ Modkey, "Control" }, "l", function()
            awful.tag.incncol(-1, nil, true)
        end, { description = "decrease the number of columns", group = "layout" }),
        awful.key({ Modkey }, "space",
                function()
                    awful.layout.inc(1)
                end, {
                    description = "select next",
                    group = "layout"
                }), awful.key({ Modkey, "Shift" }, "space", function()
            awful.layout.inc(-1)
        end,
                { description = "select previous", group = "layout" }),

        awful.key({ Modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end, { description = "restore minimized", group = "client" }), -- Prompt
        awful.key({ Modkey }, "r", function() awful.spawn("rofi -show run")end, { description = "run prompt", group = "launcher" }),
        awful.key({}, "#+120", function() awful.spawn("rofi -show run")end),
        awful.key({}, "XF86Search", function() awful.spawn("rofi -show run")end),
        awful.key({}, "XF86Favorites", function() awful.spawn("rofi -show run")end),
        awful.key({ Modkey }, "x", function()
            awful.prompt.run {
                prompt = markup.fontcolor(beautiful.powerline_font, beautiful.bg_normal, beautiful.bg_focus, "\u{E0B0}") ..
                        markup.bg.color(beautiful.bg_focus, "<span rise=\"3pt\" > awesome </span>") ..
                        markup.fontcolor(beautiful.powerline_font, beautiful.bg_focus, "#3465a4", "\u{E0B0}") ..
                        markup.color("#2e3436", "#3465a4", "<span rise=\"3pt\" > " .. _VERSION .. " </span>") ..
                        markup.fontcolor(beautiful.powerline_font, "#3465a4", beautiful.bg_normal, "\u{E0B0}") .. "  ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end, { description = "lua execute prompt", group = "awesome" }), -- Menubar
        awful.key({ Modkey }, "d", function()
            menubar.show()
        end,
                { description = "show the menubar", group = "launcher" }),
		awful.key({}, "Print", function() awful.util.spawn("flameshot gui", false) end),
		awful.key({ "Mod1", }, "Tab",
                function()
                    beautiful.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
                end),

        awful.key({ "Mod1", "Shift" }, "Tab",
                function()
                    beautiful.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
                end),
        awful.key({ Modkey }, "p", foggy.menu),
        awful.key({ }, "XF86MonBrightnessUp", function()
            foggy.shortcuts.inc_backlight(10, 1)
        end),
        awful.key({ }, "XF86MonBrightnessDown", function()
            foggy.shortcuts.inc_backlight(-10, 1)
        end),
		awful.key({ }, "XF86TouchpadToggle", function()
		end),
		awful.key({ }, "XF86WebCam", function()
		end),
		awful.key({ }, "XF86AudioRaiseVolume", function()
			awful.spawn.with_shell("pactl set-sink-mute 0 false ; pactl set-sink-volume 0 +5%")
		end),
		awful.key({ }, "XF86AudioLowerVolume", function()
			awful.spawn.with_shell("pactl set-sink-mute 0 false ; pactl set-sink-volume 0 -5%")
		end),
		awful.key({ }, "XF86AudioMute", function()
			awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
		end)
)

Clientkeys = gears.table.join(awful.key({ Modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ Modkey, "Shift" }, "c",
                function(c)
                    c:kill()
                end, {
                    description = "close",
                    group = "client"
                }), awful.key({ Modkey, "Control" }, "space", awful.client.floating.toggle,
                { description = "toggle floating", group = "client" }),
        awful.key({ Modkey, "Control" }, "Return",
                function(c)
                    c:swap(awful.client.getmaster())
                end, { description = "move to master", group = "client" }),
        awful.key({ Modkey }, "o",
                function(c)
                    c:move_to_screen()
                end, {
                    description = "move to screen",
                    group = "client"
                }), awful.key({ Modkey }, "t", function(c)
            c.ontop = not c.ontop
        end,
                { description = "toggle keep on top", group = "client" }),
        awful.key({ Modkey }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ Modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ Modkey, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ Modkey, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }))

local function switch_to_tag(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end
local function toggle_tag(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
	Globalkeys = gears.table.join(Globalkeys,
			awful.key({}, "XF86Launch"..i+4, toggle_tag(i)))
end
for i = 1, 9 do
    Globalkeys = gears.table.join(Globalkeys, -- View tag only.
            awful.key({ Modkey }, "#" .. i + 9, switch_to_tag(i),
			{ description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
            awful.key({ Modkey, "Control" }, "#" .. i + 9,
                    -- function()
						toggle_tag(i)
                    , { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
            awful.key({ Modkey, "Shift" }, "#" .. i + 9,
                    function()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
            awful.key({ Modkey, "Control", "Shift" },
                    "#" .. i + 9, function()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:toggle_tag(tag)
                            end
                        end
                    end, { description = "toggle focused client on tag #" .. i, group = "tag" }))
end

Clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
end), awful.button({ Modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
end), awful.button({ Modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(Globalkeys)
-- }}}

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

