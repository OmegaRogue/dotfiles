local awful = require("awful")
local menubar = require("menubar")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local settings = require('settings')
local awesome = awesome
local radical = require("radical")

--menubar.menu_gen.all_menu_dirs = { "/usr/share/applications/", "~/.local/share/applications/" }

-- {{{ Categories
menubar.menu_gen.all_categories = {
    multimedia = {
        app_type = "AudioVideo",
        name = "Multimedia",
        icon_name = "applications-multimedia",
        use = true
    },
    development = {
        app_type = "Development",
        name = "Development",
        icon_name = "applications-development",
        use = true
    },
    education = {
        app_type = "Education",
        name = "Education",
        --icon_name = '/usr/share/icons/breeze/categories/32/applications-education.svg',
        icon_name = "applications-education",
        use = true
    },
    games = {
        app_type = "Game",
        name = "Games",
        icon_name = "applications-games",
        use = true
    },
    graphics = {
        app_type = "Graphics",
        name = "Graphics",
        icon_name = "applications-graphics",
        use = true
    },
    office = {
        app_type = "Office",
        name = "Office",
        icon_name = "applications-office",
        use = true
    },
    internet = {
        app_type = "Network",
        name = "Internet",
        icon_name = "applications-internet",
        use = true
    },
    engineering = {
        app_type = "Engineering",
        name = "Engineering",
        icon_name = "applications-engineering",
        use = true
    },
    science = {
        app_type = "Science",
        name = "Science",
        --icon_name = '/usr/share/icons/gnome/16x16/categories/applications-science.png',
		icon_name = "applications-science",
        use = true
    },
    settings = {
        app_type = "Settings",
        name = "Settings",
        --icon_name = '/usr/share/icons/gnome/16x16/categories/applications-utilities.png',
		icon_name = "applications-utilities",
        use = true
    },
    tools = {
        app_type = "System",
        name = "System Tools",
        icon_name = "applications-system",
        use = true
    },
    utility = {
        app_type = "Utility",
        name = "Accessories",
        icon_name = "applications-accessories",
        use = true
    },
    wine = {
        app_type = "Wine",
        name = "Wine",
        icon_name = "wine",
        use = true
    }, 
	applications = {
        app_type = "Application",
        name = "Applications",
        icon_name = "applications",
        use = true
    },

}

menubar.menu_gen.lookup_category_icons()

-- }}}

-- Create a launcher widget and a main menu
local myawesomemenu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    }, { "manual", settings.terminal .. " -e man awesome" },
    { "edit config", settings.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart }, { "quit", function()
        awesome.quit()
    end }
}
local mymainmenu = freedesktop.menu.build({
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon }
        -- other triads can be put here
    },
    after = {
        { "Open terminal", settings.terminal, menubar.utils.lookup_icon("utilities-terminal") }
        -- other triads can be put here
    }
})
--xdg_menu = require("archmenu")
-- local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "Applications", xdgmenu },
--                                     { "open terminal", terminal }
--                                   }
--                         })

-- {{{ Awesome-appmenu (disabled)
-- mymainmenu = awful.menu(
-- 	{
-- 		items = {
-- 			{ "awesome", myawesomemenu, beautiful.awesome_icon },
-- 			{ 'Accessories', appmenu.Accessories },
-- 			{ 'Development', appmenu.Development },
-- 			{ 'Education', appmenu.Education },
-- 			{ 'Science', appmenu.Science },
-- 			{ 'Games', appmenu.Games },
-- 			{ 'Graphics', appmenu.Graphics, '/usr/share/icons/Ambiant-MATE/categories/16/applications-graphics.svg' },
-- 			{ 'Internet', appmenu.Internet, '/usr/share/icons/Ambiant-MATE/categories/16/applications-internet.svg' },
-- 			{ 'Office', appmenu.Office },
-- 			{ 'MultiMedia', appmenu.MultiMedia, '/usr/share/icons/Ambiant-MATE/categories/24/applications-multimedia.svg' },
-- 			{ 'Settings', appmenu.Settings },
-- 			{ 'System', appmenu.System },
-- 			{ 'Miscellaneous', appmenu.Miscellaneous },
-- 			{ "open terminal", terminal },
-- 		}
--     })
--}}}


return mymainmenu
