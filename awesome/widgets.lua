---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by omegarogue.
--- DateTime: 17.02.22 15:23
---

local awesome = awesome
local widgets = {}

-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local lain = require("lain")
local markup = lain.util.markup

local omegavoid = require('omegavoid')
local powerline = omegavoid.widget.powerline
local foggy = require('foggy')

widgets.baticon = wibox.widget.textbox(beautiful.widget_battery)
widgets.baticon.font = beautiful.icon_font

widgets.bat = lain.widget.bat({
    battery = "BAT1",
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            widgets.baticon:set_text(beautiful.widget_battery_percent(bat_now.perc, bat_now.status).." ")

            widget:set_markup(markup.font(beautiful.font, bat_now.perc .. "% "))
        else
            widget:set_markup(markup.font(beautiful.font, "AC "))
            widgets.baticon:set_text(beautiful.widget_ac)
        end
    end
})

widgets.time = wibox.widget {
    format = '<span foreground="#9e9e9e"> %Y-%m-%d </span>',
    widget = wibox.widget.textclock
}

-- widgets.cal = lain.widget.cal({
--     --attach_to = { powerline_widget, time },
--     attach_to = { widgets.time },
--     notification_preset = { font = beautiful.font, fg = beautiful.fg_normal, bg = beautiful.bg_normal },
--     cal = "/usr/bin/env TERM=linux /usr/bin/cal --color=always"
-- })
--widgets.cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
widgets.cpuicon = wibox.widget.textbox(beautiful.widget_cpu)
widgets.cpuicon.font = beautiful.icon_font

widgets.cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, "" .. string.format("%3s", cpu_now.usage) .. "% "))
        --widget:set_markup(markup.font(beautiful.font, " " .. cpu_now.usage .. "% "))
    end
})
--widgets.memicon = wibox.widget.imagebox(beautiful.widget_mem)
widgets.memicon = wibox.widget.textbox(beautiful.widget_mem)
widgets.memicon.font = beautiful.icon_font
widgets.mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, "" .. string.format("%3s", mem_now.perc) .. "% "))
        --widget:set_markup(markup.font(beautiful.font, "" .. mem_now.used .. "MB "))
    end
})
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

widgets.calendar = calendar_widget({
    theme = 'outrun',
    placement = 'top_right',
    start_sunday = true,
    radius = 8,
-- with customized next/previous (see table above)
    previous_month_button = 1,
    next_month_button = 3,
})

widgets.time:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then widgets.calendar.toggle() end
    end)

return widgets
