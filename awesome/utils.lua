local _M = {}
local awful = require("awful")
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")
local settings = require('settings')
local gears = require('gears')
local menubar = require("menubar")
local naughty = require("naughty")
local hex2rgb = gears.color.parse_color
local floor = math.floor
local max = math.max
local min = math.min
local abs = math.abs
local dpi = beautiful.xresources.apply_dpi

_M.switch_to_tag = function(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end
end

_M.toggle_tag = function(i)
	return function()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end
end

_M.lua_prompt = function()
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

_M.toggle_gaps = function()
	if awful.screen.focused().selected_tag.gap == 0 then
		awful.screen.focused().selected_tag.gap = dpi(beautiful.useless_gap, awful.screen.focused())
	else
		awful.screen.focused().selected_tag.gap = 0
	end
end

_M.change_volume = function(amount)
	local amount_str = tostring(amount)
	if amount >= 0 then
		amount_str = "+" .. amount_str
	end
	awful.spawn.with_shell(settings.set_volume_cmd:gsub("%$v", amount_str))
end

_M.set_volume = function(amount)
	awful.spawn.with_shell(settings.set_volume_cmd:gsub("%$v", tostring(amount)))
end

_M.handle_autostart = function()
	awful.spawn.with_shell('xdg-autostart --d awesome')
	-- awful.spawn.with_shell(
	-- 	'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
	-- 	'xrdb -merge <<< "awesome.started:true";' ..
	-- 	-- list each of your autostart commands, followed by ; inside single quotes, followed by ..
	-- 	'dex --environment Awesome --autostart'
	-- )
	-- menubar._M.parse_dir("/etc/xdg/autostart", function(a)
	-- 	local autostart_apps = {}
	-- 	for v in a do
	-- 		autostart_apps[v.Name] = v
	-- 	end
	-- 	menubar._M.parse_dir(os.getenv("XDG_CONFIG_HOME") .. "/autostart", function(b)
	-- 		for v in b do
	-- 			autostart_apps[v.Name] = v
	-- 		end
	-- 		for v in autostart_apps do
	-- 			if v.Hidden ~= true then
	-- 				awful.spawn(v.cmdline)
	-- 			end
	-- 		end
	-- 	end)
	-- end)
end

_M.update_screenorder = function(s)
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

_M.init_screenorder = function()
	Screenorder = { 1, 2, 3 }
	for s in screen do
		_M.update_screenorder(s)
	end
end

_M.screen_fallback = function(x)
	return math.min(screen.count(), x)
end
--- Get the config dirs according to the XDG basedir specification.
-- @return the config dirs (XDG_CONFIG_DIRS) with a slash at the end.
-- @staticfct _M.get_xdg_config_dirs
_M.get_xdg_config_dirs = function()
	local dirs = {}
	for _, v in ipairs(gears.string.split((os.getenv("XDG_CONFIG_DIRS") or "/etx/xdg"), ":")) do
		dirs[#dirs + 1] = v .. "/"
	end
	return dirs
end
_M.dump_client = function(c)
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
		border_width = c.border_width,
		urgent = c.urgent,
		opacity = c.opacity,
	ontop = c.ontop,
		above = c.above,
		below = c.below,
		fullscreen = c.fullscreen,
		maximized = c.maximized,
		maximized_horizontal = c.maximized_horizontal,
		maximized_vertical = c.maximized_vertical,
		group_window = c.group_window,
		leader_window = c.leader_window,
		size_hints = c.size_hints,
		motif_wm_hints = c.motif_wm_hints,
		sticky = c.sticky,
		modal = c.modal,
		focusable = c.focusable,
		startup_id = c.startup_id,
		transient_for = c.transient_for ~= nil,
		valid = c.valid,
		marked = c.marked,
		is_fixed = c.is_fixed,
		immobilized_horizontal = c.immobilized_horizontal,
		immobilized_vertical = c.immobilized_vertical,
		floating = c.floating,
		x = c.x,
		y = c.y,
		width = c.width,
		height = c.height,
		dockable = c.dockable,
		requests_no_titlebar = c.requests_no_titlebar,
		active = c.active
	}
	gears.debug.print_warning(gears.debug.dump_return(temp))
	return gears.debug.dump_return(temp)
end
--debug_out = "" menubar._M.parse_dir(os.getenv("XDG_CONFIG_HOME").."/autostart", function(a) local buffer = {} for k, v in ipairs(a) do if v.Exec ~= v.cmdline then buffer[k] = v end end debug_out = debug_out .. gears.debug.dump_return(buffer) end)

_M.hex2hsv = function(color)
	local r, g, b = hex2rgb(color)
	local C_max = max(r, g, b)
	local C_min = min(r, g, b)
	local delta = C_max - C_min
	local H, S, V
	if delta == 0 then
		H = 0
	elseif C_max == r then
		H = 60 * (((g - b) / delta) % 6)
	elseif C_max == g then
		H = 60 * (((b - r) / delta) + 2)
	elseif C_max == b then
		H = 60 * (((r - g) / delta) + 4)
	end
	if C_max == 0 then
		S = 0
	else
		S = delta / C_max
	end
	V = C_max
	return H, S * 100, V * 100
end
_M.hsv2hex = function(H, S, V)
	S = S / 100
	V = V / 100
	if H > 360 then H = 360 end
	if H < 0 then H = 0 end
	local C = V * S
	local X = C * (1 - abs(((H / 60) % 2) - 1))
	local m = V - C
	local r_, g_, b_ = 0, 0, 0
	if H >= 0 and H < 60 then
		r_, g_, b_ = C, X, 0
	elseif H >= 60 and H < 120 then
		r_, g_, b_ = X, C, 0
	elseif H >= 120 and H < 180 then
		r_, g_, b_ = 0, C, X
	elseif H >= 180 and H < 240 then
		r_, g_, b_ = 0, X, C
	elseif H >= 240 and H < 300 then
		r_, g_, b_ = X, 0, C
	elseif H >= 300 and H < 360 then
		r_, g_, b_ = C, 0, X
	end
	local r, g, b = (r_ + m) * 255, (g_ + m) * 255, (b_ + m) * 255
	return ("#%02x%02x%02x"):format(floor(r), floor(g), floor(b))
end


_M.hex2hsl = function(color)
	local r, g, b = hex2rgb(color)
	local v = max(r, g, b)
	local c = v - min(r, g, b)
	local f = 1 - abs(v + v - c - 1)
	local h = c and ((v == r) and (g - b) / c or ((v == g) and 2 + (b - r) / c or 4 + (r - g) / c))
	return 60 * ((h < 0) and h + 6 or h), f and c / f or 0, (v + v - c) / 2
	-- local C_max = max(r, g, b)
	-- local C_min = min(r, g, b)
	-- local delta = C_max - C_min
	-- local H, S, L
	-- if delta == 0 then
	--     H = 0
	-- elseif C_max == r then
	--     H = 60 * (((g - b) / delta) % 6)
	-- elseif C_max == g then
	--     H = 60 * (((b - r) / delta) + 2)
	-- elseif C_max == b then
	--     H = 60 * (((r - g) / delta) + 4)
	-- end
	-- if C_max == 0 then
	--     S = 0
	-- else
	--     S = delta / C_max
	-- end
	-- L = 0.5*(C_max+C_min)
	-- return H, S * 100, L * 100
end

_M.hsl2hex = function(H, S, L)
	S = S / 100
	L = L / 100
	local a = S * min(L, 1 - L)
	local function f(n)
		local k = math.fmod(n + H / 30, 12)
		return L - a * max(min(k - 3, 9 - k, 1), -1)
	end
	-- local r_, g_, b_ = 0, 0, 0
	-- if S == 0 then
	-- 	r_ = L
	-- 	g_ = L
	-- 	b_ = L
	-- else
	-- 	local q = L < 0.5 and L*(1+S) or L+S-L*S
	-- 	local p = 2*L-q
	-- 	r_ = hue2rgb(p,q,H+1/2)
	-- 	g_ = hue2rgb(p,q,H)
	-- 	b_ = hue2rgb(p,q,H-1/3)
	-- end
	local r, g, b = f(0) * 255, f(8) * 255, f(4) * 255
	return ("#%02x%02x%02x"):format(floor(r), floor(g), floor(b))
end

_M.clamp = function(x, lower, upper)
	if lower > upper then lower, upper = upper, lower end
	return max(lower, min(upper, x))
end
local clamp = _M.clamp
_M.shade = function(color, factor)
	local H, S, L = _M.hex2hsl(color)
	L = clamp(L * factor, 0, 1)
	S = clamp(S * factor, 0, 1)
	return _M.hsl2hex(H, S, L)
end


_M.mouse_select = function(func, cursor)
	mousegrabber.run(function(a)
		local o = mouse.object_under_pointer()
		return func(a, o)
	end, cursor)
end

return _M
