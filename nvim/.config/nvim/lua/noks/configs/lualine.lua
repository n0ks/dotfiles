local navic = require("nvim-navic")

require("lualine").setup({
	extensions = { "quickfix", "fugitive" },
	options = {
		theme = "auto",
		icons_enabled = 1,
		globalstatus = true,
	},
	tabline = {
		lualine_a = {
			{
				"filename",
				color = { bg = "#363646", fg = "#C8C093" },
				separator = { left = "", right = "" },
			},
		},
		lualine_b = {
			{ navic.get_location, cond = navic.is_available or false },
		},
		lualine_x = {
			{ "tabs" },
		},
	},
	winbar = {},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "b:gitsigns_status" },
		lualine_c = {},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			"encoding",
			"filetype",
		},
	},
})
