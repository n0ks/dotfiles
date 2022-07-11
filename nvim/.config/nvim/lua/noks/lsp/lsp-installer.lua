require("nvim-lsp-installer").setup({
	ensure_installed = {
		"bashls",
		"cssls",
		"emmet_ls",
		"yamlls",
		"vimls",
		"sqlls",
		"jsonls",
		"html",
	},
	automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})
