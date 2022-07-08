local utils = {}
local awful = require("awful")
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")
local settings = require('settings')
local gears = require('gears')
local menubar = require("menubar")

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
        gears.wallpaper.maximized(wallpaper, s, true)
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

--debug_out = "" menubar.utils.parse_dir(os.getenv("XDG_CONFIG_HOME").."/autostart", function(a) local buffer = {} for k, v in ipairs(a) do if v.Exec ~= v.cmdline then buffer[k] = v end end debug_out = debug_out .. gears.debug.dump_return(buffer) end)

return utils
