local awful = require("awful")

local bling = require("bling")


local tags = {}

tags.maketags = function(s)

	awful.tag({ "1", "2", "3", "4", "5" }, s, bling.layout.centered)

	awful.tag.add(s.index == Screenorder[3] and "Messenger" or "6", { layout = awful.layout.suit.fair, screen = s, gap = 0 })
	awful.tag.add(s.index == Screenorder[1] and "Teams" or "7", { layout = awful.layout.suit.tile, screen = s })
	awful.tag.add(s.index == Screenorder[2] and "Mail" or "8", { layout = awful.layout.suit.tile.left, screen = s })
	awful.tag.add(s.index == Screenorder[3] and "Discord" or "9", { layout = awful.layout.suit.tile, screen = s })

end

return tags
