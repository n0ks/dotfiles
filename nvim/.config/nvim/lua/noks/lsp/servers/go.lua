local map = require("noks.configs.utils").map
local util = require("lspconfig/util")

local M = {}

M.settings = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      templateExtensions = {
        "html",
        "tmpl",
      },
      completeUnimported = true,
      usePlaceholders = true,
      gofumpt = true,
      linksInHover = false,
      analyses = {
        unusedparams = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_depdendency = true,
        vendor = true,
      },
    },
  },
}

return M
