---------------------------
-- Default awesome theme --
---------------------------
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require('gears')
local wibox = require("wibox")

local gfs = require("gears.filesystem")
local lain = require("lain")
local markup = lain.util.markup
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")
local utils = require("utils")

local theme = {}

local gtk = beautiful.gtk.get_theme_variables()

theme.font = "JetBrainsMono Nerd Font 12"
--theme.dir = os.getenv("HOME") .. "/.config/awesome"
theme.hotkeys_font = "JetBrainsMono Nerd Font ExtraBold 12"
theme.hotkeys_description_font = theme.font
--theme.bg_normal = "#222222"
theme.bg_normal = gtk.bg_color
--theme.bg_focus = "#585858"
theme.bg_focus = "#3c3b38" --wm_border_focused_color 87a556ff
theme.bg_urgent = "#d75f00"
theme.bg_minimize = "#444444"
theme.bg_systray = theme.bg_focus
theme.bg_selected = gtk.selected_bg_color
theme.fg_selected = gtk.selected_fg_color
theme.fg_normal = gtk.fg_color
--theme.fg_normal = "#aaaaaa" -- gtk.fg_color
theme.fg_focus = "#d0d0d0"
theme.fg_urgent = "#ffd700"
theme.fg_minimize = "#ffffff"
theme.hotkeys_modifiers_fg = theme.fg_focus
theme.wibar_height = dpi(25)

-- theme.opacity_active = 1.0
-- theme.opacity_normal = 0.8

theme.task_preview_widget_border_radius = dpi(10)
theme.task_preview_widget_border_color = "#555555"
theme.tag_preview_widget_border_radius = dpi(10)
-- theme.tag_preview_client_border_radius = 10
theme.tag_preview_widget_border_color = "#555555"
theme.tag_preview_client_border_color = "#555555"
theme.tag_preview_client_opacity = 1

theme.useless_gap = dpi(3,1)
theme.snapper_gap = theme.useless_gap
theme.gap_single_client = false
theme.border_width = dpi(0)
theme.border_normal = "#555555" --gtk.wm_border_unfocused_color --"#626262"
theme.border_focus = "#666666"  --gtk.wm_bg_color, 1) --"#535d6c"
theme.border_marked = "#91231c"

theme.widget_mem = "\u{e266} "           --
theme.widget_cpu = "\u{f85a} "           --
theme.widget_ac = "\u{f492} "            --
theme.widget_battery = "\u{f578} "       --
theme.widget_battery_low = "\u{f492} "   --
theme.widget_battery_empty = "\u{f492} " --
theme.widget_battery_percent = function(charge, status)
    if status == "N/A" then
        return "\u{f590}"  --
    elseif status == "Full" then
        return "\u{f578} " --
    elseif status == "Discharging" then
        if charge == "N/A" then
            return "\u{f590}" --
        elseif charge <= 5 then
            return "\u{f582}" --
        elseif charge <= 10 then
            return "\u{f579}" --
        elseif charge <= 20 then
            return "\u{f57a}" --
        elseif charge <= 30 then
            return "\u{f57b}" --
        elseif charge <= 40 then
            return "\u{f57c}" --
        elseif charge <= 50 then
            return "\u{f57d}" --
        elseif charge <= 60 then
            return "\u{f57e}" --
        elseif charge <= 70 then
            return "\u{f57f}" --
        elseif charge <= 80 then
            return "\u{f580}" --
        elseif charge <= 90 then
            return "\u{f581}" --
        elseif charge <= 100 then
            return "\u{f578}" --
        end
    elseif status == "Charging" then
        if charge == "N/A" then
            return "\u{f590}" --
        elseif charge <= 20 then
            return "\u{f585}" --
        elseif charge <= 30 then
            return "\u{f586}" --
        elseif charge <= 40 then
            return "\u{f587}" --
        elseif charge <= 60 then
            return "\u{f587}" --
        elseif charge <= 80 then
            return "\u{f589}" --
        elseif charge <= 90 then
            return "\u{f58a}" --
        elseif charge <= 100 then
            return "\u{f584}" --
        end
    end
end

theme.powerline_font = "JetBrainsMono Nerd Font 18"
theme.icon_font = "JetBrainsMono Nerd Font 18"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(20)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal)
--theme.taglist_shape =  function(cr, width, height)
--    return gears.shape.powerline(cr,18,30)
--end


-- Variables set for theming notifications:

-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]
theme.notification_font = "Atkinson Hyperlegible Regular 18"
theme.notification_shape = function(cr, width, height)
    return gears.shape.rounded_rect(cr, width, height, dpi(5))
end

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_submenu_icon = themes_path .. "default/submenu.png"

theme.menu_height = theme.wibar_height
theme.menu_width = dpi(250)



--theme.taglist_fg_focus = '#197600'
theme.taglist_fg_focus = theme.fg_selected
theme.taglist_bg_focus = '#aedd00'
theme.taglist_bg_focus = theme.bg_selected
theme.taglist_font = theme.font
theme.taglist_fg_normal = "#DCDCCC"
theme.taglist_bg_normal = theme.bg_normal
theme.taglist_squares_sel = theme_assets.taglist_squares_unsel(dpi(4), theme.taglist_fg_focus)
theme.taglist_squares_unsel = theme.taglist_squares_sel

