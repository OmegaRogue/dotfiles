-- ---------------------------------------------------------------------------------------------------------------------
-- Core key bindings-Remappings {{{
-- ======================================================================================================================
local vimp = require('vimp')

-- Use CamelCaseMotion instead of default motions
if vim.g.loaded_camelcasemotion then
    vimp.map({'silent'}, 'w', '<Plug>CamelCaseMotion_w')
    vimp.map({'silent'}, 'b', '<Plug>CamelCaseMotion_b')
    vimp.map({'silent'}, 'e', '<Plug>CamelCaseMotion_e')
    vimp.map({'silent'}, 'ge', '<Plug>CamelCaseMotion_ge')
    vimp.sunmap 'w'
    vimp.sunmap 'b'
    vimp.sunmap 'e'
    vimp.sunmap 'ge'
end

-- Copy to clipboard
vim.cmd [[
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
]]
-- Paste from clipboard
vimp.nnoremap('<leader>p', '"+p')
vimp.nnoremap('<leader>P', '"+P')
vimp.vnoremap('<leader>p', '"+p')
vimp.vnoremap('<leader>P', '"+P')

-- }}}

vimp.nnoremap('<space>', 'za')

-- -----------------------------------------------------
-- Pane Mappings {{{
-- -----------------------------------------------------

vimp.nnoremap({'silent'}, '<C-M-L>', [[:NERDTreeToggle<CR>]])
vimp.nmap('<C-M-F>', [[:TagbarToggle<CR>]])
-- }}}
-- -----------------------------------------------------
-- Sneak, s f https://github.com/justinmk/vim-sneak {{{
-- -----------------------------------------------------
vimp.nmap('f', '<Plug>Sneak_s')
vimp.nmap('F', '<Plug>Sneak_S')
vimp.xmap('f', '<Plug>Sneak_s')
vimp.xmap('F', '<Plug>Sneak_S')
vimp.omap('f', '<Plug>Sneak_s')
vimp.omap('F', '<Plug>Sneak_S')
-- }}}
--------------------------------------------------------
-- Smooth scroll vim-smooth-scroll {{{
--------------------------------------------------------
vimp.noremap({'silent'}, '<c-u>',
             [[:call smooth_scroll#up(&scroll*2, 0, 4)<CR>]])
vimp.noremap({'silent'}, '<c-o>',
             [[:call smooth_scroll#down(&scroll*2, 0, 4)<CR>]])
-- }}}

-------------------------------------------------------
-- tmux navigator {{{
-------------------------------------------------------

-- Cycle between tmux/vim seamlessly
vim.g.tmux_navigator_no_mappings = 1
vimp.nnoremap({'silent'}, '<A-Left>', ':TmuxNavigateLeft<cr>')
vimp.nnoremap({'silent'}, '<A-Down>', ':TmuxNavigateDown<cr>')
vimp.nnoremap({'silent'}, '<A-Up>', ':TmuxNavigateUp<cr>')
vimp.nnoremap({'silent'}, '<A-Right>', ':TmuxNavigateRight<cr>')
vimp.nnoremap({'silent'}, '<A-z>', ':TmuxNavigatePrevious<cr>')
vimp.nnoremap({'silent'}, '<A-h>', ':TmuxNavigateLeft<cr>')
vimp.nnoremap({'silent'}, '<A-j>', ':TmuxNavigateDown<cr>')
vimp.nnoremap({'silent'}, '<A-k>', ':TmuxNavigateUp<cr>')
vimp.nnoremap({'silent'}, '<A-l>', ':TmuxNavigateRight<cr>')
-- additional mappings to support urxvt
vimp.nnoremap({'silent'}, '<Esc><Left>', ':TmuxNavigateLeft<cr>')
vimp.nnoremap({'silent'}, '<Esc><Down>', ':TmuxNavigateDown<cr>')
vimp.nnoremap({'silent'}, '<Esc><Up>', ':TmuxNavigateUp<cr>')
vimp.nnoremap({'silent'}, '<Esc><Right>', ':TmuxNavigateRight<cr>')
vimp.nnoremap({'silent'}, '<Esc>z', ':TmuxNavigatePrevious<cr>')
vimp.nnoremap({'silent'}, '<Esc>h', ':TmuxNavigateLeft<cr>')
vimp.nnoremap({'silent'}, '<Esc>j', ':TmuxNavigateDown<cr>')
vimp.nnoremap({'silent'}, '<Esc>k', ':TmuxNavigateUp<cr>')
vimp.nnoremap({'silent'}, '<Esc>l', ':TmuxNavigateRight<cr>')

-- terminal mode
vimp.tnoremap({'silent'}, '<A-Left>', '<C-W>:TmuxNavigateLeft<cr>')
vimp.tnoremap({'silent'}, '<A-Down>', '<C-W>:TmuxNavigateDown<cr>')
vimp.tnoremap({'silent'}, '<A-Up>', '<C-W>:TmuxNavigateUp<cr>')
vimp.tnoremap({'silent'}, '<A-Right>', '<C-W>:TmuxNavigateRight<cr>')
vimp.tnoremap({'silent'}, '<A-z>', '<C-W>:TmuxNavigatePrevious<cr>')
vimp.tnoremap({'silent'}, '<A-h>', '<C-W>:TmuxNavigateLeft<cr>')
vimp.tnoremap({'silent'}, '<A-j>', '<C-W>:TmuxNavigateDown<cr>')
vimp.tnoremap({'silent'}, '<A-k>', '<C-W>:TmuxNavigateUp<cr>')
vimp.tnoremap({'silent'}, '<A-l>', '<C-W>:TmuxNavigateRight<cr>')
-- additional mappings to support urxvt
vimp.tnoremap({'silent'}, '<Esc><Left>', '<C-W>:TmuxNavigateLeft<cr>')
vimp.tnoremap({'silent'}, '<Esc><Down>', '<C-W>:TmuxNavigateDown<cr>')
vimp.tnoremap({'silent'}, '<Esc><Up>', '<C-W>:TmuxNavigateUp<cr>')
vimp.tnoremap({'silent'}, '<Esc><Right>', '<C-W>:TmuxNavigateRight<cr>')
vimp.tnoremap({'silent'}, '<Esc>z', '<C-W>:TmuxNavigatePrevious<cr>')
vimp.tnoremap({'silent'}, '<Esc>h', '<C-W>:TmuxNavigateLeft<cr>')
vimp.tnoremap({'silent'}, '<Esc>j', '<C-W>:TmuxNavigateDown<cr>')
vimp.tnoremap({'silent'}, '<Esc>k', '<C-W>:TmuxNavigateUp<cr>')
vimp.tnoremap({'silent'}, '<Esc>l', '<C-W>:TmuxNavigateRight<cr>')

-- }}}

-- -----------------------------------------------------
-- F-key actions {{{
-- =====================================================

-- F1 Open/close Help
vimp.nnoremap({'silent'}, '<F1>', [[:call utils#showHelp()<CR>]])

-- F2 Source (reload configuration)
vimp.nnoremap({'silent'}, '<F2>', [[:so ~/.config/nvim/init.vim<CR>]])

-- F3 Toggle white characters visibility
vimp.nnoremap({'silent'}, '<F3>', [[:set list!<CR> :set list?<CR>]])

-- F4 Exit Vim
vimp.nnoremap('<F4>', [[:qa<CR>]])
-- Shift+F4 (F16) Force Quit Vim
vimp.nnoremap('<F16>', [[:qa!<CR>]])

vimp.tnoremap('<F5>', '<C-\\><C-n>')
-- F12 Show F keys toggles
vimp.nnoremap('<F12>', [[:call utils#showToggles()<CR>]])

-- }}}
