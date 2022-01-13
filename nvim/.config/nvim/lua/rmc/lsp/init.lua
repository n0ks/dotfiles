local sumneko_lua_server = require("rmc.lsp.servers.sumneko")
local tsserver           = require("rmc.lsp.servers.tsserver")
local null_ls            = require("rmc.lsp.servers.null_ls")

sumneko_lua_server.setup()
tsserver.setup()
null_ls.setup()
