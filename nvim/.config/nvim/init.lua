require("noks.settings")
require("noks.globals")
require("noks.configs.keymaps")
require("noks.configs.autocmds")

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
	{

		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("noks.configs.themes.kanagawa")
			vim.api.nvim_command("colorscheme kanagawa")
		end,
	},

	{
		"AlexvZyl/nordic.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			local nord = require("nordic")
			nord.setup({
				transparent_bg = true,
			})
			nord.load()
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		-- lazy = false,
		-- priority = 1000,
		-- enabled = true,
		config = function()
			require("noks.configs.themes.nightfox")
			-- vim.api.nvim_command("colorscheme carbonfox")
		end,
	},

	{ "rose-pine/neovim", name = "rose-pine" },

	{
		"catppuccin/nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			require("noks.configs.themes.catppuccin")
			-- vim.api.nvim_command("colorscheme catppuccin")
		end,
	},
	{
		"eddyekofo94/gruvbox-flat.nvim",
		-- priority = 1000,
		config = function()
			-- vim.g.gruvbox_transparent = true
			-- vim.api.nvim_command("colorscheme gruvbox-flat")
		end,
	},

	"folke/tokyonight.nvim",

	{
		"m00qek/baleia.nvim",
		config = function()
			local b = require("baleia").setup({})

			vim.api.nvim_create_user_command("BaleiaColorize", function()
				b.once(vim.api.nvim_get_current_buf())
			end, {})

			vim.cmd([[
          let s:baleia = luaeval("require('baleia').setup { }")
          autocmd BufWinEnter,BufRead dap-repl call s:baleia.automatically(bufnr('%'))
    ]])
		end,
	},

	"onsails/lspkind.nvim",
	"b0o/schemastore.nvim",
	{ "ThePrimeagen/git-worktree.nvim", config = true },

	"tpope/vim-fugitive",
	"tpope/vim-projectionist",
	"tpope/vim-repeat",
	"tpope/vim-rhubarb",

	"skywind3000/asyncrun.vim",

	{ "antoinemadec/FixCursorHold.nvim" },
	{ "nvim-tree/nvim-web-devicons" },

	"folke/trouble.nvim",
	"stevearc/dressing.nvim",

	{ "johmsalas/text-case.nvim", config = true },
	-- { "j-hui/fidget.nvim", config = true },

	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
		},
	},

	{
		"Exafunction/codeium.vim",
		config = function()
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })

			vim.keymap.set("i", "<C-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })

			vim.keymap.set("i", "<C-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })

			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},

	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("noks.configs.dashboard")
		end,
	},

	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		-- cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		config = function()
			require("noks.configs.diffview")
		end,
	},

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

	{ "echasnovski/mini.statusline", version = false, config = function() end },
	{
		enabled = false,
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

			vim.notify.setup({
				background_colour = "#000000",
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "f2778bd",
		build = ":TSUpdate",
		-- dependencies = {
		-- 	"nvim-treesitter/nvim-treesitter-textobjects",
		-- },
		config = function()
			require("noks.configs.treesitter")
		end,
		lazy = false,
	},

	"jose-elias-alvarez/nvim-lsp-ts-utils",
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("noks.lsp.servers.null_ls").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("noks.lsp.mason").setup()
				end,
			},
			{
				"folke/neodev.nvim",
				ft = "*.lua",
				config = function()
					require("neodev").setup({
						library = { plugins = { "neotest" }, types = true },
					})
				end,
			},
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("noks.lsp.init").setup()
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("noks.lsp.lsp-saga")
		end,
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
		build = "make install_jsregexp",
		version = "2.1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-symbols.nvim",
			"aaronhallaert/advanced-git-search.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", lazy = true, build = "make" },
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
		lazy = false,
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
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
			"sidlatau/neotest-dart",
		},
		config = function()
			require("noks.configs.neotest")
		end,
	},
}, opts)
