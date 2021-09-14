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

"}}}
