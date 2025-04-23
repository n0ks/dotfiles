return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "css",
        "dockerfile",
        "go",
        "gomod",
        "gowork",
        "gotmpl",
        "gohtmltmpl",
        "gotexttmpl",
        "html",
        "javascript",
        "tsx",
        "lua",
        "scss",
        "typescript",
        "jsonc",
        "ruby",
        "vim",
        "yaml",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      playground = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      highlight = {
        enable = true,
      },
      incremental_selection = { enable = true },
      indent = { enable = true },
      autopairs = { enable = false },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    },
  },
}
