local M = {}
-- local coq = require("coq")
local navic = require("nvim-navic")

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
	format_notify = false,
}

-- vim.g.navic_silence = true

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

vim.diagnostic.config(config)

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- M.capabilities = coq.lsp_ensure_capabilities(capabilities)
M.capabilities = cmp_capabilities

-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
	if not result or vim.tbl_isempty(result) then
		print("[LSP] Could not find definition")
		return
	end

	if vim.tbl_islist(result) then
		vim.lsp.util.jump_to_location(result[1], "utf-8")
	else
		vim.lsp.util.jump_to_location(result, "utf-8")
	end
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

M.on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	-- if client.name == "tsserver" or client.name == "sumneko_lua" or client.name == "html" then
	-- 	client.server_capabilities.document_formatting = false
	-- end
	if client.server_capabilities.documentSymbolProvider then
		navic.setup({
			highlight = true,
		})
		navic.attach(client, bufnr)
	end
end

return M
