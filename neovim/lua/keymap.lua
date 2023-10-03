-- ---------------------------------------------------------------------------------------------------------------------
-- Core  key bindings-Remappings {{{
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
vimp.nnoremap('<C-M-T>', [[:botleft sp term://zsh<CR>]])
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
vim.cmd [[noremap <silent> <c-o> :call smooth_scoll#down(&scroll*2, 0, 4)<CR>]]
--vimp.noremap({'silent'}, '<c-o>',
--             [[:call smooth_scroll#down(&scroll*2, 0, 4)<CR>]])
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


local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
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
vimp.map('<F7>', ':Format<CR>')
vimp.map('<F8>', ':%s/\\s\\+$//e<CR>')

-- }}}
