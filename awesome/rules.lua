local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup")
local ruled = require('ruled')
local naughty = require('naughty')
local dpi = require("beautiful.xresources").apply_dpi
local utils = require("utils")
-- Rules to apply to new clients (through the "manage" signal).

-- All clients will match this rule.
ruled.client.append_rule {
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = Clientkeys,
        buttons = Clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
    }
}
ruled.client.append_rule {
	rule = { name = "splash" },
	properties = {
		floating = true
	}
}


ruled.client.append_rule {
    rule_any = {
        type = {
            "normal", "dialog"
        }
    },
    properties = {
        titlebars_enabled = true
    }
}
ruled.client.append_rule {
	rule = {
		class = {
			"microsoft teams - preview", "Microsoft Teams - Preview"
		}
	},
	properties = {
		minimized = true
	}
}
ruled.client.append_rule {
    rule = {
        type = "dock"
    },
    properties = {
        border_width = 0,
        titlebars_enabled = false
    }
}
-- Floating clients.
ruled.client.append_rule {
    rule_any = {
        instance = {
            "DTA", -- Firefox addon DownThemAll.
            "copyq" -- Includes session name in class.
        },
        class = {
            "Arandr", "Blueman-manager", "Gpick", "Kruler", "pinentry",

            "MessageWin", -- kalarm.
            "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
            "Wpa_gui", "veromix", "xtightvncviewer", "gcr-prompter",
            "Gcr-prompter"
        },

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester", -- xev.
            "dragon",
			"Signal Desktop Preferences",
        },
        role = {
            "AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
        }
    },
    properties = {
        floating = true,
		disable_smart_borders = false
    },
    callback = function(c)
        awful.placement.centered(c, nil)
    end
}
ruled.client.append_rule {
	rule = {
		type = "normal"
	},
	properties = {
		floating = false
	}
}
ruled.client.append_rule {
	rule_any = {
		class = {
			"Navigator", "firefox", "pcmanfm", "Pcmanfm"
		},
		type = "normal"
	},
	properties = {
		floating = false
	}
}

ruled.client.append_rule {
    rule_any = {
        type = {
            "dialog"
        },
        class = {
            "Blueman-manager", "Kruler", "Gpick", "pinentry", "MessageWin",
            "gcr-prompter", "Gcr-prompter"
        },
        name = {
            "Event Tester", "dragon"
        }
    },
    properties = {
        ontop = true,
		floating = true
    }
}

ruled.client.append_rule {
    rule_any = {
        class = {
            "signal",
            "Signal",
            "telegram-desktop",
            "TelegramDesktop",
            "whatsapp-nativefier-d40211",
            "whatsapp-for-linux",
            "Whatsapp-for-linux",
            "WhatsAppQT",
            "discord",
            "fluffychat",
            "Fluffychat",
            "element",
            "Element",
        }
    },
	rule_except_any = {
		name = {
			"Signal Desktop Preferences"
		}
	},
    properties = {
        floating = false,
		disable_smart_borders = true,
    }
}
ruled.client.append_rule {
    rule_any = {
        class = {
            "signal", "Signal", "whatsapp-nativefier-d40211",
            "WhatsAppQT", "whatsapp-for-linux", "Whatsapp-for-linux",
            "whatsapp-nativefier-d40211", "telegram-desktop",
            "TelegramDesktop",
            "fluffychat",
            "Fluffychat",
            "element",
            "Element",

        }
    },
    properties = {
        tag = "Messenger",
        screen = utils.screen_fallback(3),
    }
}
ruled.client.append_rule {
    rule_any = {
        class = {
            "microsoft teams - preview", "Microsoft Teams - Preview",
			"teams-for-linux", "teams-for-linux"
        }
    },
    properties = {
        tag = "Teams",
        floating = false,
        screen = utils.screen_fallback(1),
		disable_smart_borders = true,
    }
}
ruled.client.append_rule {
    rule_any = {
        class = {
            "evolution", "Evolution"
        }
    },
    properties = {
        tag = "Mail", screen = utils.screen_fallback(2)
    }
}
ruled.client.append_rule {
    rule = {
        class = "discord"
    },
    properties = {
        screen = utils.screen_fallback(3),
        tag = "Discord",
        maximise = false,
    }
}
ruled.client.append_rule {
    rule = {
        role = "_NET_WM_STATE_FULLSCREEN"
    },
    properties = {
        floating = true
    }
}

