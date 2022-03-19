vim.g.coq_settings = {
	auto_start = "shut-up",
	display = {
		pum = {
			fast_close = false,
		},
	},
	keymap = {
		eval_snips = "<leader>j",
		jump_to_mark = "<C-j>",
		pre_select = true,
		bigger_preview = "<C-k>",
	},
	clients = {
		lsp = {
			weight_adjust = 1.6,
		},
		snippets = {
			weight_adjust = 1.9,
		},
		buffers = {
			weight_adjust = -1.9,
		},
		tree_sitter = {
			weight_adjust = -1.5,
		},
		tmux = {
			weight_adjust = -1.5,
		},
	},
}

require("coq")

require("coq_3p")({
	{ src = "nvimlua", short_name = "nLUA" },
	{ src = "repl", sh = "zsh" },
	{ src = "figlet", short_name = "BIG", trigger = "!big" },
	{ src = "copilot", short_name = "COP", accept_key = "<c-f>" },
})
