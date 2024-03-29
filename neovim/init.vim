" ######################################################################################################################
" ### Author : OmegaRogue <thatomegarogue@gmail.com>                                                                 ###
" ######################################################################################################################
" ### Neovim Configuration                                                                                           ###
" ### Neovimmer since : Tue 19.05.2020                                                                               ### 
" ######################################################################################################################

let home_path = $HOME

let chassis = "undefined"
let location = "undefined"
let deployment = "undefined"
let icon_name = "undefined"

if executable("hostnamectl")
	let chassis = system('hostnamectl chassis')
	let location = system('hostnamectl location')
	let deployment = system('hostnamectl deployment')
	let icon_name = system('hostnamectl icon-name')
endif
"Plugins managed with vim-plug {{{
if filereadable(expand("~/.config/nvim/plugins.vim"))
  source ~/.config/nvim/plugins.vim
endif
"}}}
if filereadable(expand("~/.config/nvim/keymap.vim"))
  source ~/.config/nvim/keymap.vim
endif
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

" Cursor line
set cursorline
set cursorcolumn

set splitbelow
set splitright


" ---------------------------------------------------------------------------------------------------------------------
" Color and highlighting settings {{{
" ======================================================================================================================

" Enable Darcula Color Scheme
colorscheme darcula
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

let darcula#palette.bg = darcula#palette.null
set bg&
call darcula#Hi('Normal',darcula#palette.fg, darcula#palette.bg)
" Ubuntu Mate terminal colors in terminale
"let g:terminal_color_0  = '#2e3436'
"let g:terminal_color_1  = '#cc0000'
"let g:terminal_color_2  = '#4e9a06'
"let g:terminal_color_3  = '#c4a000'
"let g:terminal_color_4  = '#3465a4'
"let g:terminal_color_5  = '#75507b'
"let g:terminal_color_6  = '#06989a'
"let g:terminal_color_7  = '#d3d7cf'
"let g:terminal_color_8  = '#555753'
"let g:terminal_color_9  = '#ef2929'
"let g:terminal_color_10 = '#8ae234'
"let g:terminal_color_11 = '#fce94f'
"let g:terminal_color_12 = '#729fcf'
"let g:terminal_color_13 = '#ad7fa8'
"let g:terminal_color_14 = '#34e2e2'
"let g:terminal_color_15 = '#eeeeec'

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
"  Formatting settings {{{
" ---------------------------------------------------------------------------------------------------------------------

let g:terraform_fmt_on_save=1
let g:terraform_align=1

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Folding settings {{{
" ---------------------------------------------------------------------------------------------------------------------

"}}}
" ---------------------------------------------------------------------------------------------------------------------
" Gutentags {{{
" ---------------------------------------------------------------------------------------------------------------------
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_plus_switch = 1
"}}}
" ---------------------------------------------------------------------------------------------------------------------
" Vim-Multiple-Cursors settings {{{
" ---------------------------------------------------------------------------------------------------------------------
let g:VM_mouse_mappings = 1
let g:VM_maps = {}
let g:VM_maps["Mouse Cursor"] = '<C-M-LeftMouse>'
"}}}

let g:mkdp_auto_start = 1
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
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']},
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]


let g:startify_commands = [
    \ ['Vim Reference', 'h ref'],
	\ {'t': ['Terminal', 'term']},
    \ ]

"}}}


" -----------------------------------------------------
" tree Config {{{
" -----------------------------------------------------
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"autocmd VimEnter *   if !argc() | Startify | NERDTree | wincmd w | endif
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=30
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
" nnoremap <silent> <Leader>h :NERDTreeToggle<CR>

" map <Leader>n :NERDTreeToggle<CR>

" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif


let g:plug_window = 'noautocmd vertical topleft new'



"}}}

" -----------------------------------------------------
" vimtex {{{
" -----------------------------------------------------

" tex flavor
let g:tex_flavor = 'lualatex'

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
        \   '-synctex=0',
        \   '-interaction=nonstopmode',
        \ ],
        \}


"function! SetServerName()
"  if has('win32')
"    let nvim_server_file = $TEMP . "/curnvimserver.txt"
"  else
"    let nvim_server_file = "/tmp/curnvimserver.txt"
"  endif
"  let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
"  call system(cmd)
"endfunction

"augroup vimtex_common
"    autocmd!
"    autocmd FileType tex call SetServerName()
"augroup END

let g:vimtex_view_method = 'zathura'
"let g:vimtex_compiler_progname = 'nvr'

"}}}



" -----------------------------------------------------
" Gitgutter {{{
" -----------------------------------------------------
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

"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup

" -----------------------------------------------------
" Pasta  Pasting in Vim with indentation adjusted to destination context.{{{
" -----------------------------------------------------
let g:pasta_paste_before_mapping = ',O'
let g:pasta_paste_after_mapping = ',o'
"}}}

" -----------------------------------------------------
" Autocommands {{{
" =====================================================

" Reset cursor to blinking vertical bar on leave
au VimLeave * set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor

" Enable ssh_config highlighting in ssh configs in subfolders
au BufNewFile,BufRead ssh_config,*/.ssh/config,*/ssh/config  setf sshconfig

"}}}


