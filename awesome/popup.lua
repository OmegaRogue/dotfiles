local awful = require("awful")
local wibox = require('wibox')
local gears = require('gears')
local ruled = require('ruled')
local awesomebuttons = require("awesome-buttons.awesome-buttons")

local test = wibox.widget {
    -- forced_num_cols = 4,
    -- forced_num_rows = 7,
    -- homogeneous     = true,
    expand          = true,
	spacing = 10,
    layout = wibox.layout.grid
}
local inputtext = ""

local equation = wibox.widget.textbox("eq")
local output = wibox.widget.textbox("out")
test:add_widget_at(equation,1,1,1,3)
test:add_widget_at(output,2,1,1,4)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = ""end, text_size = 20, text = "CE"},       3, 1, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = ""end, text_size = 20, text = "C"},        3, 2, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text:sub(1, -2)end, text_size = 20, text = "\u{f56d}"}, 3, 3, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."/"end, text_size = 20, text = "\u{f6d3}"}, 3, 4, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."7"end, text_size = 20, text = "7"},        4, 1, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."8"end, text_size = 20, text = "8"},        4, 2, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."9"end, text_size = 20, text = "9"},        4, 3, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."*"end, text_size = 20, text = "\u{f655}"}, 4, 4, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."4"end, text_size = 20, text = "4"},        5, 1, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."5"end, text_size = 20, text = "5"},        5, 2, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."6"end, text_size = 20, text = "6"},        5, 3, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."-"end, text_size = 20, text = "\u{f873}"}, 5, 4, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."1"end, text_size = 20, text = "1"},        6, 1, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."2"end, text_size = 20, text = "2"},        6, 2, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."3"end, text_size = 20, text = "3"},        6, 3, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."+"end, text_size = 20, text = '\u{f914}'}, 6, 4, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ text_size = 20, text = "±"},        7, 1, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."0"end, text_size = 20, text = "0"},        7, 2, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()equation.text = equation.text.."."end, text_size = 20, text = "."},        7, 3, 1, 1)
test:add_widget_at(awesomebuttons.with_text{ onclick=function()
	output.text = tostring(load("function x() return "..equation.text.." end")())
end, text_size = 20, text = "="},        7, 4, 1, 1)


calculator = awful.popup {
    widget = {
        test,
        margins = 10,
        widget  = wibox.container.margin
    },
    border_color = "#00ff00",
    border_width = 5,
	placement    =awful.placement.centered,
    shape        = gears.shape.rounded_rect,
    visible      = true,
	ontop = true,
	-- hide_on_right_click = true,
}

calculator_visible = true
function toggle_calculator()
	if calculator_visible then
		calculator.visible = false
		calculator_visible = false
	else
		calculator_visible = true
		calculator.visible = true
		calculator:move_next_to()
	end
end

test:add_widget_at(awesomebuttons.with_icon{ icon = "x", onclick = function()toggle_calculator()end},1,4,1,1)
