local lspconfig = require("lspconfig")

local M = {}

USER = vim.fn.expand("$USER")

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
	sumneko_root_path = "/Users/" .. USER .. "/Documents/code/lua-language-server"
	sumneko_binary = "/Users/" .. USER .. "/Documents/code/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
	sumneko_root_path = "/home/" .. USER .. "/code/lua-language-server"
	sumneko_binary = "/home/" .. USER .. "/code/lua-language-server/bin/lua-language-server"
else
	print("Unsupported system for sumneko")
end

M.setup = function()
	lspconfig.sumneko_lua.setup({
		cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
		on_attach = require("rmc.lsp.handlers").on_attach,
		capabilities = require("rmc.lsp.handlers").capabilities,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

return M
