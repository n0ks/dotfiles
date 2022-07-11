require("nvim-treesitter.configs").setup({
  auto_install = true,
	ensure_installed = {
		"bash",
		"css",
		"dart",
		"dockerfile",
		"go",
		"gomod",
		"gowork",
		"html",
		"javascript",
    "tsx",
		"lua",
		"scss",
		"typescript",
		"jsonc",
		"ruby",
		"vim",
		"yaml",
	},
	sync_install = false,
	playground = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	highlight = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
	indent = { enable = false },
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
