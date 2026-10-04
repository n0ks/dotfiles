-- mason.nvim v2 has no `ensure_installed` of its own, and mason-lspconfig's
-- only covers language servers. Everything that is not an LSP -- the conform
-- formatters, the nvim-lint linters and the DAP adapter -- is guaranteed here.
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
    },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- conform formatters (see plugins/formatting.lua)
        "stylua",
        "prettier",
        "shfmt",
        "goimports-reviser",
        "gofumpt",
        "golines",
        -- nvim-lint linters
        "golangci-lint",
        "eslint_d",
        "shellcheck",
        -- nvim-dap adapter for js/ts (see plugins/debugging.lua)
        "js-debug-adapter",
        -- nvim-treesitter's install() shells out to this to build parsers AND
        -- to fetch their queries; without it there is no highlighting.
        "tree-sitter-cli",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000,
    },
  },
}
