-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Error handling
require('errors')

local awesome = awesome

--1198 337



-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local naughty = require("naughty")


-- screen.connect_signal("request::resize", function(old, new, args)
-- 	naughty.notification { text = gears.debug.dump_return(old), timeout = 0 }
-- 	naughty.notification { text = gears.debug.dump_return(new), timeout = 0 }
-- end)
--
-- screen.connect_signal("property::viewports", function(viewports)
-- 	for _, v in pairs(viewports) do
-- 		naughty.notification { text = gears.debug.dump_return(v.outputs[0]), timeout = 0 }
-- 		naughty.notification { text = gears.debug.dump_return(v.geometry), timeout = 0 }
-- 	end
-- end)
--
-- screen.connect_signal("property::viewports", function(viewports)
-- 	for _, v in pairs(viewports) do
-- 		naughty.notification { text = gears.debug.dump_return(v.outputs[0]), timeout = 0 }
-- 		naughty.notification { text = gears.debug.dump_return(v.geometry), timeout = 0 }
-- 	end
-- end)

local function set_screen_dpi(s)
	for _, o in pairs(s.outputs) do
		if o.mm_width == 1 then
			-- naughty.notification { title = tostring(s.geometry.width), text = gears.debug.dump_return(o), timeout = 0 }
			s.mm_maximum_size = math.sqrt(1198 * 1198 + 337 * 337)
			beautiful.xresources.set_dpi(5120 / 1198 * 25.4, s)
			beautiful.xresources.set_dpi(5120 / 1198 * 25.4)
		elseif o.mm_width == 1193 then
			-- naughty.notification { title = tostring(s.geometry.width), text = gears.debug.dump_return(o), timeout = 0 }
			s.mm_maximum_size = math.sqrt((1198 / 2.0) * (1198 / 2.0) + 337 * 337)
			beautiful.xresources.set_dpi(2560 / (1198 / 2.0) * 25.4, s)
			beautiful.xresources.set_dpi(2560 / (1198 / 2.0) * 25.4)
		else
			beautiful.xresources.set_dpi(s.geometry.width / o.mm_width * 25.4, s)
			s.mm_maximum_size = math.sqrt(o.mm_width * o.mm_width + o.mm_height * o.mm_height)
		end
		s.mm_minimum_size = s.mm_maximum_size
		s.inch_maximum_size = s.mm_maximum_size / 25.4
		s.inch_minimum_size = s.inch_maximum_size
		-- naughty.notify{title=tostring(s.index),text=tostring(s.dpi)}
	end
end

for _, s in ipairs(screen) do
	set_screen_dpi(s)
end
-- Notification library

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
--awful.screen.set_auto_dpi_enabled(true)
RC = {} -- global namespace, on top before require any modules

RC.settings = require('settings')
Modkey = RC.settings.modkey

--local amh = require("amh")

package.path = package.path .. ';' .. os.getenv("HOME") ..
	'/.local/lib/python3.10/site-packages/powerline/bindings/awesome/?.lua'
naughty.config.icon_formats = { "png", "gif", "svg", "symbolic.png" }

local awestore = require("awestore")

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

menubar.utils.terminal = RC.settings.terminal

local utils = require('utils')

local bling = require("bling")

local machi = require("layout-machi")

beautiful.layout_machi = machi.get_icon()
awful.layout.layouts = {
	bling.layout.centered,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
	bling.layout.mstab,
	machi.default_layout
}


-- TODO: use awestore
RC.flags = {
	webcam = true,
	touchpad = true,
	notif_suspend = false,
}

utils.init_screenorder()

local tags = require('tags')
local awesomebuttons = require("awesome-buttons.awesome-buttons")

local lain = require("lain")
local markup = lain.util.markup
local omegavoid = require('omegavoid')
local powerline = omegavoid.widget.powerline
local foggy = require('foggy')
RC.hardware = require("hardware_compat")
local dpi = beautiful.xresources.apply_dpi
awesome.set_preferred_icon_size(dpi(32))
local modalawesome = require("modalawesome")
local widgets = require('widgets')