ruled.client.append_rule {
    rule = {
        class = "Gimp",
        role = "gimp-image-window"
    },
    properties = {
        maximized = true
    }
}
ruled.client.append_rule {
    rule = {
        class = "jetbrains-.*",
        name = "win.*"
    },
    properties = {
        titlebars_enabled = false,
        focusable = false,
        focus = true,
        floating = true,
        placement = awful.placement.restore
    }
}
ruled.client.append_rule {
    rule_any = {
        class = {
            "jetbrains-toolbox",
            "JetBrains Toolbox"
        },

    },
    properties = {
        honor_workarea = true,
        size_hints_honor = false,
        placement = function(c)
            local f = (awful.placement.no_overlap + awful.placement.no_offscreen + awful.placement.top_right)
            f(c, {
                offset = { x = -12, y = 40 },
                margin = 40,
                honor_workarea = true
            })
        end,
        focus = true,
        floating = true,
    }
}
ruled.client.append_rule {
    rule = {
        class = { "google-chrome", "Google-chrome" },
        role = "pop-up"
    },
    properties = {
        ontop = true,
        floating = true
    }
}
ruled.client.append_rule {
	id = "dont_show_smart_borders",
    rule_any = {
        class = {
			"gnome-disks", "Gnome-disks",
			"peek", "Peek",
			"bottles", "bottles",
			"evolution", "Evolution",
			"file-roller", "File-roller",
		},
    },
	except_any = {
		type = {
            "dialog"
        },
	},
    properties = {
		disable_smart_borders = true,
		titlebars_enabled = false,
		border_width = dpi(1),
    }
}
-- ruled.client.append_rule {
-- 	rule = {
-- 		fullscreen = true
-- 	},
-- 	properties = {
-- 		disable_smart_borders = true,
-- 		had_smart_borders_disabled = false
-- 	},
-- 	callback = function(c)
-- 		if c.fullscreen then
-- 			c.fullscreen = false
-- 			c.fullscreen = true
-- 		end
-- 	end
-- }
ruled.client.append_rule {
	rule_any = {
		class = {
			"steam_app_1296610"
		}
	},
	properties = {
		floating = true,
		fullscreen = true,
		disable_smart_borders = true,
		suspend_notifications = true,
	}
}
-- ruled.client.append_rule {
-- 	rule_any = {
-- 		class = {
-- 			"jetbrains-toolbox",
-- 			"JetBrains Toolbox"
-- 		},
-- 	},
-- 	callback = function(c)
-- 		c:grant("autoactivate","")
-- 		c:grant("activate","")
-- 		c:connect_signal("mouse::leave", function()
-- 		-- 	c:kill()
-- 		naughty.notify({text=c.protocols,title = "Oops, an error happened!"})
-- 		end)
-- 	end
-- }
ruled.client.append_rule {
	rule = { name = "FreeCAD", type = "dialog", class = "FreeCAD" },
	properties = {
		disable_smart_borders = true
	}
}
ruled.client.append_rule {
	rule = { type = "dialog" },
	properties = {
		floating = true
	}
}
-- ruled.client.append_rule {
-- 	rule_any = {
-- 		class = {"kdenlive"}
-- 	},
-- 	callback = function(c)
-- 		naughty.notification{title=c.name,timeout=0,text=gears.debug.dump_return(c.class).."\n"..gears.debug.dump_return(c.window)}
-- 	end
-- }
ruled.client.append_rule {
	rule_any = {
		type = {"splash"}
	},
	callback = function(c)
		naughty.notification{title=c.name,timeout=0,text=gears.debug.dump_return(c.class).."\n"..gears.debug.dump_return(c.window)}
	end
}
ruled.client.append_rule {
	rule_any = {
		class = {
			"evolution", "Evolution",
			"telegram-desktop", "TelegramDesktop",
			"element", "Element",
			"signal", "Signal",
			"whatsapp-nativefier-d40211",
            "whatsapp-for-linux",
            "Whatsapp-for-linux",
            "WhatsAppQT",
			"discord",
		}
	},
	properties =  {
		focus = false
	}
}
ruled.client.append_rule {
	rule = {
		name = "Signal Desktop Preferences"
	},
	properties = {
		floating = true,
		disable_smart_borders = false,
		titlebars_enabled = true,
	}
}
