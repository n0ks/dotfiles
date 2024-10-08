local sumneko_lua = require("noks.lsp.servers.sumneko")
local tsserver = require("noks.lsp.servers.tsserver")
local lsp_config = require("lspconfig")
local mlsp = require("mason-lspconfig")
local on_attach = require("noks.lsp.handlers").on_attach
local capabilities = require("noks.lsp.handlers").capabilities
local go = require("noks.lsp.servers.go")

local pyright_settings = require("noks.lsp.servers.pyright")
local jsonls_settings = require("noks.lsp.servers.jsonls")

local M = {}

M.setup = function()
  local server_args = {
    jsonls = jsonls_settings,
    pyright = pyright_settings,
    sumneko_lua = sumneko_lua.config,
    tsserver = tsserver.config,
    yamlls = {
      settings = {
        yaml = {
          keyOrdering = false,
        },
      },
    },
    gopls = go.settings,
  }

  local opts = {
    flags = {
      debounce_text_changes = 150,
    },
  }

  mlsp.setup_handlers({
    function(server_name)
      local args = server_args[server_name] or {}

      if not args.on_attach then
        args.on_attach = on_attach
      end

      if not args.capabilities then
        args.capabilities = capabilities
      end

      args.flags = opts.flags

      lsp_config[server_name].setup(args)
    end,
  })
end

return M
