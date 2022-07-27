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



local settings = require('settings')

--local amh = require("amh")

package.path = package.path .. ';' .. os.getenv("HOME") ..
        '/.local/lib/python3.10/site-packages/powerline/bindings/awesome/?.lua'
naughty.config.icon_formats = { "png", "gif", "svg", "symbolic.png" }

-- Error handling
require('errors')


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

local utils = require('utils')

local bling = require("bling")

bling.widget.task_preview.enable {
    height = 300,              -- The height of the popup
    width = 500,               -- The width of the popup
    placement_fn = function(c, args) -- Place the widget using awful.placement (this overrides x & y)
		local f = awful.placement.next_to + awful.placement.no_offscreen
		f(c, {
			bounding_rect=args.bounding_rect,
			screen=mouse.screen,
			preferred_positions = "left",
			preferred_anchors = "middle",
		})
		-- naughty.notify({
        --     preset = naughty.config.presets.critical,
        --     title = "Oops, an error happened!",
        --     text = gears.debug.dump_return(args),
        -- })

    end,
	widget_structure = {
        {
            {
                {
                    id = 'icon_role',
                    widget = awful.widget.clienticon, -- The client icon
                },
                {
                    id = 'name_role', -- The client name / title
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.flex.horizontal
            },
            widget = wibox.container.margin,
            margins = 5
        },
        {
            id = 'image_role', -- The client preview
            resize = true,
            valign = 'center',
            halign = 'center',
            widget = wibox.widget.imagebox,
        },
		nil,
        layout = wibox.layout.fixed.vertical
    }
}
bling.widget.tag_preview.enable {
    show_client_content = true,  -- Whether or not to show the client content
    scale = 0.25,                 -- The scale of the previews compared to the screen
    honor_padding = true,        -- Honor padding when creating widget size
    honor_workarea = true,       -- Honor work area when creating widget size
    placement_fn = function(c, args)    -- Place the widget using awful.placement (this overrides x & y)
        local f = awful.placement.next_to + awful.placement.no_offscreen
        f(c, {
			bounding_rect=args.bounding_rect,
			screen=mouse.screen,
			preferred_positions = "left",
			preferred_anchors = "middle",
		})
    end,
    background_widget = wibox.widget {    -- Set a background image (like a wallpaper) for the widget
        image = beautiful.wallpaper,
        horizontal_fit_policy = "fit",
        vertical_fit_policy   = "fit",
        widget = wibox.widget.imagebox
    }
}


local machi = require("layout-machi")

beautiful.layout_machi = machi.get_icon()

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
    bling.layout.mstab,
    machi.default_layout,
}

Flags = {
    webcam = true,
    touchpad = true
}

