-- ======================================================================================================================
--
-- Plugin manager (Plug) settings.
-- Author : OmegaRogue <thatomegarogue@gmail.com>
-- ======================================================================================================================
-- if &compatible
--  set nocompatible
-- end
local Plug = vim.fn['plug#']
vim.cmd [[
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.vim
endif
]]
vim.call('plug#begin', '~/.config/nvim/plugins')

Plug 'svermeulen/vimpeccable'

-- ---------------------------------------------------------------------------------------------------------------------
-- Interface {{{
-- ---------------------------------------------------------------------------------------------------------------------

-- Plug 'ashisha/image.vim'
-- Plug 'vim-utils/vim-man'
Plug 'lambdalisue/vim-pager'
Plug 'lambdalisue/vim-manpager'
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'
Plug 'MikeDacre/tmux-zsh-vim-titles'
Plug('tversteeg/registers.nvim', {branch = 'main'})

-- }}}

-- ---------------------------------------------------------------------------------------------------------------------
-- Text insertion/manipulation {{{
-- ---------------------------------------------------------------------------------------------------------------------

Plug 'vim-scripts/tComment'
Plug 'justinmk/vim-sneak'
Plug 'matze/vim-move'
Plug 'terryma/vim-smooth-scroll'
Plug 'sickill/vim-pasta'
Plug 'AndrewRadev/splitjoin.vim'
Plug('mg979/vim-visual-multi', {branch = 'master'})
Plug 'bkad/CamelCaseMotion' -- CamelCase and snake_case motions
Plug 'terryma/vim-expand-region' -- Easily expand selected region
Plug('godlygeek/tabular', {on = 'Tabularize'}) -- Easy alignment
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
-- }}}

-- ---------------------------------------------------------------------------------------------------------------------
-- Project Management {{{
-- ---------------------------------------------------------------------------------------------------------------------

Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-vinegar'

-- Plug 'vim-ctrlspace/vim-ctrlspace'

-- Plug 'ludovicchabant/vim-gutentags'
-- Plug 'skywind3000/gutentags_plus'
-- }}}

-- ---------------------------------------------------------------------------------------------------------------------
-- Git {{{
-- ---------------------------------------------------------------------------------------------------------------------

Plug 'airblade/vim-gitgutter'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

-- }}}

-- ---------------------------------------------------------------------------------------------------------------------
-- Status Bar Theme vim-airline {{{
-- ---------------------------------------------------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

-- }}}

-- ---------------------------------------------------------------------------------------------------------------------
-- Languages {{{
-- ---------------------------------------------------------------------------------------------------------------------

Plug('neoclide/coc.nvim', {branch = 'release'})


-- Yaml indentation
Plug 'martin-svk/vim-yaml'
-- Markdown syntax
Plug 'tpope/vim-markdown'
-- Git syntax
Plug 'tpope/vim-git'
-- Dockerfile
Plug 'honza/dockerfile.vim'

-- Plug 'vim-scripts/Improved-AnsiEsc'

-- Hashicorp tools
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-consul'
Plug 'hashivim/vim-vagrant'
Plug 'hashivim/vim-nomadproject'
Plug 'hashivim/vim-packer'

-- Log syntax
Plug 'dzeban/vim-log-syntax'

-- Gitignore syntax
Plug 'gisphm/vim-gitignore'



-- }}}

vim.call('plug#end')
