-- local colors = require("catppuccin.palettes").get_palette()
local starry = require("starry")

require("catppuccin").setup({
	term_colors = true,
	transparent_background = false,
	-- custom_highlights = {
	-- 	Comment = { fg = colors.overlay1 },
	-- 	LineNr = { fg = colors.overlay1 },
	-- 	CursorLine = { bg = colors.none },
	-- 	CursorLineNr = { fg = colors.lavender },
	-- 	DiagnosticVirtualTextError = { bg = colors.none },
	-- 	DiagnosticVirtualTextWarn = { bg = colors.none },
	-- 	DiagnosticVirtualTextInfo = { bg = colors.none },
	-- 	DiagnosticVirtualTextHint = { bg = colors.none },
	-- },
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
	overrides = function(colors)
		local theme = colors.theme
		return {
			Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
			PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
			PmenuSbar = { bg = theme.ui.bg_m1 },
			PmenuThumb = { bg = theme.ui.bg_p2 },
			TelescopeTitle = { fg = theme.ui.special, bold = true },
			TelescopePromptNormal = { bg = theme.ui.bg_p1 },
			TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
			TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
			TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
			TelescopePreviewNormal = { bg = theme.ui.bg_dim },
			TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
		}
	end,
})

require("rose-pine").setup({
	dark_variant = "main",
	disable_background = true,
})

require("nightfox").setup({
	options = {
		transparent = false,
	},
})

require("tokyonight").setup({
	style = "storm",
	transparent = false,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "transparent",
		floats = "transparent",
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = true, -- dims inactive windows
	lualine_bold = false,
})

require("nebulous").setup({
	variant = "nova",
})

-- vim.g.starry_disable_background = true

starry.setup({
	custom_highlights = {
		LineNr = { bg = nil },
	},
})

vim.cmd([[
  set laststatus=3
  " highlight Normal guibg=none
  " highlight NonText guibg=none
]])

vim.cmd("colorscheme kanagawa")
