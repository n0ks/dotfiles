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
	transparent = false,
	dimInactive = false,
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

require("tokyonight").setup({
	style = "storm",
	light_style = "day",
	transparent = true,
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent",
		floats = "transparent",
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = true, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
})
--Put this lines inside your vimrc to set the colorscheme
require("nebulous").setup({
	variant = "nova",
})

vim.cmd([[
  set laststatus=3
  " highlight Normal guibg=none
  " highlight NonText guibg=none
]])

-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme nebulous")
vim.cmd("colorscheme tokyonight")
