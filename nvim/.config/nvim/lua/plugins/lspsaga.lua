return {

	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {

			request_timeout = 4000,
			lightbulb = {
				enable = false,
				enable_in_insert = true,
				virtual_text = false,
			},
			symbol_in_winbar = {
				enable = true,
			},
			ui = {
				border = "rounded",
				title = true,
			},
		},
	},
}
