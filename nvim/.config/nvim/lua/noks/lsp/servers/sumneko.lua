local lspconfig = require("lspconfig")

local M = {}

M.setup = function()
	lspconfig.sumneko_lua.setup({
		-- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
		on_attach = require("noks.lsp.handlers").on_attach,
		capabilities = require("noks.lsp.handlers").capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
