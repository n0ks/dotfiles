function test(a, b) end
require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"bash",
		"css",
		"dart",
		"dockerfile",
		"go",
		"gomod",
		"gowork",
		"html",
		"javascript",
		"tsx",
		"lua",
		"scss",
		"typescript",
		"jsonc",
		"ruby",
		"vim",
		"yaml",
	},
	sync_install = false,
	playground = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = {
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
			-- You can choose the select mode (default is charwise 'v')
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding xor succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			include_surrounding_whitespace = false,
		},
	},
	indent = { enable = true },
	autopairs = { enable = true },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
