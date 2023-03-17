local awful = require("awful")

local bling = require("bling")
-- local sharedtags = require("sharedtags")

local tags = {}

tags.maketags = function(s)

	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
	-- TODO: handle variable display configurations
	awful.tag.add(s.index == Screenorder[3] and "Messenger" or "6", { layout = awful.layout.layouts[6], screen = s, gap = 0 })
	awful.tag.add(s.index == Screenorder[1] and "Teams" or "7", { layout = awful.layout.layouts[2], screen = s, gap = 0 })
	awful.tag.add(s.index == Screenorder[2] and "Mail" or "8", { layout = awful.layout.layouts[3], screen = s, gap = 0 })
	awful.tag.add(s.index == Screenorder[3] and "Discord" or "9", { layout = awful.layout.layouts[2], screen = s, gap = 0 })

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

return tags
