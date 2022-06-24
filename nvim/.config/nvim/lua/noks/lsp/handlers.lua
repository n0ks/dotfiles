local M = {}
-- local coq = require("coq")

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

local config = {
	virtual_text = false,
	-- show signs,
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = false,
	severity_sort = true,
	float = {
		focus = false,
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config(config)

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp_capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- M.capabilities = coq.lsp_ensure_capabilities(capabilities)
M.capabilities = cmp_capabilities

-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print "[LSP] Could not find definition"
    return
  end

  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "html" then
		client.server_capabilities.document_formatting = false
	end
end

return M
