require("noks.settings")
require("noks.globals")
require("noks.configs.keymaps")

vim.cmd("source" .. "~/.config/nvim/general/funfun.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local opts = {
	performance = {
		defaults = { lazy = true },
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}

require("lazy").setup({

	-- Theme
	"rebelot/kanagawa.nvim",

	"EdenEast/nightfox.nvim",
	"catppuccin/nvim",
	"folke/tokyonight.nvim",

	"onsails/lspkind.nvim",
	"jose-elias-alvarez/nvim-lsp-ts-utils",
	"jose-elias-alvarez/null-ls.nvim",
	"b0o/schemastore.nvim",
	"ThePrimeagen/git-worktree.nvim",

	"tpope/vim-fugitive",
	"tpope/vim-projectionist",
	"tpope/vim-repeat",
	"tpope/vim-rhubarb",

	"antoinemadec/FixCursorHold.nvim",
	"kyazdani42/nvim-web-devicons",
	"rafamadriz/friendly-snippets",

	{ "folke/neodev.nvim", ft = "lua" },

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("noks.configs.gitsigns")
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("noks.configs.comment")
		end,
		event = "VeryLazy",
	},

	{
		"shortcuts/no-neck-pain.nvim",
		config = function()
			require("noks.configs.no-neck")
		end,
		event = "VeryLazy",
	},

	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("noks.configs.lualine")
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		config = function()
			require("noks.configs.bqf")
		end,
		event = "VeryLazy",
	},

	{
		"ThePrimeagen/harpoon",
		config = function()
			require("noks.configs.harpoon")
		end,
	},
	"mzlogin/vim-markdown-toc",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},
	{

		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("noks.configs.treesitter")
		end,
		lazy = false,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		event = "VeryLazy",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("noks.lsp.init").setup()
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		config = function()
			require("noks.lsp.lsp-saga")
		end,
		event = "VeryLazy",
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("noks.configs.autopairs")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("noks.configs.cmp") -- completion
		end,
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"hrsh7th/nvim-cmp",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy",
		config = function()
			require("noks.configs.luasnip")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("noks.configs.nvim-tree")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("noks.configs.telescope")
		end,
		event = "VeryLazy",
		tag = "0.1.1",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", lazy = false, build = "make" },
		},
	},
	{
		"junegunn/fzf",
		build = function()
			vim.fn["fzf#install"]()
		end,
	},
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		config = function()
			require("noks.lsp.servers.flutter").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = { "theHamsta/nvim-dap-virtual-text", "leoluz/nvim-dap-go", "rcarriga/nvim-dap-ui" },
		config = function()
			require("noks.configs.dap")
		end,
	},
}, opts)
