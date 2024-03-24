local wezterm = require "wezterm"

return {
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  colors = {
    -- The default text color
    foreground = "#DFDBD2",
    -- The default background color
    --background = "#41403B",
    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = "#DFDBD2",
    -- the background color of selected text
    selection_bg = "#214283",
    -- The color of the split lines between panes
    split = "#555555",
    ansi = {"#2E3436", "#CC0000", "#4E9A06", "#C4A000", "#3465A4", "#75507B", "#06989A", "#D3D7CF"},
    brights = {"#555753", "#EF2929", "#8AE234", "#FCE94F", "#729FCF", "#AD7FA8", "#34E2E2", "#EEEEEC"},
    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = {[136] = "#af8700"},
	tab_bar = {
	  background = "#3f3e3a",
	  active_tab = {
		  bg_color = "#4e4c46",
		  fg_color = "#ebebeb",
	  },
	  inactive_tab = {
		  bg_color = "#3f3e3a",
		  fg_color = "#bcbcbc"
	  },
	},
  },
  window_padding = {
    left = 2,
    right = 0,
    top = 2,
    bottom = 2
  },
  enable_kitty_graphics = true,
  --enable_wayland = true,
  enable_scroll_bar = true,
  default_cursor_style = "BlinkingBar",
  warn_about_missing_glyphs = false,
  exit_behavior = "Hold",
--  ssh_domains = {
--  },	
  hyperlink_rules = {
    -- Linkify things that look like URLs
    -- This is actually the default if you don't specify any hyperlink_rules
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },

    -- linkify email addresses
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },

    -- file:// URI
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },

    -- Make task numbers clickable
    --[[
    {
      regex = "\\b[tT](\\d+)\\b"
      format = "https://example.com/tasks/?t=$1"
    }
    ]]
	{
		regex = "(?:(?:zgenom\\s+load)|(?:Plug)|(?:use)|(?:set\\s+-g\\s+@plugin))\\s+{?[\'\"]?([^\\s/\'\"]+/[^\\s/\'\"]+)[\'\"]?",
		format = "https://github.com/$1",
	},
	{
		regex = "(?:zgenom\\s+ohmyzsh)\\s+(?:--completion\\s+)?[\'\"]?([^\\s/\'\"]+/[^\\s/\'\"]+)[\'\"]?",
		format = "https://github.com/ohmyzsh/oh-my-zsh/tree/master/$1",
	}
  },
    -- leader = { key="\\", mods="CTRL", timeout_milliseconds=1000 },
   -- keys = {
    -- {key="2", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    -- {key="5", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
  -- }
  keys = {
	  {key="Enter", mods="ALT", action="DisableDefaultAssignment"}
  },
  -- scrollback_lines = 1000000

}
