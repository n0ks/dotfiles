call plug#begin('~/.vim/plugged')
" treesitter is just fucking me up / commit workaround
Plug 'AndrewRadev/splitjoin.vim'
Plug 'LudoPinelli/comment-box.nvim'
Plug 'NTBBloodbath/doombox.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'ahmedkhalf/project.nvim'
Plug 'akinsho/flutter-tools.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'b0o/schemastore.nvim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'catppuccin/nvim'
Plug 'danymat/neogen'
Plug 'dstein64/vim-startuptime'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'jbyuki/venn.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinhwang91/nvim-bqf'
Plug 'kwkarlwang/bufresize.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lewis6991/gitsigns.nvim', {'tag': 'release'}
Plug 'lewis6991/impatient.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mg979/vim-visual-multi'
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'mzlogin/vim-markdown-toc'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'commit':'b5cdb868c7a20640c9b60aa82afe82ed63f4ebd3', 'do': ':TSUpdate'}  
Plug 'rcarriga/nvim-dap-ui'
Plug 'rose-pine/neovim'
Plug 'ryanoasis/vim-devicons'
Plug 'sindrets/diffview.nvim'
Plug 'tami5/lspsaga.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-telescope/telescope-symbols.nvim'
call plug#end()


source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/funfun.vim
source $HOME/.config/nvim/general/terminal_toggle.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plugin/fern.vim
source $HOME/.config/nvim/plugin/quickfix.vim
source $HOME/.config/nvim/general/autocmd.vim 

lua require('noks.init')

