require("lualine").setup({
	extensions = { "quickfix", "fugitive" },
	options = {
		theme = "catppuccino",
		section_separators = "",
		component_separators = " | ",
		icons_enabled = 1,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "b:gitsigns_status" },
	},
})
