local awful = require("awful")

local bling = require("bling")

local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- local sharedtags = require("sharedtags")

local _M = {}

_M.maketags = function(s)
    for k, v in pairs(s.tags) do
        v:delete()
    end
    awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    -- TODO: handle variable display configurations
	awful.tag.add("Browser", { layout = awful.layout.layouts[1], screen = s})
    awful.tag.add(s.index == math.min(screen.count(), 3) and "Messenger" or "7", { layout = awful.layout.layouts[6], screen = s, gap = 0 })
    awful.tag.add(s.index == 1 and "Teams" or "8", { layout = awful.layout.layouts[2], screen = s, gap = 0 })
    awful.tag.add(s.index == math.min(screen.count(), 2) and "Mail" or s.index == 1 and "TTRPG" or "9", { layout = awful.layout.layouts[1], screen = s, gap = 0 })
    awful.tag.add(s.index == math.min(screen.count(), 3) and "Discord" or "0", { layout = awful.layout.layouts[2], screen = s, gap = 0 })
	for _, v in pairs(s.tags) do
        v.gaps = dpi(beautiful.useless_gap,s)
    end

end

-- tags.shared = sharedtags({
--     { name = "1", layout = awful.layout.layouts[1] },
--     { name = "2", layout = awful.layout.layouts[1] },
--     { name = "3", layout = awful.layout.layouts[1] },
--     { name = "4", layout = awful.layout.layouts[1] },
--     { name = "5", layout = awful.layout.layouts[1] },
--     { name = "Teams", screen = Screenorder[1], layout = awful.layout.layouts[2] },
--     { name = "Mail", screen = Screenorder[2], layout = awful.layout.layouts[3] },
--     { name = "Discord", screen = Screenorder[3], layout = awful.layout.layouts[2] },
--     { name = "Messenger", screen = Screenorder[3], layout = awful.layout.layouts[6] },
-- })

return _M
