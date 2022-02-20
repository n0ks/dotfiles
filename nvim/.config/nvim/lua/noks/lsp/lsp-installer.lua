local lsp_installer = require("nvim-lsp-installer")
local capabilities = require("noks.lsp.handlers").capabilities
local on_attach = require("noks.lsp.handlers").on_attach
local utils = require("noks.configs.utils")
local pyright_settings = require("noks.lsp.servers.pyright")
local jsonls_settings = require("noks.lsp.servers.jsonls")
local inspect = require("noks.configs.inspect")

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if server.name == "pyright" then
		utils.merge(opts, pyright_settings)
	end

	if server.name == "jsonls" then
		utils.merge(opts, jsonls_settings)
	end

	server:setup(opts)
end)
