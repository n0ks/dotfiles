im.g.coc_settings = {
	keymap = {
		jump_to_mark = "<C-g>",
		eval_snips = "<leader>j",
	},
	auto_start = true,
  clients = {
	buffers = {
		enabled = true,
		weight_adjust = -1.9,
	},
	tree_sitter = {
		enabled = true,
		weight_adjust = -1.5,
	},
	lsp = {
		enabled = true,
		weight_adjust = 1.5,
	},
	snippets = {
		enabled = true,
		weight_adjust = 1.9,
	},
  },
}


require("coq_3p") {
  { src = "nvimlua", short_name = "nLUA" },
}

