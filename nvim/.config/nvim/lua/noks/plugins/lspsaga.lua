return {
  {
    "nvimdev/lspsaga.nvim",
    -- Global keymaps use :Lspsaga; without cmd, lazy has no stub and K
    -- errors until the first LSP attach.
    cmd = "Lspsaga",
    event = "LspAttach",
    opts = {

      request_timeout = 4000,
      lightbulb = {
        enable = false,
        enable_in_insert = true,
        virtual_text = false,
      },
      symbol_in_winbar = {
        enable = true,
      },
      ui = {
        border = "rounded",
        title = true,
      },
    },
  },
}
