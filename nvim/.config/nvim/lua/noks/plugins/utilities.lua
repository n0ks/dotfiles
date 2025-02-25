return {

  "nvim-tree/nvim-web-devicons",
  "stevearc/dressing.nvim",
  "tpope/vim-repeat",
  { "ThePrimeagen/git-worktree.nvim", config = true, enabled = false },
  { "b0o/schemastore.nvim", event = "BufEnter *.json" },
  { "johmsalas/text-case.nvim", config = true, event = "VeryLazy" },
  { "mzlogin/vim-markdown-toc", event = "BufEnter *.md" },
  { "skywind3000/asyncrun.vim", event = "VeryLazy" },
  { "tpope/vim-projectionist", enabled = true },
  { "tpope/vim-rhubarb", enable = false },

  { "junegunn/fzf", build = "./install --bin" },
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      keymaps = {
        ["yp"] = {
          desc = "Copy filepath to system clipboard",
          callback = function()
            require("oil.actions").copy_entry_path.callback()
            vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
          end,
        },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<M-1>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<M-2>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<M-3>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<M-4>", function()
        harpoon:list():select(4)
      end)
      vim.keymap.set("n", "<M-5>", function()
        harpoon:list():select(5)
      end)
    end,
    opts = {
      menu = {
        width = 100,
        height = 20,
      },
      global_settings = {
        enter_on_sendcmd = true,
      },
    },
  },

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

  {
    "m00qek/baleia.nvim",
    enable = false,
    cmd = "BaleiaColorize",
    config = function()
      local b = require("baleia").setup({})
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        b.once(vim.api.nvim_get_current_buf())
      end, {})

      vim.cmd([[
          let s:baleia = luaeval("require('baleia').setup { }")
          autocmd BufWinEnter,BufRead dap-repl setlocal modifiable
          \| silent call s:baleia.automatically(bufnr('%'))
          \| setlocal nomodifiable
    ]])
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local nls = require("null-ls")
      nls.setup({
        sources = {
          nls.builtins.diagnostics.golangci_lint.with({ extra_args = { "--fast" } }),
          nls.builtins.formatting.gofumpt,
          nls.builtins.formatting.dart_format.with({ extra_args = { "-l 120" } }),
          nls.builtins.formatting.goimports_reviser.with({
            extra_args = { "-rm-unused", "-company-prefixes" },
          }),
          -- nls.builtins.diagnostics.shellcheck,
          nls.builtins.formatting.golines.with({
            extra_args = {
              "--max-len=180",
              "--base-formatter=gofumpt",
            },
          }),
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.prettier.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "css",
              "scss",
              "less",
              "html",
              "json",
              "yaml",
              "markdown",
              "graphql",
            },
          }),
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      behaviour = {
        auto_suggestions = false
      },
      suggestion = {
        debounce = 1000
      }

      -- add any opts here
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