local sharedtags = require("sharedtags")

RC.playerctl = bling.signal.playerctl.lib()

--bling.module.flash_focus.enable()
-- }}}

bling.widget.window_switcher.enable {
	type = "thumbnail", -- set to anything other than "thumbnail" to disable client previews

	-- keybindings (the examples provided are also the default if kept unset)
	hide_window_switcher_key = "Escape",                   -- The key on which to close the popup
	minimize_key = "n",                                    -- The key on which to minimize the selected client
	unminimize_key = "N",                                  -- The key on which to unminimize all clients
	kill_client_key = "q",                                 -- The key on which to close the selected client
	cycle_key = "Tab",                                     -- The key on which to cycle through all clients
	previous_key = "Left",                                 -- The key on which to select the previous client
	next_key = "Right",                                    -- The key on which to select the next client
	vim_previous_key = "h",                                -- Alternative key on which to select the previous client
	vim_next_key = "l",                                    -- Alternative key on which to select the next client

	cycleClientsByIdx = awful.client.focus.byidx,          -- The function to cycle the clients
	filterClients = awful.widget.tasklist.filter.currenttags, -- The function to filter the viewed clients
}

-- Menu
RC.menu = require('menu')

-- {{{ Wibar

-- Create a wibox for each screen and add it




-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", utils.set_wallpaper)
screen.connect_signal("request::wallpaper", function(s)
	if beautiful.wallpaper then
		awful.wallpaper {
			screen = s,
			widget = {
				{
					image = beautiful.wallpaper,
					resize = true,
					widget = wibox.widget.imagebox,
				},
				{
					widget = wibox.container.mirror,
					reflection = { horizontal = true, vertical = false },
					{
						image = beautiful.wallpaper,
						resize = true,
						widget = wibox.widget.imagebox,
					},
				},
				layout = wibox.layout.fixed.horizontal,
			}
		}
	end
end)
screen.connect_signal("request::desktop_decoration", function(s)
	-- Wallpaper

	utils.update_screenorder(s)

	-- Each screen has its own tag table.
	tags.maketags(s)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.layoutbox = awful.widget.layoutbox {
		screen = s,
		buttons = {
			awful.button({}, 1, function() awful.layout.inc(1) end),
			awful.button({}, 3, function() awful.layout.inc(-1) end),
			awful.button({}, 4, function() awful.layout.inc(1) end),
			awful.button({}, 5, function() awful.layout.inc(-1) end)
		}
	}
	-- Create a taglist widget
	s.taglist = widgets.taglist(s)
	s.tasklist = widgets.tasklist(s)                                                              -- Create the wibox
	s.topbar = awful.wibar { position = "top", screen = s, height = dpi(beautiful.wibar_height, s) } --, bg = beautiful.bg_normal.."55" }
	s.bottombar = awful.wibar { position = "bottom", screen = s, height = dpi(beautiful.wibar_height, s) }

	s.systray = wibox.widget.systray()
	-- Add widgets to the wibox
	s.powerbutton = awesomebuttons.with_icon {
		icon = 'power',
		color = '#f88',
		onclick = function()
			awful.spawn.with_shell("rofi -show power-menu")
		end
	}
	s.title_display = wibox.widget {
		widget = wibox.widget.textbox,
		--bg = "#00000000",
	}
	s.topbar:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- Left widgets
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
		{
			id = "topbar_center",
			widget = wibox.container.place,
			--bg = "#00000000",
			halign = "center",
			fill_horizontal = true,
			{
				widget = wibox.container.background,
				--bg = "#ff000000",
				s.title_display,
			},
			buttons = {
				awful.button({}, 1, function(c)
					if s.focused_client then
						s.focused_client.minimized = true
					end
				end),
				awful.button({}, 3, nil, function()
					if s.focused_client then
						s.focused_client:emit_signal("smart_borders::right_click")
					end
				end)
			}
		},
		{
			-- Right widgets
			id = "topbar_right",
			layout = wibox.layout.fixed.horizontal,
			modalawesome.sequence,
			powerline.line {
				id = "right_line",
				--bg = beautiful.bg_normal.."00",
				line_layout = {
					-- {bg=beautiful.bg_normal.."00", content ={ }},
					{ bg = beautiful.bg_focus,                   content = { widgets.memicon, widgets.mem } },
					{ content = { widgets.cpuicon, widgets.cpu } },
					{ bg = beautiful.bg_focus,                   content = { widgets.baticon, widgets.bat } },
					{ content = { awful.widget.keyboardlayout } },
					{ bg = beautiful.bg_focus,                   content = { s.systray } },
					{ content = { s.layoutbox } },
					{
						bg = "#303030",
						fg = "#626262",
						content = {
							widgets.date }
					},
					{
						bg = "#303030",
						fg = "#626262",
						content = {
							widgets.time }
					},
					{ bg = "#121212", content = { s.powerbutton } },
				}
			},
		}
	}
	s.bottombar:setup {
		widget = wibox.container.place,
		halign = "center",
		fill_horizontal = true,
		{
			layout = wibox.layout.fixed.horizontal,
			s.tasklist,
		}
	}
end)
-- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
	awful.button({}, 3,
		function()
			RC.menu:toggle()
		end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
})

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
		end),
		awful.button({ Modkey }, 1, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({ Modkey }, 3, function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.resize(c)
		end)
	})
