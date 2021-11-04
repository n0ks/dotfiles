
local catppuccino = require("catppuccino")

catppuccino.setup(
    {
    colorscheme = "soft_manilo",
    transparency = false,
    term_colors = true,
		styles = {
			comments = "italic",
			functions = "italic",
			keywords = "italic",
			strings = "NONE",
			variables = "NONE",
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				styles = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic"
				}
			},
			lsp_trouble = false,
			lsp_saga = false,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = {
				enabled = false,
				show_root = false,
			},
			which_key = false,
			indent_blankline = false,
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = true,
			barbar = false,
			bufferline = false,
			markdown = false,
		}
	}
)

-- catppuccino.load()

vim.g.rose_pine_variant = "base"
vim.g.rose_pine_bold_vertical_split_line = true
vim.cmd("colorscheme rose-pine")

