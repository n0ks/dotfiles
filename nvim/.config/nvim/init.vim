call plug#begin('~/.vim/plugged')
" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'leoluz/nvim-dap-go'

" Completion / snippets / lsp things
Plug 'L3MON4D3/LuaSnip'
Plug 'akinsho/flutter-tools.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'SmiteshP/nvim-navic'
Plug 'onsails/lspkind.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua' 
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'glepnir/lspsaga.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

" Themes
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim'
Plug 'rose-pine/neovim'
Plug 'rebelot/kanagawa.nvim'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'Yagua/nebulous.nvim'

" Telescope 
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'nvim-telescope/telescope-symbols.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Tools & etc
" Plug 'github/copilot.vim'
Plug 'pwntester/octo.nvim'
Plug 'LudoPinelli/comment-box.nvim'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'b0o/schemastore.nvim'
Plug 'danymat/neogen'
Plug 'dstein64/vim-startuptime'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jbyuki/venn.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'kevinhwang91/nvim-bqf'
Plug 'kwkarlwang/bufresize.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern.vim', {'branch': 'main'}
Plug 'lambdalisue/nerdfont.vim'
Plug 'lewis6991/gitsigns.nvim', {'tag': 'release'}
Plug 'lewis6991/impatient.nvim'
Plug 'mg979/vim-visual-multi'
Plug 'mzlogin/vim-markdown-toc'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-go'
Plug 'haydenmeade/neotest-jest'
Plug 'sidlatau/neotest-dart'
Plug 'ryanoasis/vim-devicons'
Plug 'sindrets/diffview.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'kylechui/nvim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-test/vim-test'
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'numToStr/Comment.nvim'
Plug 'ziontee113/icon-picker.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

" source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/general/funfun.vim
" source $HOME/.config/nvim/general/terminal_toggle.vim
" source $HOME/.config/nvim/plugin/fern.vim
lua require('noks.init')
