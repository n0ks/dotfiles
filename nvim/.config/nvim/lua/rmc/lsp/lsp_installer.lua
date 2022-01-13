local lsp_installer = require("nvim-lsp-installer")
local capabilities = require("rmc.lsp.handlers").capabilities
local on_attach = require("rmc.lsp.handlers").on_attach
local utils = require("rmc.utils")
local pyright_settings = require("rmc.lsp.servers.pyright")

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if server.name == "pyright" then
		utils.merge(opts, pyright_settings)
	end

	server:setup(opts)
end)
