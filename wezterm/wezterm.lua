local wezterm = require "wezterm"

return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  colors = {
    -- The default text color
    foreground = "#DFDBD2",
    -- The default background color
    background = "#41403B",
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
  }
}
