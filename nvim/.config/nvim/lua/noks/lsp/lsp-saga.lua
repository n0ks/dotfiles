local saga = require("lspsaga")

saga.init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
		sign = true,
		virtual_text = true,
	},
})
