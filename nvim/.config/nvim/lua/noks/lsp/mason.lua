require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"bashls",
		"cssls",
		"yamlls",
		"vimls",
		"sqlls",
		"jsonls",
		"gopls",
		"html",
		"tsserver",
	},
})
