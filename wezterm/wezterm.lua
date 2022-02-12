local wezterm = require "wezterm"

return {
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  colors = {
    -- The default text color
    foreground = "#DFDBD2",
    -- The default background color
    -- background = "#41403B",
    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = "#DFDBD2",
    -- the background color of selected text
    selection_bg = "#FFFFFF",
    -- The color of the split lines between panes
    split = "#555555",
    ansi = {"#2E3436", "#CC0000", "#4E9A06", "#C4A000", "#3465A4", "#75507B", "#06989A", "#D3D7CF"},
    brights = {"#555753", "#EF2929", "#8AE234", "#FCE94F", "#729FCF", "#AD7FA8", "#34E2E2", "#EEEEEC"},
    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = {[136] = "#af8700"}
  },
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2
  },
  --enable_wayland = true,
  --enable_scroll_bar = true,
  default_cursor_style = "BlinkingBar",
  warn_about_missing_glyphs = false,
  ssh_domains = {
	{
	  name = "omegamtf",
	  remote_address = "omegamtf",
	  username = "omegarogue",
    },
    {
      -- This name identifies the domain
      name = "node01",
      -- The address to connect to
      remote_address = "192.168.0.50",
      -- The username to use on the remote host
      username = "omegarogue",
    },
	{
      -- This name identifies the domain
      name = "node02",
      -- The address to connect to
      remote_address = "192.168.0.51",
      -- The username to use on the remote host
      username = "omegarogue",
    },
	{
      -- This name identifies the domain
      name = "node03",
      -- The address to connect to
      remote_address = "192.168.0.52",
      -- The username to use on the remote host
      username = "omegarogue",
    },
	{
      -- This name identifies the domain
      name = "node04",
      -- The address to connect to
      remote_address = "192.168.0.53",
      -- The username to use on the remote host
      username = "omegarogue",
    },
	{
      -- This name identifies the domain
      name = "node05",
      -- The address to connect to
      remote_address = "192.168.0.54",
      -- The username to use on the remote host
      username = "omegarogue",
    }
  },
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
		regex = "(?:(?:zgenom\\s+load)|(?:Plug)|(?:set\\s+-g\\s+@plugin))\\s+[\'\"]?([^\\s/\'\"]+/[^\\s/\'\"]+)[\'\"]?",
		format = "https://github.com/$1",
	},
	{
		regex = "(?:zgenom\\s+ohmyzsh)\\s+(?:--completion\\s+)?[\'\"]?([^\\s/\'\"]+/[^\\s/\'\"]+)[\'\"]?",
		format = "https://github.com/ohmyzsh/oh-my-zsh/tree/master/$1",
	}
  }
}