end)


-- }}}

-- {{{ Key bindings

awful.keyboard.append_global_keybindings({
	awful.key({ Modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({}, "Help", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ Modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
	awful.key({ Modkey }, "w", function()
		RC.menu:show()
	end, { description = "show main menu", group = "awesome" }),
	awful.key({}, "XF86HomePage", function()
		RC.menu:show()
	end, { description = "show main menu", group = "awesome" }),
	-- Layout manipulation
	awful.key({ Modkey }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),
	awful.key({ Modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }), -- Standard program
	awful.key({ Modkey }, "Return", function()
		awful.spawn.with_shell(RC.settings.terminal)
	end, { description = "open a Terminal", group = "launcher" }),
	awful.key({ Modkey, "Control" }, "r", awesome.restart,
		{ description = "reload awesome", group = "awesome" }),
	awful.key({ Modkey, "Shift" }, "q", awesome.quit,
		{ description = "quit awesome", group = "awesome" }),
	awful.key({ Modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ Modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
	awful.key({ Modkey, }, ".", function()
		machi.default_editor.start_interactive()
	end, { description = "edit the current layout if it is a machi layout", group = "layout" }),
	awful.key({ Modkey, }, "/", function()
		machi.switcher.start(client.focus)
	end, { description = "switch between windows for a machi layout", group = "layout" }),
	awful.key({ Modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }), -- Prompt
	awful.key({ Modkey }, "r", function()
		awful.spawn(RC.settings.run_prompt_cmd)
	end, { description = "run prompt", group = "launcher" }),
	awful.key({ Modkey }, "x", function()
		utils.lua_prompt()
	end, { description = "lua execute prompt", group = "awesome" }), -- Menubar
	awful.key({ Modkey }, "d", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
	awful.key({}, "Print", function()
		awful.spawn(RC.settings.screenshot_cmd, false)
	end, { description = "take a screenshot", group = "awesome" }),
	awful.key({ "Shift" }, "Print", function()
		awful.spawn(RC.settings.video_screenshot_cmd, false)
	end, { description = "take a video screenshot", group = "awesome" }),

	awful.key({ "Mod1", }, "Tab", function()
		beautiful.switcher.switch(1, "Mod1", "Alt_L", "Shift", "Tab")
		-- awesome.emit_signal("bling::window_switcher::turn_on")
	end, { description = "switch to next client", group = "awesome" }),

	awful.key({ "Mod1", "Shift" }, "Tab", function()
		beautiful.switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
	end, { description = "switch to previous client", group = "awesome" }),
	awful.key({ Modkey }, "p", foggy.menu, { description = "open monitor settings menu", group = "awesome" }),
	awful.key({ Modkey, "Shift" }, "g", function()
		utils.toggle_gaps()
	end, { description = "toggle gaps", group = "awesome" }),
	awful.key({ Modkey, "Control" }, "p", function()
		bling.module.tabbed.pop()
	end, { description = "remove client from tabbed", group = "client" }),
	awful.key({ Modkey, "Shift" }, "p", function()
		bling.module.tabbed.pick_with_dmenu()
	end, { description = "pick client to add to tabbed", group = "client" }),
	awful.key({ Modkey, "Shift" }, "n", function()
		if naughty.suspended then
			RC.flags.notif_suspend = false
			local c = client.focus
			if c and not c.fullscreen then
				naughty.resume()
				naughty.notification {
					title = "Notifications Resumed",
					message = "You'll get notifications again",
					timeout = 5,
					ignore_suspend = true
				}
			end
		else
			RC.flags.notif_suspend = true
			naughty.notification {
				title = "Notifications Suspended",
				message = "You'll no longer get notifications",
				timeout = 5,
				ignore_suspend = true
			}
			naughty.suspend()
		end
	end, { description = "suspend notifications", group = "awesome" }),
	awful.key({ Modkey, "Shift" }, "h", function()
		utils.mouse_select(function(a, o)
			local done = a.buttons[1] or false
			if done then
				naughty.notify { title = type(o) }
				if type(o) == "client" then
					done = true
					utils.dump_client(o)
				end
			end
			return not done
		end, "crosshair")
	end, { description = "get properties of client", group = "client" })
})
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ Modkey }, "f", function(c)
			if not c.fullscreen then
				c.had_smart_borders_disabled = c.disable_smart_borders
				c.disable_smart_borders = true
			elseif c.fullscreen then
				c.disable_smart_borders = c.had_smart_borders_disabled
			end
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),
		awful.key({ Modkey, "Shift" }, "c", function(c)
			c:kill()
		end, { description = "close", group = "client" }),
		awful.key({ Modkey, "Control" }, "space", awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }),
		awful.key({ Modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),
		awful.key({ Modkey }, "o", function(c)
			c:move_to_screen()
		end, { description = "move to screen", group = "client" }),
		awful.key({ Modkey }, "t", function(c)
			c.ontop = not c.ontop
		end, { description = "toggle keep on top", group = "client" }),
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
		end, { description = "(un)maximize horizontally", group = "client" }),
		awful.key({ Modkey, 'Control' }, 't', function(c)
				c.disable_smart_borders = not c.disable_smart_borders
			end,
			{ description = 'toggle title bar', group = 'client' })
	})
end)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
	-- TODO: use keygroup
	awful.keyboard.append_global_keybindings({
		awful.key({ Modkey }, "#" .. i + 9, utils.switch_to_tag(i),
			{ description = "view tag #" .. math.fmod(i, 10), group = "tag" }),
		-- Toggle tag display.
		awful.key({ Modkey, "Control" }, "#" .. i + 9, utils.toggle_tag(i),
			{ description = "toggle tag #" .. math.fmod(i, 10), group = "tag" }),
		-- Move client to tag.
		awful.key({ Modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, { description = "move focused client to tag #" .. math.fmod(i, 10), group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, { description = "toggle focused client on tag #" .. math.fmod(i, 10), group = "tag" }) })
end




-- Set keys
--root.keys(RC.globalkeys)
-- }}}

RC.rules = require("rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end
	-- awful.ewmh.client_geometry_requests(c, , {})

	if awesome.startup and not c.size_hints.user_position and
		not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
	-- if c.class == "peek" or c.class == "Peek" or c.class == "gnome-disks" or c.class == "Gnome-disks" then
	-- 	awful.titlebar.hide(c,"left")
	-- 	awful.titlebar.hide(c,"right")
	-- 	awful.titlebar.hide(c,"top")
	-- 	awful.titlebar.hide(c,"bottom")
	-- end
end)


-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::press", function(c)
	c:emit_signal("request::activate", "mouse_press", { raise = false })
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
	c.screen.title_display.text = c.name
	c.screen.focused_client = c
end)
client.connect_signal("property::name", function(c)
	if c.screen.focused_client then
		if c.screen.focused_client.window == c.window then
			c.screen.title_display.text = c.name
		end
	end
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
	if c.screen.focused_client then
		c.screen.title_display.text = ""
		c.screen.focused_client = nil
	end
end)
-- screen.connect_signal("list", function(a)
-- 	naughty.notify{title="list",text=gears.debug.dump_return(a),timeout=0}
-- end)
--
-- screen.connect_signal("added", function(s)
-- 	naughty.notify{title="added",text=gears.debug.dump_return(s),timeout=0}
-- 	for k, v in pairs(s.outputs) do
-- 		naughty.notify { title=k, text=gears.debug.dump_return(v), timeout=0}
-- 	end
-- end)
-- screen.connect_signal("removed", function(s)
-- 	naughty.notify{title="removed",text=gears.debug.dump_return(s),timeout=0}
-- 	for k, v in pairs(s.outputs) do
-- 		naughty.notify { title=k, text=gears.debug.dump_return(v), timeout=0}
-- 	end
-- end)
-- }}}

