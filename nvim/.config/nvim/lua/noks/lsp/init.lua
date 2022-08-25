local sumneko_lua = require("noks.lsp.servers.sumneko")
local tsserver = require("noks.lsp.servers.tsserver")
local null_ls = require("noks.lsp.servers.null_ls")
local flutter = require("noks.lsp.servers.flutter")
local go = require("noks.lsp.servers.go")
local lsp_install = require("nvim-lsp-installer")
local lsp_config = require("lspconfig")
local on_attach = require("noks.lsp.handlers").on_attach
local capabilities = require("noks.lsp.handlers").capabilities

local pyright_settings = require("noks.lsp.servers.pyright")
local jsonls_settings = require("noks.lsp.servers.jsonls")

local M = {}

M.setup = function()
	local server_args =
		{ jsonls = jsonls_settings, pyright = pyright_settings, sumneko_lua = sumneko_lua.config }

	local servers = lsp_install.get_installed_servers()

	for _, server in ipairs(servers) do
		local args = server_args[server.name] or {}
		args.on_attach = on_attach
		args.capabilities = capabilities

		lsp_config[server.name].setup(args)
	end

	tsserver.setup()
	null_ls.setup()
	flutter.setup()
  go.setup()
end

return M
