return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({})
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod", "tmpl" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod" },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      -- Connection URLs live outside the repo; export e.g.
      -- SNIPPETBOX_DB_URL=mysql://user:pass@localhost/snippetbox
      vim.g.dbs = {}
      if vim.env.SNIPPETBOX_DB_URL then
        vim.g.dbs = {
          { name = "snippetbox", url = vim.env.SNIPPETBOX_DB_URL },
        }
      end
    end,
  },
}
