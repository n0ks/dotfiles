local M = {}

local coq = require("coq")

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local coq_capabilities = coq.lsp_ensure_capabilities(capabilities)

M.capabilities = coq_capabilities

M.on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

return M