-- theme.tasklist_shape = gears.shape.powerline
theme.tasklist_font_focus = "Atkinson Hyperlegible Bold 14"
theme.tasklist_font = "Atkinson Hyperlegible 14"
theme.tasklist_align = 'center'
theme.tasklist_spacing = 0
theme.tasklist_shape_border_width = 0
theme.tasklist_shape_border_width_focus = 0

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"
require('smart_borders') {
    stealth = false,
    show_button_tooltips = false,
    show_title_tooltip = false,
    align_horizontal = "center",
    color_normal = theme.border_normal, --"#555555",
    color_focus = theme.border_focus,   --"#666666",
    --color_floating = "#886688",
    button_size = dpi(40),
    button_floating_size = dpi(60),
    button_close_size = dpi(60),
    --rounded_corner = dpi(0),
    snapping = false,
    snapping_max_distance = theme.useless_gap,
    snapping_center_mouse = true,
    border_width = dpi(6),
    color_close_normal = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(60), 0 },
        stops = { { 0, "#fd8489" }, { 1, "#555555" } }
    },
    color_close_focus = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(60), 0 },
        stops = { { 0, "#fd8489" }, { 1, "#666666" } }
    },
    color_close_hover = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(60), 0 },
        stops = { { 0, "#FF9EA3" }, { 1, "#666666" } }
    },
    color_floating_normal = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(40), 0 },
        stops = { { 0, "#555555" }, { 1, "#ddace7" } }
    },
    color_floating_focus = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(40), 0 },
        stops = { { 0, "#666666" }, { 1, "#ddace7" } }
    },
    color_floating_hover = {
        type = "linear",
        from = { 0, 0 },
        to = { dpi(40), 0 },
        stops = { { 0, "#666666" }, { 1, "#F7C6FF" } }
    },
    custom_menu_entries = {
        -- for every client:
        [".*"] = {
            {
                text = "toggle titlebar",
                func = function(c)
                    c.disable_smart_borders = not c.disable_smart_borders
                end
            },
        }
    },

    -- hot_corners = {
    --     ["top_left"] = {
    --         enter = function()
    --             RC.menu:show()
    --         end,
    --     }
    -- }
}

local switcher = require("awesome-switcher")
switcher.settings.preview_box_bg = theme.bg_focus .. "aa" -- background color
switcher.settings.preview_box_border = theme.border_focus .. "00"
switcher.settings.preview_box_title_color = { 1, 1, 1, 1 }
switcher.settings.preview_box_title_font = { theme.font, "sans", "italic", "normal" }
switcher.settings.client_opacity = true
theme.switcher = switcher

theme.window_switcher_name_font = "Atkinson Hyperlegible 14" -- The font of all titles
theme.window_switcher_widget_bg = "#00000055"
theme.window_switcher_widget_border_radius = dpi(0)
theme.window_switcher_widget_border_color = theme.border_normal
theme.window_switcher_widget_border_width = dpi(6)
theme.window_switcher_clients_spacing = dpi(20)               -- The space between each client item
theme.window_switcher_client_icon_horizontal_spacing = dpi(5) -- The space between client icon and text
theme.window_switcher_client_width = dpi(150)                 -- The width of one client widget
theme.window_switcher_client_height = dpi(250)                -- The height of one client widget
theme.window_switcher_client_margins = dpi(10)                -- The margin between the content and the border of the widget
theme.window_switcher_thumbnail_margins = dpi(10)             -- The margin between one client thumbnail and the rest of the widget
theme.window_switcher_name_margins = dpi(10)                  -- The margin of one clients title to the rest of the widget
theme.window_switcher_name_forced_width = dpi(200)            -- The width of one title
theme.window_switcher_icon_width = dpi(40)                    -- The width of one icon
theme.window_switcher_name_normal_color = theme.fg_color      -- The color of one title if the client is unfocused
theme.window_switcher_name_focus_color = theme.fg_focus       -- The color of one title if the client is focused





theme.wallpaper = os.getenv("HOME") ..
    -- "/Pictures/Factorio 1080p Wallpaper/factorio-wallpaper-4-1920x1080.jpg"
    "/Pictures/Factorio 1080p Wallpaper/factorio-wallpaper-2-2560x1440.jpg"


-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. "default/layouts/fairhw.png"
theme.layout_fairv = themes_path .. "default/layouts/fairvw.png"
theme.layout_floating = themes_path .. "default/layouts/floatingw.png"
theme.layout_magnifier = themes_path .. "default/layouts/magnifierw.png"
theme.layout_max = themes_path .. "default/layouts/maxw.png"
theme.layout_fullscreen = themes_path .. "default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_tiletop = themes_path .. "default/layouts/tiletopw.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"
theme.layout_dwindle = themes_path .. "default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path .. "default/layouts/cornernww.png"
theme.layout_cornerne = themes_path .. "default/layouts/cornernew.png"
theme.layout_cornersw = themes_path .. "default/layouts/cornersww.png"
theme.layout_cornerse = themes_path .. "default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height,
    theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = "gnome"

theme.widget_margin = dpi(6)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