awful.screen.connect_for_each_screen(set_screen_dpi)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

require("collision")() -- {
--        Normal        Xephyr         Vim      G510
-- up    = { "Up"    , "k"   --[[, "F15" ]]},
-- down  = { "Down"  , "j"   --[[, "F14" ]]},
-- left  = { "Left"  , "h"   --[[, "F13" ]]},
-- right = { "Right" , "l"   --[[, "F17" ]]},
--}



client.connect_signal("property::urgent", function(c)
	if c.class ~= "microsoft teams - preview"
		and c.class ~= "Microsoft Teams - Preview"
		and c.class ~= "whatsapp-nativefier-d40211"
		and c.class ~= "signal" and c.class ~= "Signal"
		and c.class ~= "discord"
	then
		-- awful.spawn.easy_async_with_shell("xprop -id "..c.window, function(out)
		-- 	naughty.notification {
		-- 		title = c.name,
		-- 		text = out,
		-- 		timeout = 0
		-- 	}
		-- end)
		c:jump_to()
	else
		c.urgent = false
	end
end)

-- local function update_naughty_suspended()
--     local c = client.focus
--     if c and ((c.fullscreen and not naughty.suspended) or c.suspend_notifications) then
--         -- naughty.notification {
--         -- 	title   = "Notifications Suspended",
--         -- 	message = "You'll no longer get notifications",
--         -- 	timeout = 5
--         -- }
--         naughty.suspend()
--         return
--     end
--     if naughty.suspended and not RC.flags.notif_suspend then
--         naughty.resume()
--         -- naughty.notification {
--         -- 	title   = "Notifications Resumed",
--         -- 	message = "You'll get notifications again",
--         -- 	timeout = 5
--         -- }
--     end
-- end

