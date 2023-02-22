require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
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
