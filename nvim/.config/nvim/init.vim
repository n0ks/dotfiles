source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/terminal_toggle.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plugin/fern.vim
" source $HOME/.config/nvim/plugin/gitgutter.vim
source $HOME/.config/nvim/plugin/telescope.vim
source $HOME/.config/nvim/plugin/quickfix.vim
source $HOME/.config/nvim/plugin/fzf.vim
source $HOME/.config/nvim/general/autocmd.vim 


call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
Plug 'glepnir/lspsaga.nvim'
" Plug 'kabouzeid/nvim-lspinstall'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
" Plug 'andweeb/presence.nvim'
Plug 'mfussenegger/nvim-dap'
"Plug 'rcarriga/nvim-dap-ui'
Plug 'ckipp01/stylua-nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'NTBBloodbath/rest.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'hrsh7th/nvim-compe'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lewis6991/gitsigns.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'ryanoasis/vim-devicons'
Plug 'sindrets/diffview.nvim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'mg979/vim-visual-multi'
Plug 'tommcdo/vim-fubitive'

"Flutter
Plug 'akinsho/flutter-tools.nvim'
Plug 'dart-lang/dart-vim-plugin'

" Snippets
Plug 'natebosch/dartlang-snippets'
" Plug 'SirVer/UltiSnips'
" Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'Neevash/awesome-flutter-snippets'
" THEMES
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'cocopon/iceberg.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'folke/tokyonight.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'numtostr/FTerm.nvim'
Plug 'shaunsingh/moonlight.nvim'
call plug#end()

source $HOME/.config/nvim/themes/theme.vim
lua require('rmc.init')
