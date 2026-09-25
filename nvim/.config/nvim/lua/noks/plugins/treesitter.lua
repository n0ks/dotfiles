return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        ensure_installed = {
          "bash",
          "css",
          "dart",
          "dockerfile",
          "go",
          "gomod",
          "gowork",
          "gotmpl",
          "html",
          "javascript",
          "tsx",
          "lua",
          "scss",
          "typescript",
          "jsonc",
          "ruby",
          "vim",
          "vimdoc",
          "yaml",
          "markdown",
          "markdown_inline",
        },
        sync_install = false,
        highlight = {
          enable = true,
        },
        incremental_selection = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
