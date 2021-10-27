source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/funfun.vim
source $HOME/.config/nvim/general/terminal_toggle.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plugin/fern.vim
source $HOME/.config/nvim/plugin/quickfix.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/general/autocmd.vim 

call plug#begin('~/.vim/plugged')
" Plug 'honza/vim-snippets'
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'ahmedkhalf/project.nvim'
Plug 'akinsho/flutter-tools.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'ckipp01/stylua-nvim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'kabouzeid/nvim-lspinstall'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim'
Plug 'glepnir/zephyr-nvim'
Plug 'kwkarlwang/bufresize.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jiangmiao/auto-pairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mg979/vim-visual-multi'
Plug 'natebosch/dartlang-snippets'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'rcarriga/nvim-dap-ui'
Plug 'ryanoasis/vim-devicons'
Plug 'sainnhe/gruvbox-material'
Plug 'Pocco81/Catppuccino.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
call plug#end()

" source $HOME/.config/nvim/themes/theme.vim

lua require('rmc.init')

lua << EOF
require("bufresize").setup()
EOF
