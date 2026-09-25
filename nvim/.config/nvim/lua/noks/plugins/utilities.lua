return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "johmsalas/text-case.nvim", config = true, event = "VeryLazy" },
  { "mzlogin/vim-markdown-toc", event = "BufEnter *.md" },
  { "skywind3000/asyncrun.vim", event = "VeryLazy" },
  { "tpope/vim-projectionist", cmd = { "A", "AV", "AS", "AT" } },
  { "junegunn/fzf", lazy = true, build = "./install --bin" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "kevinhwang91/nvim-bqf",
    opts = {
      filter = {
        fzf = {
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
        },
      },
      preview = {
        auto_preview = false,
      },
    },
    event = "VeryLazy",
  },

  {
    "rcarriga/nvim-notify",
    enabled = false,
    config = function()
      vim.notify = require("notify")

      ---@diagnostic disable-next-line: undefined-field
      vim.notify.setup({
        timeout = 3000,
        background_colour = "#FFFFFF",
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
