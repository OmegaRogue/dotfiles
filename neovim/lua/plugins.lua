-- ======================================================================================================================
--
-- Plugin manager (packer) settings.
-- Author : OmegaRogue <thatomegarogue@gmail.com>
-- ======================================================================================================================
-- if &compatible
--  set nocompatible
-- end
-- local use = vim.fn['plug#']
-- vim.cmd [[
-- if empty(glob('~/.config/nvim/autoload/plug.vim'))
--   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
--     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
--   autocmd VimEnter * useInstall | source ~/.config/nvim/init.vim
-- endif
-- ]]
-- vim.call('plug#begin', '~/.config/nvim/plugins')

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'svermeulen/vimpeccable'
	-- ---------------------------------------------------------------------------------------------------------------------
	-- Interface {{{
	-- ---------------------------------------------------------------------------------------------------------------------

	-- use 'ashisha/image.vim'
	-- use 'vim-utils/vim-man'
	use 'lambdalisue/vim-pager'
	use 'lambdalisue/vim-manpager'
	use 'christoomey/vim-tmux-navigator'
	--use 'intrntbrn/awesomewm-vim-tmux-navigator'
	use 'melonmanchan/vim-tmux-resizer'
	use 'MikeDacre/tmux-zsh-vim-titles'
	use 'skywind3000/vim-preview'
	use 'majutsushi/tagbar'
	use {'tversteeg/registers.nvim', branch = 'main' }
	use 'severin-lemaignan/vim-minimap'
	use 'ptzz/lf.vim'
	use 'voldikss/vim-floaterm'
	use 'chrisbra/sudoedit.vim'
	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Color Themes {{{
	-- ---------------------------------------------------------------------------------------------------------------------

	use 'doums/darcula'

	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Text insertion/manipulation {{{
	-- ---------------------------------------------------------------------------------------------------------------------

	use 'vim-scripts/tComment'
	use 'justinmk/vim-sneak'
	use 'matze/vim-move'
	use 'terryma/vim-smooth-scroll'
	use 'sickill/vim-pasta'
	use 'AndrewRadev/splitjoin.vim'
	use {'mg979/vim-visual-multi', branch = 'master' }
	use 'bkad/CamelCaseMotion'                   -- CamelCase and snake_case motions
	use 'terryma/vim-expand-region'              -- Easily expand selected region
	use {'godlygeek/tabular', opt = true, cmd = 'Tabularize' } -- Easy alignment
	use 'tpope/vim-repeat'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-surround'
	use 'tpope/vim-unimpaired'
	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Project Management {{{
	-- ---------------------------------------------------------------------------------------------------------------------

	use 'ctrlpvim/ctrlp.vim'
	use 'mhinz/vim-startify'
	use 'preservim/nerdtree'
	use 'tpope/vim-vinegar'

	-- use 'vim-ctrlspace/vim-ctrlspace'

	-- use 'ludovicchabant/vim-gutentags'
	-- use 'skywind3000/gutentags_plus'
	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Git {{{
	-- ---------------------------------------------------------------------------------------------------------------------

	use 'airblade/vim-gitgutter'
	use {'xuyuanp/nerdtree-git-plugin', requires = 'preservim/nerdtree'} 
	use 'tpope/vim-fugitive'
	use 'junegunn/gv.vim'

	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Status Bar Theme vim-airline {{{
	-- ---------------------------------------------------------------------------------------------------------------------
	use 'vim-airline/vim-airline'
	use {'vim-airline/vim-airline-themes', requires = 'vim-airline/vim-airline'}
	use 'ryanoasis/vim-devicons'

	-- }}}

	-- ---------------------------------------------------------------------------------------------------------------------
	-- Languages {{{
	-- ---------------------------------------------------------------------------------------------------------------------
	-- use 'neovim/nvim-lspconfig'
	use {'neoclide/coc.nvim', branch = 'release' }
	use {'xiyaowong/coc-sumneko-lua', run = 'yarn install --frozen-lockfile', requires = 'neoclide/coc.nvim'}
	-- HTML5 syntax
	-- use 'othree/html5.vim'

	-- Color highlighter
	use 'chrisbra/colorizer'
	-- use('lilydjwg/colorizer', {
	--     ['for'] = {
	--         'css', 'sass', 'scss', 'less', 'html', 'xhtml', 'javascript',
	--         'javascript.jsx'
	--     }
	-- })

	-- Yaml indentation
	use 'martin-svk/vim-yaml'
	-- Markdown syntax
	use 'tpope/vim-markdown'
	-- Git syntax
	use 'tpope/vim-git'
	-- Dockerfile
	use 'honza/dockerfile.vim'
	-- C# syntax
	use 'omnisharp/omnisharp-vim'

	-- LaTeX
	use 'lervag/vimtex'

	-- use 'vim-scripts/Improved-AnsiEsc'

	-- Hashicorp tools
	use 'hashivim/vim-terraform'
	use 'hashivim/vim-consul'
	use 'hashivim/vim-vagrant'
	use 'hashivim/vim-nomadproject'
	use 'hashivim/vim-packer'

	-- Log syntax
	use 'dzeban/vim-log-syntax'

	-- Gitignore syntax
	use 'gisphm/vim-gitignore'

	-- use 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

	use 'samsaga2/vim-z80'
	use 'vim-scripts/avr8bit.vim'

	use 'rid9/vim-fstab'

	-- }}}


	if packer_bootstrap then
		require('packer').sync()
	end
end)



--vim.call('plug#end')
