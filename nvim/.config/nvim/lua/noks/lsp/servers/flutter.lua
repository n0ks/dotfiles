local M = {}

M.setup = function()
	require("flutter-tools").setup({
		dev_log = {
			open_cmd = "tabnew",
		},
		debugger = {
			enabled = true,
		},
		lsp = {
			on_attach = function(_, bufnr)
				vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics,
					{
						virtual_text = false,
						underline = true,
					}
				)
				require("noks.lsp.handlers").on_attach(_, bufnr)
			end,
			capabilities = require("noks.lsp.handlers").capabilities,
		},
	})
end

return M
