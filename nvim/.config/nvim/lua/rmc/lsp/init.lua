local lspconfig = require("lspconfig")
local lsp_installer = require("nvim-lsp-installer")
local utils = require("rmc.utils")
local on_attach = require("rmc.lsp.handlers").on_attach
local capabilities = require("rmc.lsp.handlers").capabilities
local sumneko_lua_server = require("rmc.lsp.servers.sumneko")
local tsserver = require("rmc.lsp.servers.tsserver")
local null_ls = require("rmc.lsp.servers.null_ls")

sumneko_lua_server.setup()
tsserver.setup()
null_ls.setup()

lspconfig.html.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities
})


