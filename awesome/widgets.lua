---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by omegarogue.
--- DateTime: 17.02.22 15:23
---

local awesome = awesome
local _M = {}

-- Widget and layout library
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local lain = require("lain")
local markup = lain.util.markup

local omegavoid = require('omegavoid')
local powerline = omegavoid.widget.powerline
local foggy = require('foggy')

local dpi = beautiful.xresources.apply_dpi
local markup = lain.util.markup
local fenetre = require("fenetre")

_M.baticon = wibox.widget.textbox(beautiful.widget_battery)
_M.baticon.font = beautiful.icon_font

_M.bat = lain.widget.bat({
	battery = "BAT1",
	settings = function()
		if bat_now.status and bat_now.status ~= "N/A" then
			_M.baticon:set_text(beautiful.widget_battery_percent(bat_now.perc, bat_now.status) .. " ")

			widget:set_markup(markup.font(beautiful.font, bat_now.perc .. "% "))
		else
			widget:set_markup(markup.font(beautiful.font, "AC "))
			_M.baticon:set_text(beautiful.widget_ac)
		end
	end
})

_M.date = wibox.widget {
	format = '<span foreground="#9e9e9e"> %Y-%m-%d </span>',
	widget = wibox.widget.textclock
}

_M.time = wibox.widget {
	format = '<span foreground="#d0d0d0"> %H:%M </span>',
	widget = wibox.widget.textclock
}

_M.cpuicon = wibox.widget.textbox(beautiful.widget_cpu)
_M.cpuicon.font = beautiful.icon_font

_M.cpu = lain.widget.cpu({
	settings = function()
		widget:set_markup(markup.font(beautiful.font, "" .. string.format("%3s", cpu_now.usage) .. "% "))
	end
})
_M.memicon = wibox.widget.textbox(beautiful.widget_mem)
_M.memicon.font = beautiful.icon_font
_M.mem = lain.widget.mem({
	settings = function()
		widget:set_markup(markup.font(beautiful.font, "" .. string.format("%3s", mem_now.perc) .. "% "))
	end
})

local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

_M.calendar = calendar_widget({
	placement = 'top_right',
	start_sunday = false,
	radius = 8,
	previous_month_button = 3,
	next_month_button = 1,
})

_M.time:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then
			_M.calendar.toggle()
		end
	end)
_M.date:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then
			_M.calendar.toggle()
		end
	end)
_M.launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	clip_shape = gears.shape.transform(gears.shape.rectangular_tag):rotate_at(15, 15, math.pi),
	menu = require('menu')
})
_M.taglist = function(s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t) t:view_only() end),
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
			end)
		},
		style = {
			shape = gears.shape.powerline,
			bg_empty = beautiful.bg_normal,
			bg_occupied = beautiful.bg_normal,
		},
		layout = {
			spacing = dpi(-14, s),
			layout = wibox.layout.fixed.horizontal
		},

		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					{
						id = "seperator_role",
						widget = wibox.widget.separator,
						color = beautiful.bg_focus,
						shape = gears.shape.powerline,
						forced_width = dpi(18, s),
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = dpi(24, s),
				-- right = 24,
				widget = wibox.container.margin
			},
			id = "background_role",
			widget = wibox.container.background,
			-- Add support for hover colors and an index label
			create_callback = function(self, c3, index, objects)
				--luacheck: no unused args
				self:get_children_by_id("text_role")[1].markup = "<b> " .. c3.name .. " </b>"

				if c3.selected and index < #s.tags and s.tags[index + 1].selected then
					self:get_children_by_id("seperator_role")[1].color = beautiful.taglist_fg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				elseif not c3.selected and index < #s.tags and not s.tags[index + 1].selected then
					self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				elseif not c3.selected and index == #s.tags then
					self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				else
					self:get_children_by_id("seperator_role")[1].color = "#ffffff00"
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.rectangle
				end
			end,
			update_callback = function(self, c3, index, objects)
				--luacheck: no unused args
				self:get_children_by_id("text_role")[1].markup = "<b> " .. c3.name .. " </b>"

				if c3.selected and index < #s.tags and s.tags[index + 1].selected then
					self:get_children_by_id("seperator_role")[1].color = beautiful.taglist_fg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				elseif not c3.selected and index < #s.tags and not s.tags[index + 1].selected then
					self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				elseif not c3.selected and index == #s.tags then
					self:get_children_by_id("seperator_role")[1].color = beautiful.bg_focus
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.powerline
				else
					self:get_children_by_id("seperator_role")[1].color = "#ffffff00"
					self:get_children_by_id("seperator_role")[1].shape = gears.shape.rectangle
				end
			end,
		},
	}
end

_M.tasklist = function(s)
	return awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({}, 1, function(c) c:activate { context = "tasklist", action = "toggle_minimization" } end),
			awful.button({}, 2, function() awful.menu.client_list { theme = { width = 250 } } end),
			awful.button({}, 3, function(c) c:emit_signal("smart_borders::right_click") end),
			awful.button({}, 4, function() awful.client.focus.byidx(1) end),
			awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
		},
	}
end

_M.titlebar = fenetre {
	order = {"max", "seperator", "title", "seperator", "sticky"},
	title_edit = function()
		-- Remove " - Mozilla Firefox" from the ends of firefox's titles
		local replacements = {
			"— Mozilla Firefox",
			"— Mozilla Firefox (Private Browsing)",
			"- Discord",
			"— Evolution"
		}
		for _, v in ipairs(replacements) do
			if title:sub(-v:len()) == v then
				title = title:gsub(" %" .. v, "")
			end
		end
	end,
}
return _M
