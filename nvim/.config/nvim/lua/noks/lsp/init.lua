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
	null_ls.setup()

	local server_args = {
		jsonls = jsonls_settings,
		pyright = pyright_settings,
		sumneko_lua = sumneko_lua.config,
		tsserver = tsserver.config,
	}

	local servers = lsp_install.get_installed_servers()

	for _, server in ipairs(servers) do
		local args = server_args[server.name] or {}

		if not args.on_attach then
			args.on_attach = on_attach
		end

		if not args.capabilities then
			args.capabilities = capabilities
		end

		lsp_config[server.name].setup(args)
	end

	flutter.setup()
	go.setup()
end

return M
