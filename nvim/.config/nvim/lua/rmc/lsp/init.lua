local sumneko_lua_server = require("rmc.lsp.servers.sumneko")
local tsserver           = require("rmc.lsp.servers.tsserver")
local null_ls            = require("rmc.lsp.servers.null_ls")
local flutter            = require("rmc.lsp.servers.flutter")

sumneko_lua_server.setup()
tsserver.setup()
null_ls.setup()
flutter.setup()
