-- Core LSP imports
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Server configurations
local servers = {
  sumneko = require("noks.lsp.servers.sumneko"),
  tsserver = require("noks.lsp.servers.tsserver"),
  go = require("noks.lsp.servers.go"),
  pyright = require("noks.lsp.servers.pyright"),
  jsonls = require("noks.lsp.servers.jsonls"),
}

-- LSP handlers
local handlers = require("noks.lsp.handlers")

---@class Module
local M = {}

-- Default LSP options
local default_opts = {
  flags = {
    debounce_text_changes = 150,
  }
}

-- Server specific configurations
local server_configs = {
  jsonls = servers.jsonls,
  pyright = servers.pyright,
  sumneko_lua = servers.sumneko.config,
  tsserver = servers.tsserver.config,
  gopls = servers.go.settings,
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

---Setup LSP servers with proper configuration
M.setup = function()
  mason_lspconfig.setup_handlers({
    function(server_name)
      local ok, server_config = pcall(function()
        return server_configs[server_name] or {}
      end)

      if not ok then
        vim.notify(
          string.format("Failed to load config for %s", server_name),
          vim.log.levels.ERROR
        )
        return
      end

      local config = vim.tbl_deep_extend("force", {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        flags = default_opts.flags,
      }, server_config)

      lspconfig[server_name].setup(config)
    end,
  })
end

return M