-- local function update_fullscreen_titlebar(c)
-- 	if c.fullscreen then
-- 		c.had_smart_borders_disabled = c.disable_smart_borders
-- 		c.disable_smart_borders = true
-- 	elseif not c.fullscreen then
-- 		c.disable_smart_borders = c.had_smart_borders_disabled
-- 	end
-- end

--client.connect_signal("property::fullscreen", update_naughty_suspended)
-- client.connect_signal("property::fullscreen", update_fullscreen_titlebar)
-- client.connect_signal("focus", update_naughty_suspended)
-- client.connect_signal("unfocus", update_naughty_suspended)
-- tag.connect_signal("tagged", update_naughty_suspended)
-- tag.connect_signal("property::selected", update_naughty_suspended)


naughty.config.defaults.screen = math.min(screen.count(), 3)
naughty.config.image_animations_enabled = true
--naughty.config.persistence_enabled = true
naughty.config.defaults.max_width = dpi(400, naughty.config.defaults.screen)
naughty.config.defaults.position = screen.count() > 1 and "top_left" or "top_right"
-- screen[1]:split({((5120-1920)/2)/5120, 1920/5120, ((5120-1920)/2)/5120})

-- for s in screen do
-- tags.maketags(s)
-- end

--utils.handle_autostart()
