---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by omegarogue.
--- DateTime: 06.06.22 17:15
---

local _M = {}

local awful = require("awful")
local utils = require('utils')
local gears = require('gears')
local foggy = require('foggy')

awful.keyboard.append_global_keybindings({ awful.key({}, "XF86MonBrightnessUp", function()
	foggy.shortcuts.inc_backlight(10, 1)
end),
	awful.key({}, "XF86MonBrightnessDown", function()
		foggy.shortcuts.inc_backlight(-10, 1)
	end),
	awful.key({}, "XF86TouchpadToggle", function()
	end),
	awful.key({}, "XF86WebCam", function()
	end),
	awful.key({}, "XF86AudioRaiseVolume", function()
		--awful.spawn.with_shell(RC.settings.raise_volume_cmd)
		utils.change_volume(5)
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		--awful.spawn.with_shell(RC.settings.lower_volume_cmd)
		utils.change_volume(-5)
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn(RC.settings.volume_mute_cmd)
	end),
	awful.key({}, "XF86AudioPlay", function()
		RC.playerctl:play_pause()
	end),
	awful.key({}, "XF86AudioNext", function()
		RC.playerctl:next()
	end),
	awful.key({}, "XF86AudioPrev", function()
		RC.playerctl:previous()
	end),
	awful.key({}, "#+120", function()
		awful.spawn(RC.settings.run_prompt_cmd)
	end),
	awful.key({}, "XF86Search", function()
		awful.spawn(RC.settings.run_prompt_cmd)
	end),
	awful.key({}, "XF86Favorites", function()
		awful.spawn(RC.settings.run_prompt_cmd)
	end) })


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 5 do
	awful.keyboard.append_global_keybinding(awful.key({}, "XF86Launch" .. i + 4, utils.toggle_tag(i)))
end

return _M