Screenorder = { 1, 2, 3 }
for s in screen do
    for k, v in pairs(s.outputs) do
        if k == 'HDMI-0' then
            Screenorder[1] = v.viewport_id
        elseif k == 'DP-5' then
            Screenorder[2] = v.viewport_id
        elseif k == 'DP-3' then
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
local hardware_compat = require('hardware_compat')
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
        awful.button({ settings.modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end), awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ settings.modkey }, 3, function(t)
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


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", utils.set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    utils.set_wallpaper(s)



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
		style   = {
			shape = gears.shape.powerline
		},
		layout   = {
			spacing = -14,
		    layout  = wibox.layout.fixed.horizontal
		},

    widget_template = {
        {
            {
				-- 				{
				-- 	widget = wibox.widget.separator,
				-- 	color = "#ffffff00",
				-- 	forced_width = 10,
				-- },
                --
				{
                    id     = "text_role",
                    widget = wibox.widget.textbox,
                },
				{
					id = "seperator_role",
					widget = wibox.widget.separator,
					color  = beautiful.bg_focus,
					shape  = gears.shape.powerline,
					forced_width = 18,
				},

				layout = wibox.layout.fixed.horizontal,
            },
            left  = 24,
            -- right = 24,
            widget = wibox.container.margin
        },
        id     = "background_role",
        widget = wibox.container.background,
        -- Add support for hover colors and an index label
        create_callback = function(self, c3, index, objects) --luacheck: no unused args
			self:get_children_by_id("text_role")[1].markup = "<b> "..c3.name.." </b>"

			if c3.selected and index < 9 and root.tags()[index+1].selected then
				self:get_children_by_id("seperator_role")[1].color = beautiful.taglist_fg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline

			elseif not c3.selected and index < 9 and not root.tags()[index+1].selected then
				self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
			elseif not c3.selected and index == 9 then
				self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
			else
				self:get_children_by_id("seperator_role")[1].color = "#ffffff00"
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.rectangle
			end
			-- self:connect_signal('mouse::enter', function()
            --
            --     -- BLING: Only show widget when there are clients in the tag
            --     if #c3:clients() > 0 then
            --         -- BLING: Update the widget with the new tag
            --         awesome.emit_signal("bling::tag_preview::update", c3)
            --         -- BLING: Show the widget
            --         awesome.emit_signal("bling::tag_preview::visibility", s, true)
            --     end
            --
            --     -- if self.bg ~= '#ff0000' then
            --     --     self.backup     = self.bg
            --     --     self.has_backup = true
            --     -- end
            --     -- self.bg = '#ff0000'
            -- end)
            -- self:connect_signal('mouse::leave', function()
            --
            --     -- BLING: Turn the widget off
            --     awesome.emit_signal("bling::tag_preview::visibility", s, false)
            --
            --     -- if self.has_backup then self.bg = self.backup end
            -- end)

        end,
        update_callback = function(self, c3, index, objects) --luacheck: no unused args
            self:get_children_by_id("text_role")[1].markup = "<b> "..c3.name.." </b>"

			if c3.selected and index < 9 and root.tags()[index+1].selected then
				self:get_children_by_id("seperator_role")[1].color = beautiful.taglist_fg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline

			elseif not c3.selected and index < 9 and not root.tags()[index+1].selected then
				self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
			elseif not c3.selected and index == 9 then
				self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline

			else
				self:get_children_by_id("seperator_role")[1].color = "#ffffff00"
				self:get_children_by_id("seperator_role")[1].shape = gears.shape.rectangle
			end

        end,
    },
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
		layout   = {
			spacing = 10,
			spacing_widget = {
				{
					forced_width = 5,
					shape        = gears.shape.circle,
					widget       = wibox.widget.separator
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			layout  = wibox.layout.flex.horizontal
		},
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "icon_role",
                                widget = wibox.widget.imagebox,
                            },
                            margins = 2,
                            widget = wibox.container.margin,
                        },
						{
							id = "text_role",
							widget = wibox.widget.textbox,
						},
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = 10,
                    right = 10,
                    widget = wibox.container.margin
                },
				id = "background_role",
				widget = wibox.container.background,

			},
			layout= wibox.layout.align.vertical,

			create_callback = function(self, c, index, objects) --luacheck: no unused args
				self:get_children_by_id('icon_role')[1].client = c


				-- BLING: Toggle the popup on hover and disable it off hover
				self:connect_signal('mouse::enter', function()
					awesome.emit_signal("bling::task_preview::visibility", s,
                                        true, c)
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::task_preview::visibility", s,
                                        false, c)
                end)
			end,

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
            widgets.launcher,
			-- spacing_widget = {
			-- 	color  = '#aaffff',
			-- 	shape  = gears.shape.powerline,
			-- 	widget = wibox.widget.separator,
			-- },
            s.taglist,
            -- wibox.widget.textbox(markup.fontbg(beautiful.powerline_font, "#afd700", " ")),
            -- powerline.segment(true, "#afd700", nil, "#005f00", modalawesome.active_mode),
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
        awful.key({ settings.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
        awful.key({}, "Help", hotkeys_popup.show_help),
--awful.key({ settings.modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
--awful.key({ settings.modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
        awful.key({ settings.modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
--awful.key({ settings.modkey }, "j", function() awful.client.focus.byidx(1) end, { description = "focus next by index", group = "client" }),
--awful.key({ settings.modkey }, "k", function() awful.client.focus.byidx(-1) end, { description = "focus previous by index", group = "client" }),
        awful.key({ settings.modkey }, "w",
                function()
                    menu:show()
                end, {
                    description = "show main menu",
                    group = "awesome"
                }),
        awful.key({}, "XF86HomePage", function()
            menu:show()
        end),
-- Layout manipulation
--        awful.key({ settings.modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, { description = "swap with next client by index", group = "client" }),
--        awful.key({ settings.modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, { description = "swap with previous client by index", group = "client" }),
--        awful.key({ settings.modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, { description = "focus the next screen", group = "screen" }),
--        awful.key({ settings.modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, { description = "focus the previous screen", group = "screen" }),
        awful.key({ settings.modkey }, "u",
                awful.client.urgent.jumpto, {
                    description = "jump to urgent client",
                    group = "client"
                }), awful.key({ settings.modkey }, "Tab", function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, { description = "go back", group = "client" }), -- Standard program
        awful.key({ settings.modkey }, "Return", function()
            awful.spawn.with_shell(settings.terminal)
        end,
                { description = "open a Terminal", group = "launcher" }),
        awful.key({ settings.modkey, "Control" }, "r",
                awesome.restart, {
                    description = "reload awesome",
                    group = "awesome"
                }), awful.key({ settings.modkey, "Shift" }, "q", awesome.quit,
                { description = "quit awesome", group = "awesome" }),

--awful.key({ settings.modkey }, "l", function() awful.tag.incmwfact(0.05) end, { description = "increase master width factor", group = "layout" }),
--awful.key({ settings.modkey }, "h", function() awful.tag.incmwfact(-0.05) end, { description = "decrease master width factor", group = "layout" }),
--awful.key({ settings.modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, { description = "increase the number of master clients", group = "layout" }),
--awful.key({ settings.modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, { description = "decrease the number of master clients", group = "layout" }),
--awful.key({ settings.modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, { description = "increase the number of columns", group = "layout" }),
--awful.key({ settings.modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, { description = "decrease the number of columns", group = "layout" }),
        awful.key({ settings.modkey }, "space",
                function()
                    awful.layout.inc(1)
                end, {
                    description = "select next",
                    group = "layout"
                }), awful.key({ settings.modkey, "Shift" }, "space", function()
            awful.layout.inc(-1)
        end,
                { description = "select previous", group = "layout" }),
        awful.key({ settings.modkey, }, ".", function()
            machi.default_editor.start_interactive()
        end,
                { description = "edit the current layout if it is a machi layout", group = "layout" }),
        awful.key({ settings.modkey, }, "/", function()
            machi.switcher.start(client.focus)
        end,
                { description = "switch between windows for a machi layout", group = "layout" }),
        awful.key({ settings.modkey, "Control" }, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", { raise = true })
            end
        end, { description = "restore minimized", group = "client" }), -- Prompt
        awful.key({ settings.modkey }, "r", function()
            awful.spawn(settings.run_prompt_cmd)
        end, { description = "run prompt", group = "launcher" }),
        awful.key({ settings.modkey }, "x", function()
            utils.lua_prompt()
        end, { description = "lua execute prompt", group = "awesome" }), -- Menubar
        awful.key({ settings.modkey }, "d", function()
            menubar.show()
        end,
                { description = "show the menubar", group = "launcher" }),
        awful.key({}, "Print", function()
            awful.spawn("flameshot gui", false)
        end),
        awful.key({ "Mod1", }, "Tab",
                function()
                    beautiful.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
                end),

        awful.key({ "Mod1", "Shift" }, "Tab",
                function()
                    beautiful.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
                end),
        awful.key({ settings.modkey }, "p", foggy.menu),
        awful.key({ settings.modkey, "Shift" }, "g", function()
            utils.toggle_gaps()
        end),
		awful.key({settings.modkey, "Control"}, "p", function() bling.module.tabbed.pop() end),
		awful.key({settings.modkey, "Shift"}, "p", function() bling.module.tabbed.pick_with_dmenu() end)
)

Clientkeys = gears.table.join(awful.key({ settings.modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, { description = "toggle fullscreen", group = "client" }),
        awful.key({ settings.modkey, "Shift" }, "c",
                function(c)
                    c:kill()
                end, {
                    description = "close",
                    group = "client"
                }), awful.key({ settings.modkey, "Control" }, "space", awful.client.floating.toggle,
                { description = "toggle floating", group = "client" }),
        awful.key({ settings.modkey, "Control" }, "Return",
                function(c)
                    c:swap(awful.client.getmaster())
                end, { description = "move to master", group = "client" }),
        awful.key({ settings.modkey }, "o",
                function(c)
                    c:move_to_screen()
                end, {
                    description = "move to screen",
                    group = "client"
                }), awful.key({ settings.modkey }, "t", function(c)
            c.ontop = not c.ontop
        end,
                { description = "toggle keep on top", group = "client" }),
        awful.key({ settings.modkey }, "n", function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, { description = "minimize", group = "client" }),
        awful.key({ settings.modkey }, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, { description = "(un)maximize", group = "client" }),
        awful.key({ settings.modkey, "Control" }, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, { description = "(un)maximize vertically", group = "client" }),
        awful.key({ settings.modkey, "Shift" }, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, { description = "(un)maximize horizontally", group = "client" }))

Globalkeys = gears.table.join(Globalkeys, hardware_compat.global_keys)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    Globalkeys = gears.table.join(Globalkeys, -- View tag only.
            awful.key({ settings.modkey }, "#" .. i + 9, utils.switch_to_tag(i),
                    { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
            awful.key({ settings.modkey, "Control" }, "#" .. i + 9,
            -- function()
                    utils.toggle_tag(i)
            , { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
            awful.key({ settings.modkey, "Shift" }, "#" .. i + 9,
                    function()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                            end
                        end
                    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
            awful.key({ settings.modkey, "Control", "Shift" },
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
end), awful.button({ settings.modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
end), awful.button({ settings.modkey }, 3, function(c)
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

-- awful.spawn.single_instance("signal-desktop", {class={"signal", "Signal"}})
-- awful.spawn.single_instance("telegram-desktop", {class={"telegram-desktop", "TelegramDesktop"}})
-- awful.spawn.single_instance("discord", {class="discord"})
-- awful.spawn.single_instance("fluffychat", {class={"fluffychat", "Fluffychat"}})
-- awful.spawn.single_instance("whatsapp-nativefier", {class={"whatsapp-nativefier-d40211","whatsapp-for-linux","Whatsapp-for-linux","WhatsAppQT"}})
--
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

require("collision")()-- {
--        Normal        Xephyr         Vim      G510
-- up    = { "Up"    , "k"   --[[, "F15" ]]},
-- down  = { "Down"  , "j"   --[[, "F14" ]]},
-- left  = { "Left"  , "h"   --[[, "F13" ]]},
-- right = { "Right" , "l"   --[[, "F17" ]]},
--}

client.connect_signal("property::urgent", function(c) c:jump_to() end)

