require("lualine").setup({
	extensions = { "quickfix", "fugitive" },
	options = {
		-- theme = "rose-pine",
		theme = "catppuccin",
		section_separators = "",
		component_separators = " | ",
		icons_enabled = 1,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "b:gitsigns_status" },
		lualine_x = {
			{ 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
			'encoding',
			'filetype'
		},

	},
})
