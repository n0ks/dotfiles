require("nvim-treesitter.configs").setup({
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
	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
})
