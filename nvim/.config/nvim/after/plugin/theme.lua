local colors = require("catppuccin.palettes").get_palette() -- fetch colors from palette

require("catppuccin").setup({
	term_colors = true,
	flavour = "mocha",
	transparent_background = true,
	-- custom_highlights = {
	-- 	Comment = { fg = colors.overlay1 },
	-- 	LineNr = { fg = colors.overlay1 },
	-- 	CursorLine = { bg = colors.none },
	-- 	CursorLineNr = { fg = colors.lavender },
	-- 	IncSearch = { fg = colors.lavender, bg = colors.lavender },
	-- },
	integrations = {
		navic = true,
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
	dark_variant = "moon",
	disable_background = false,
})
--
require("nightfox").setup({
	options = {
		transparent = true,
		styles = {
			comments = "italic",
			functions = "italic,bold",
		},
	},
})

-- require("tokyonight").setup({
-- 	style = "storm",
-- 	transparent = false,
-- 	terminal_colors = true,
-- 	styles = {
-- 		comments = { italic = true },
-- 		keywords = { italic = true },
-- 		functions = {},
-- 		variables = {},
-- 		sidebars = "transparent",
-- 		floats = "transparent",
-- 	},
-- 	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
-- 	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
-- 	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
-- 	dim_inactive = true, -- dims inactive windows
-- 	lualine_bold = false,
-- })

-- vim.cmd("colorscheme nordfox")
-- vim.cmd("colorscheme kanagawa")

-- vim.cmd("colorscheme rose-pine")
-- vim.cmd("colorscheme duskfox")
-- vim.cmd("colorscheme dawnfox")

vim.cmd([[
  set laststatus=3
  " highlight Normal guibg=NONE ctermbg=NONE
  " highlight LineNr guibg=NONE ctermbg=NONE
  " set fillchars+=vert:\│
  " highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
]])
