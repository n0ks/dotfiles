return {
  "nvim-tree/nvim-web-devicons",
  "stevearc/dressing.nvim",
  "tpope/vim-repeat",
  { "b0o/schemastore.nvim", event = "BufEnter *.json" },
  { "johmsalas/text-case.nvim", config = true, event = "VeryLazy" },
  { "mzlogin/vim-markdown-toc", event = "BufEnter *.md" },
  { "skywind3000/asyncrun.vim", event = "VeryLazy" },
  { "tpope/vim-projectionist", enabled = true },
  { "junegunn/fzf", build = "./install --bin" },
  {
    "iamcco/markdown-preview.nvim",
    event = "BufEnter *.md",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
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
    kjvent = "VeryLazy",
    opts = {
      pre_hook = function(ctx)
        if vim.bo.filetype == "typescriptreact" then
          local U = require("Comment.utils")

          -- Determine whether to use linewise or blockwise commentstring
          local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

          -- Determine the location where to calculate commentstring from
          local location = nil
          if ctx.ctype == U.ctype.blockwise then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end

          return require("ts_context_commentstring.internal").calculate_commentstring({
            key = type,
            location = location,
          })
        end
      end,
    },
  },
}
