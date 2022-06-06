" ---------------------------------------------------------------------------------------------------------------------
" Core key bindings-Remappings {{{
" ======================================================================================================================
" Use CamelCaseMotion instead of default motions
if exists('g:loaded_camelcasemotion')
	map <silent> w <Plug>CamelCaseMotion_w
	map <silent> b <Plug>CamelCaseMotion_b
	map <silent> e <Plug>CamelCaseMotion_e
	map <silent> ge <Plug>CamelCaseMotion_ge
	sunmap w
	sunmap b
	sunmap e
	sunmap ge
endif

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"}}}

" -----------------------------------------------------
" Pane Mappings {{{
" -----------------------------------------------------

nnoremap <silent> <C-M-L> :NERDTreeToggle<CR>

nmap <C-M-F> :TagbarToggle<CR>

nnoremap <C-M-T> :botleft sp term://zsh<CR>
"}}}
" -----------------------------------------------------
" Sneak, s f https://github.com/justinmk/vim-sneak {{{
" -----------------------------------------------------
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S
"}}}

" -----------------------------------------------------
" Smooth scroll vim-smooth-scroll {{{
" -----------------------------------------------------
noremap <silent> <c-u> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-o> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
"}}}

" -----------------------------------------------------
" tmux navigator {{{
" -----------------------------------------------------

"Cycle between tmux/vim seamlessly
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <A-Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <A-Up>    :TmuxNavigateUp<cr>
nnoremap <silent> <A-Right> :TmuxNavigateRight<cr>
nnoremap <silent> <A-z>     :TmuxNavigatePrevious<cr>
nnoremap <silent> <A-h>     :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j>     :TmuxNavigateDown<cr>
nnoremap <silent> <A-k>     :TmuxNavigateUp<cr>
nnoremap <silent> <A-l>     :TmuxNavigateRight<cr>
"additional mappings to support urxvt
nnoremap <silent> <Esc><Left>  :TmuxNavigateLeft<cr>
nnoremap <silent> <Esc><Down>  :TmuxNavigateDown<cr>
nnoremap <silent> <Esc><Up>    :TmuxNavigateUp<cr>
nnoremap <silent> <Esc><Right> :TmuxNavigateRight<cr>
nnoremap <silent> <Esc>z       :TmuxNavigatePrevious<cr>
nnoremap <silent> <Esc>h       :TmuxNavigateLeft<cr>
nnoremap <silent> <Esc>j       :TmuxNavigateDown<cr>
nnoremap <silent> <Esc>k       :TmuxNavigateUp<cr>
nnoremap <silent> <Esc>l       :TmuxNavigateRight<cr>

"terminal mode
tnoremap <silent> <A-Left>  <C-W>:TmuxNavigateLeft<cr>
tnoremap <silent> <A-Down>  <C-W>:TmuxNavigateDown<cr>
tnoremap <silent> <A-Up>    <C-W>:TmuxNavigateUp<cr>
tnoremap <silent> <A-Right> <C-W>:TmuxNavigateRight<cr>
tnoremap <silent> <A-z>     <C-W>:TmuxNavigatePrevious<cr>
tnoremap <silent> <A-h>     <C-W>:TmuxNavigateLeft<cr>
tnoremap <silent> <A-j>     <C-W>:TmuxNavigateDown<cr>
tnoremap <silent> <A-k>     <C-W>:TmuxNavigateUp<cr>
tnoremap <silent> <A-l>     <C-W>:TmuxNavigateRight<cr>
"additional mappings to support urxvt
tnoremap <silent> <Esc><Left>  <C-W>:TmuxNavigateLeft<cr>
tnoremap <silent> <Esc><Down>  <C-W>:TmuxNavigateDown<cr>
tnoremap <silent> <Esc><Up>    <C-W>:TmuxNavigateUp<cr>
tnoremap <silent> <Esc><Right> <C-W>:TmuxNavigateRight<cr>
tnoremap <silent> <Esc>z       <C-W>:TmuxNavigatePrevious<cr>
tnoremap <silent> <Esc>h       <C-W>:TmuxNavigateLeft<cr>
tnoremap <silent> <Esc>j       <C-W>:TmuxNavigateDown<cr>
tnoremap <silent> <Esc>k       <C-W>:TmuxNavigateUp<cr>
tnoremap <silent> <Esc>l       <C-W>:TmuxNavigateRight<cr>

"}}}

" -----------------------------------------------------
" F-key actions {{{
" =====================================================

"F1 Open/close Help
nnoremap <silent> <F1> :call utils#showHelp()<CR>

"F2 Source (reload configuration)
nnoremap <silent> <F2> :so ~/.config/nvim/init.vim<CR>

"F3 Toggle white characters visibility
nnoremap <silent> <F3> :set list!<CR> :set list?<CR>

"F4 Exit Vim
nnoremap <F4> :qa<CR>
"Shift+F4 (F16) Force Quit Vim
nnoremap <F16> :qa!<CR>

tnoremap <F5> <C-\><C-n>
"F12 Show F keys toggles
nnoremap <F12> :call utils#showToggles()<CR>

"Format file
map <F7> gg=G<C-o><C-o>

"}}}
