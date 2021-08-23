source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/terminal_toggle.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plugin/fern.vim
source $HOME/.config/nvim/plugin/quickfix.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/general/autocmd.vim 


call plug#begin('~/.vim/plugged')
" Plug 'SirVer/UltiSnips'
" Plug 'andweeb/presence.nvim'
" Plug 'honza/vim-snippets'
" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'Neevash/awesome-flutter-snippets'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'ahmedkhalf/project.nvim'
Plug 'akinsho/flutter-tools.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'ckipp01/stylua-nvim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mg979/vim-visual-multi'
Plug 'natebosch/dartlang-snippets'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'numtostr/FTerm.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'rcarriga/nvim-dap-ui'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'shaunsingh/moonlight.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'tommcdo/vim-fubitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
call plug#end()

source $HOME/.config/nvim/themes/theme.vim
lua require('rmc.init')
