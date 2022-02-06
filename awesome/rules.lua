local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                    -- placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
	},
    { rule_any = {type = { "normal", "dialog" },
      }, properties = { titlebars_enabled = true }
    },
    { rule = { type = "dock" },
      properties = {
         border_width = 0,
         titlebars_enabled = false
    }},

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
		  "pinentry",

          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
		  "gcr-prompter",
		  "Gcr-prompter",
		},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
		  "dragon",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true },
		callback = function (c)
			awful.placement.centered(c,nil)
		end
  },
  { rule_any = {
	  type = { "dialog" },
	  class = {
		  "Blueman-manager",
		  "Kruler",
		  "Gpick",
		  "pinentry",
		  "MessageWin",
	  "gcr-prompter",
	  "Gcr-prompter",
	  },
	  name = {
		  "Event Tester",
		  "dragon",
	  }},
	  properties = { ontop = true, sticky = true}
  },

    -- Add titlebars to normal clients and dialogs
--	{
		--rule_any = { requests_no_titlebar = { true } },
		--properties = { titlebars_enabled = false, floating = true },
		--rule_any = { class = {  } }

	--  },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

