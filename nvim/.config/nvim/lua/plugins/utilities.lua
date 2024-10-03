return {

	"nvim-tree/nvim-web-devicons",
	"stevearc/dressing.nvim",
	"tpope/vim-repeat",
	{ "ThePrimeagen/git-worktree.nvim", config = true, enabled = false },
	{ "b0o/schemastore.nvim", event = "BufEnter *.json" },
	{ "johmsalas/text-case.nvim", config = true, event = "VeryLazy" },
	{ "kylechui/nvim-surround", config = true, event = "VeryLazy" },
	{ "mzlogin/vim-markdown-toc", event = "BufEnter *.md" },
	{ "skywind3000/asyncrun.vim", event = "VeryLazy" },
	{ "tpope/vim-projectionist", enabled = false },
	{ "tpope/vim-rhubarb", enable = false },

	{ "junegunn/fzf", build = "./install --bin" },
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = false,
			keymaps = {
				["yp"] = {
					desc = "Copy filepath to system clipboard",
					callback = function()
						require("oil.actions").copy_entry_path.callback()
						vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
					end,
				},
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {
			enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
			ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
			check_ts = true, -- use treesitter to check for a pair.
			ts_config = {
				lua = { "string" }, -- it will not add pair on that treesitter node
				javascript = { "template_string" },
				java = false, -- don't check treesitter on java
			},
		},
	},

	{
		"chrisbra/Colorizer",
		config = function()
			vim.g.colorizer_auto_filetype = "dap-repl"
			vim.g.colorizer_disable_bufleave = 1
		end,
	},

	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		opts = {

			menu = {
				width = 100,
				height = 20,
			},
			global_settings = {
				enter_on_sendcmd = true,
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		event = "BufEnter *.md",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"kevinhwang91/nvim-bqf",
		opts = {
			filter = {
				fzf = {
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
				},
			},
			preview = {
				auto_preview = false,
			},
		},
		event = "VeryLazy",
	},

	{
		"rcarriga/nvim-notify",
		enabled = false,
		config = function()
			vim.notify = require("notify")

			vim.notify.setup({
				timeout = 3000,
				background_colour = "#FFFFFF",
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		opts = {
			pre_hook = function(ctx)
				if vim.bo.filetype == "typescriptreact" then
					local U = require("Comment.utils")

					-- Determine whether to use linewise or blockwise commentstring
					local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

					-- Determine the location where to calculate commentstring from
					local location = nil
					if ctx.ctype == U.ctype.blockwise then
						location = require("ts_context_commentstring.utils").get_cursor_location()
					elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
						location = require("ts_context_commentstring.utils").get_visual_start_location()
					end

					return require("ts_context_commentstring.internal").calculate_commentstring({
						key = type,
						location = location,
					})
				end
			end,
		},
	},

	{
		"m00qek/baleia.nvim",
		enable = false,
		event = "VeryLazy",
		config = function()
			local b = require("baleia").setup({})
			vim.api.nvim_create_user_command("BaleiaColorize", function()
				b.once(vim.api.nvim_get_current_buf())
			end, {})

			vim.cmd([[
          let s:baleia = luaeval("require('baleia').setup { }")
          autocmd BufWinEnter,BufRead dap-repl setlocal modifiable
          \| silent call s:baleia.automatically(bufnr('%'))
          \| setlocal nomodifiable
    ]])
		end,
	},
}
