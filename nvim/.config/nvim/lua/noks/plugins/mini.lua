return {

  { "echasnovski/mini.pairs",      version = false, config = true },
  { "echasnovski/mini.ai",         version = false, config = true },
  { "echasnovski/mini.surround",   version = false, config = true },
  { "echasnovski/mini.statusline", version = false, config = true },
  {
    "echasnovski/mini.files",
    version = false,
    opts = {},
    keys = {
      {
        "<leader>e",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
      },
    },
  },
}
