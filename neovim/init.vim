" ######################################################################################################################
" ### Author : OmegaRogue <thatomegarogue@gmail.com>                                                                 ###
" ######################################################################################################################
" ### Neovim Configuration                                                                                           ###
" ### Neovimmer since : Tue 19.05.2020                                                                               ### 
" ######################################################################################################################

let home_path = $HOME


"Plugins managed with vim-plug {{{
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif
"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Basic settings (Neovim defaults: https://neovim.io/doc/user/vim_diff.html#nvim-option-defaults) {{{
" ======================================================================================================================

" sets blinking cursors for different edit modes
set guicursor=n-v-c:block,
set guicursor+=i-ci-ve:ver25,
set guicursor+=r-cr:hor20,
set guicursor+=o:hor50,
set guicursor+=a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,
set guicursor+=sm:block-blinkwait175-blinkoff150-blinkon175


set mouse=a

set clipboard=unnamedplus

" tex flavor
let g:tex_flavor = 'latex'

let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
		\   '-lualatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

let g:vimtex_view_method = 'mupdf'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Color and highlighting settings {{{
" ======================================================================================================================

" Enable Darcula Color Scheme
colorscheme darcula
set termguicolors



"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Search settings {{{
" ---------------------------------------------------------------------------------------------------------------------

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Persistent undo settings {{{
" ---------------------------------------------------------------------------------------------------------------------
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/undo//
endif
"}}}


" ---------------------------------------------------------------------------------------------------------------------
" Tabs {{{
" ---------------------------------------------------------------------------------------------------------------------

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Folding settings {{{
" ---------------------------------------------------------------------------------------------------------------------

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Vim-Multiple-Cursors settings {{{
" ---------------------------------------------------------------------------------------------------------------------

"}}}



" ---------------------------------------------------------------------------------------------------------------------
" Core key bindings-Remappings {{{
" ======================================================================================================================
" Use CamelCaseMotion instead of default motions
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge



"}}}

" -----------------------------------------------------
" Startify Config {{{
" -----------------------------------------------------
"autocmd User Startified setlocal cursorline
autocmd User Startified setlocal buftype=
" let g:startify_disable_at_vimenter    = 0
let g:startify_enable_special         = 1
let g:startify_files_number           = 8
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_update_oldfiles        = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1

let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ '.*/doc/.*.txt'
            \ ]


"}}}

let g:startify_bookmarks = [
            \ { 'c': '~/.dotfiles/neovim/init.vim' },
            \ { 'd': '~/.dotfiles/neovim/plugins.vim'},
            \ { 'f': '~/.dotfiles/neovim/autoload/utils.vim'},
            \ { 'g': '~/.dotfiles/zsh/zshrc'},
            \ { 'h': '~/.dotfiles/zsh/zshenv'},
            \ { 'i': '~/.dotfiles/zsh/zsh_aliases'},
            \ { 'j': '~/.dotfiles/install.conf.yaml'}
            \ ]

" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
    let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
    let bookmarks = bookmarks[0:-2] " Slices an empty last line
    return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']},
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]


let g:startify_commands = [
    \ ['Vim Reference', 'h ref']
    \ ]




" -----------------------------------------------------
" tree Config {{{
" -----------------------------------------------------
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd VimEnter *   if !argc() | Startify | NERDTree | wincmd w | endif
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=50
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline=0
let g:NERDTreeRespectWildIgnore=1
let g:NERDTreeMapActivateNode='<right>'
" NERDTree File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('haml', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('scss', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('rb', 'Cyan', 'none', 'red', '#151515')
call NERDTreeHighlightFile('png', 'Cyan', 'none', 'red', '#151515')
call NERDTreeHighlightFile('jpg', 'Cyan', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('zshrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

autocmd filetype nerdtree syn match haskell_icon #?# containedin=NERDTreeFile
" if you are using another syn highlight for a given line (e.g.
" NERDTreeHighlightFile) need to give that name in the 'containedin' for this
" other highlight to work with it
" autocmd filetype nerdtree syn match html_icon #?# containedin=NERDTreeFile,html
autocmd filetype nerdtree syn match go_icon #?# containedin=NERDTreeFile

" nnoremap <silent> <Leader>h :call utils#nerdWrapper()<CR>
nnoremap <silent> <Leader>h :NERDTreeToggle<CR>

"map <Leader>n :NERDTreeToggle<CR>

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif


let g:plug_window = 'noautocmd vertical topleft new'



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
" Gitgutter {{{
" -----------------------------------------------------
"let g:gitgutter_map_keys=0
"let g:gitgutter_max_signs=9999
"let g:gitgutter_sign_added='+'
""let g:gitgutter_sign_modified='~'
"let g:gitgutter_sign_removed='-'
"let g:gitgutter_sign_modified_removed='~'
"let g:gitgutter_sign_removed_first_line='-'
"let g:gitgutter_override_sign_column_highlight = 0
"set signcolumn=yes

"highlight GitGutterAdd ctermfg=green ctermbg=NONE
"highlight GitGutterChange ctermfg=yellow ctermbg=NONE
"highlight GitGutterDelete ctermfg=red ctermbg=NONE
"highlight GitGutterChangeDelete ctermfg=magenta ctermbg=NONE

hi! link GitGutterAdd GitAddStripe
hi! link GitGutterChange GitChangeStripe
hi! link GitGutterDelete GitDeleteStripe

let g:gitgutter_sign_removed = '▶'

"}}}


" -----------------------------------------------------
" Airline {{{
" -----------------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
" Enable the list of ers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_exclude_preview = 1
"}}}


" -----------------------------------------------------
" Pasta  Pasting in Vim with indentation adjusted to destination context.{{{
" -----------------------------------------------------
let g:pasta_paste_before_mapping = ',O'
let g:pasta_paste_after_mapping = ',o'
"}}}


" -----------------------------------------------------
" Smooth scroll vim-smooth-scroll {{{
" -----------------------------------------------------
"noremap <silent> <c-key> :call smooth_scroll#up(&scroll, 0, 2)<CR>
"noremap <silent> <c-key> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-o> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
"}}}




" -----------------------------------------------------
" Autocommands {{{
" =====================================================

" Reset cursor to blinking vertical bar on leave
au VimLeave * set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor

" Enable ssh_config highlighting in ssh configs in subfolders
au BufNewFile,BufRead ssh_config,*/.ssh/config,*/ssh/config  setf sshconfig

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

"F12 Show F keys toggles
nnoremap <F12> :call utils#showToggles()<CR>
