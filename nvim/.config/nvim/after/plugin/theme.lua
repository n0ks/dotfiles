local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
	term_colors = true,
	transparent_background = true,
	custom_highlights = {
		Comment = { fg = colors.overlay1 },
		LineNr = { fg = colors.overlay1 },
		CursorLine = { bg = colors.none },
		CursorLineNr = { fg = colors.lavender },
		DiagnosticVirtualTextError = { bg = colors.none },
		DiagnosticVirtualTextWarn = { bg = colors.none },
		DiagnosticVirtualTextInfo = { bg = colors.none },
		DiagnosticVirtualTextHint = { bg = colors.none },
	},
	integrations = {
		-- navic = true,
		gitsigns = true,
		telescope = true,
		fern = true,
		dap = {
			enabled = true,
			enable_ui = true,
		},
	},
})

require("kanagawa").setup({
	transparent = true,
	dimInactive = false,
	globalStatus = true,
})

require("rose-pine").setup({
	dark_variant = "main",
	disable_background = true,
})

require("nightfox").setup({
	options = {
		transparent = true,
	},
})

vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme rose-pine")

vim.cmd([[
  set laststatus=3
  highlight Normal guibg=none
  highlight NonText guibg=none
]])
