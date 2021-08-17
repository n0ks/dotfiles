require("lualine").setup({
	extensions = { "quickfix", "fugitive" },
	options = {
		-- theme = "gruvbox",
		theme  = 'nightfly' ,
		-- theme  = 'palenight' ,
		-- theme  = 'material-nvim' ,
		section_separators = "",
		component_separators = "⁃",
		icons_enabled = 1, -- displays icons in alongside component
	},
	sections = {
		lualine_a = { "mode"},
		lualine_b = { "branch", "b:gitsigns_status" },
		lualine_c = { "diagnostics", {
			"filename",
			file_status = true,
			path = 0,
		}},
		lualine_x = {  "filetype" },
	},
})
