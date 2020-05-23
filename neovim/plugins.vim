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

Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'ashisha/image.vim'

"}}}

" ---------------------------------------------------------------------------------------------------------------------
" Color Themes {{{
" ---------------------------------------------------------------------------------------------------------------------

Plug 'doums/darcula'

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

"}}}


call plug#end()
