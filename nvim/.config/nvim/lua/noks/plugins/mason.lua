return {

  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bashls",
          "cssls",
          "yamlls",
          "vimls",
          "sqlls",
          "jsonls",
          "html",
        },
      })
    end,
  },
}
