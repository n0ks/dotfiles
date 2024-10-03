return {

  { "echasnovski/mini.statusline", version = false, config = true },

  {
    "glepnir/dashboard-nvim",
    enabled = true,
    event = "VimEnter",
    opts = {

      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = "lua require('noks.configs.telescope').search_dotfiles()",
            key = "d",
          },
        },
      },
    },
  },
}
