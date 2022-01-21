local sumneko_lua_server = require("noks.lsp.servers.sumneko")
local tsserver           = require("noks.lsp.servers.tsserver")
local null_ls            = require("noks.lsp.servers.null_ls")
local flutter            = require("noks.lsp.servers.flutter")

sumneko_lua_server.setup()
tsserver.setup()
null_ls.setup()
flutter.setup()
