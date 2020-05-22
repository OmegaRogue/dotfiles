" ######################################################################################################################
" ### Author : OmegaRogue <thatomegarogue@gmail.com>                                                                 ###
" ######################################################################################################################
" ### Neovim Configuration                                                                                           ###
" ### Neovimmer since : Tue 19.05.2020                                                                               ###                                                                             ###
" ######################################################################################################################


let home_path = $HOME

"Plugins managed with vim-plug {{{
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif
"}}}



" sets blinking cursors for different edit modes
set guicursor=n-v-c:block,
set guicursor+=i-ci-ve:ver25,
set guicursor+=r-cr:hor20,
set guicursor+=o:hor50,
set guicursor+=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,
set guicursor+=sm:block-blinkwait175-blinkoff150-blinkon175
  
" Reset cursor to blinking vertical bar on leave
au VimLeave * set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor


" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif

let g:plug_window = 'noautocmd vertical topleft new'

" Maps Ctrl-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
  
" Quit Vim if the only windows left is a NERDTree window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Enable Darcula Color Scheme
colorscheme darcula
set termguicolors
