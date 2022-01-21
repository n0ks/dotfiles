require("project_nvim").setup({
	exclude_dirs = {
		"~/.pub-cache/",
		"**/node_modules/",
		"~/fvm/",
	},
	show_hidden = true,
})
