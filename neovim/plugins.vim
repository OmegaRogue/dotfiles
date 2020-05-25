" ======================================================================================================================
"
" Plugin manager (Plug) settings.
" Author : OmegaRogue <thatomegarogue@gmail.com>
" ======================================================================================================================

if &compatible
  set nocompatible
end

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif

call plug#begin('~/.config/nvim/plugins')




" ---------------------------------------------------------------------------------------------------------------------
" Interface {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'ashisha/image.vim'
Plug 'vim-utils/vim-man'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Color Themes {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'doums/darcula'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Text insertion/manipulation {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'vim-scripts/tComment'
Plug 'justinmk/vim-sneak'
Plug 'matze/vim-move'
Plug 'terryma/vim-smooth-scroll'
Plug 'sickill/vim-pasta'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'bkad/CamelCaseMotion'  " CamelCase and snake_case motions"  
Plug 'terryma/vim-expand-region' " Easily expand selected region
"Plug 'godlygeek/tabular', { 'on':  'Tabularize' } " Easy alignment
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Project Management {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug  'mhinz/vim-startify'
" Plug 'vim-ctrlspace/vim-ctrlspace'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Git {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Status Bar Theme vim-airline {{{
" ---------------------------------------------------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'ryanoasis/vim-devicons'
"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Languages {{{
" ---------------------------------------------------------------------------------------------------------------------

" HTML5 syntax
"Plug 'othree/html5.vim'

" Color highlighter
"Plug 'lilydjwg/colorizer', { 'for': ['css', 'sass', 'scss', 'less', 'html', 'xhtml', 'javascript', 'javascript.jsx'] }

" Yaml indentation
Plug 'martin-svk/vim-yaml'
" Markdown syntax
Plug 'tpope/vim-markdown'
" Git syntax
Plug 'tpope/vim-git'
" Dockerfile
Plug 'honza/dockerfile.vim'

Plug 'omnisharp/omnisharp-vim'

"}}}


call plug#end()
