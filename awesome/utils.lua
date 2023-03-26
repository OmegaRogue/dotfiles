local utils = {}
local awful = require("awful")
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")
local settings = require('settings')
local gears = require('gears')
local menubar = require("menubar")
local naughty = require("naughty")

utils.switch_to_tag = function(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end

utils.toggle_tag = function(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end

utils.lua_prompt = function()
	awful.prompt.run {
		prompt = markup.fontcolor(beautiful.powerline_font, beautiful.bg_normal, beautiful.bg_focus, "\u{E0B0}") ..
		markup.bg.color(beautiful.bg_focus, "<span rise=\"3pt\" >\u{00A0}awesome\u{00A0}</span>") ..
		markup.fontcolor(beautiful.powerline_font, beautiful.bg_focus, "#3465a4", "\u{E0B0}") ..
		markup.color("#2e3436", "#3465a4", "<span rise=\"3pt\" >\u{00A0}" .. _VERSION .. "\u{00A0}</span>") ..
		markup.fontcolor(beautiful.powerline_font, "#3465a4", beautiful.bg_normal, "\u{E0B0}") .. "\u{00A0} ",
		textbox = awful.screen.focused().mypromptbox.widget,
		exe_callback = awful.util.eval,
		history_path = awful.util.get_cache_dir() .. "/history_eval"
	}
end

utils.toggle_gaps = function()
	if awful.screen.focused().selected_tag.gap == 0 then
		awful.screen.focused().selected_tag.gap = beautiful.useless_gap
	else
		awful.screen.focused().selected_tag.gap = 0
	end
end

utils.change_volume = function(amount)
	local amount_str = tostring(amount)
	if amount >= 0 then
		amount_str = "+" .. amount_str
	end
	awful.spawn.with_shell(settings.set_volume_cmd:gsub("%$v", amount_str))
end

utils.set_volume = function(amount)
	awful.spawn.with_shell(settings.set_volume_cmd:gsub("%$v", tostring(amount)))
end

utils.set_wallpaper = function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.tiled(wallpaper, s, nil)
	end
end

utils.handle_autostart = function()
	menubar.utils.parse_dir("/etc/xdg/autostart", function(a)
		local autostart_apps = {}
		for v in a do
			autostart_apps[v.Name] = v
		end
		menubar.utils.parse_dir(os.getenv("XDG_CONFIG_HOME").."/autostart", function(b)
			for v in b do
				autostart_apps[v.Name] = v
			end
			for v in autostart_apps do
				if v.Hidden ~= true then
					awful.spawn(v.cmdline)
				end
			end
		end)
	end)
end

utils.update_screenorder = function(s)
	for k, v in pairs(s.outputs) do
		-- naughty.notify { title=k, text=gears.debug.dump_return(v), timeout=0}
		if k == 'HDMI-0' then
			Screenorder[1] = v.viewport_id
		elseif k == 'DP-5' then
			Screenorder[2] = v.viewport_id
		elseif k == 'DP-3' or k == 'DP-1' then
			Screenorder[3] = v.viewport_id
		elseif k == 'DP-4' then
			Screenorder[1] = v.viewport_id
			Screenorder[2] = v.viewport_id
		end
	end
end

utils.init_screenorder = function()
	Screenorder = { 1, 2, 3 }
	for s in screen do
		utils.update_screenorder(s)
	end
end

utils.screen_fallback = function(x)
	return math.min(screen.count(),x)
end
--- Get the config dirs according to the XDG basedir specification.
-- @return the config dirs (XDG_CONFIG_DIRS) with a slash at the end.
-- @staticfct utils.get_xdg_config_dirs
utils.get_xdg_config_dirs = function()
	local dirs={}
	for _, v in ipairs(gears.string.split((os.getenv("XDG_CONFIG_DIRS") or "/etx/xdg"), ":")) do
		dirs[#dirs+1]=v.."/"
	end
	return dirs
end
utils.dump_client = function(c)
	local temp = {
		name = c.name,
		window = c.window,
		skip_taskbar = c.skip_taskbar,
		type = c.type,
		class = c.class,
		instance = c.instance,
		pid = c.pid,
		role = c.role,
		machine = c.machine,
		icon_name = c.icon_name,
		icon_sizes = c.icon_sizes,
		screen = c.screen.index,
		hidden = c.hidden,
		minimized = c.minimized,
		size_hints_honor = c.size_hints_honor,
		border_width                  = c.border_width,
		urgent                        = c.urgent,
		opacity                       = c.opacity,
		ontop                         = c.ontop,
		above                         = c.above,
		below                         = c.below,
		fullscreen                    = c.fullscreen,
		maximized                     = c.maximized,
		maximized_horizontal          = c.maximized_horizontal,
		maximized_vertical            = c.maximized_vertical,
		group_window                  = c.group_window,
		leader_window                 = c.leader_window,
		size_hints                    = c.size_hints,
		motif_wm_hints                = c.motif_wm_hints,
		sticky                        = c.sticky,
		modal                         = c.modal,
		focusable                     = c.focusable,
		startup_id                    = c.startup_id,
		transient_for = c.transient_for ~= nil,
		valid                         = c.valid,
		marked                        = c.marked,
		is_fixed                      = c.is_fixed,
		immobilized_horizontal        = c.immobilized_horizontal,
		immobilized_vertical          = c.immobilized_vertical,
		floating                      = c.floating,
		x                             = c.x,
		y                             = c.y,
		width                         = c.width,
		height                        = c.height,
		dockable                      = c.dockable,
		requests_no_titlebar          = c.requests_no_titlebar,
		active                        = c.active
	}
	gears.debug.print_warning(gears.debug.dump_return(temp))
end
--debug_out = "" menubar.utils.parse_dir(os.getenv("XDG_CONFIG_HOME").."/autostart", function(a) local buffer = {} for k, v in ipairs(a) do if v.Exec ~= v.cmdline then buffer[k] = v end end debug_out = debug_out .. gears.debug.dump_return(buffer) end)

return utils
