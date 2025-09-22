return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "Kaiser-Yang/blink-cmp-avante" },
  version = "1.*",
  event = "VimEnter",
  opts = {
    enabled = function()
      return vim.bo.buftype ~= "NvimTree"
    end,
    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
    },
    keymap = { preset = "super-tab" },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = { window = { border = "single" }, enabled = true },

    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before *and* after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = "full" },
      -- list = {
      --   selection = function(ctx)
      --     return ctx.mode == "cmdline" and "auto_insert" or "preselect"
      --   end,
      -- },
      documentation = {
        auto_show = true,
        window = { border = "single" },
      },
      ghost_text = { enabled = false },
      menu = {
        auto_show = true,
        -- border = "single",
        draw = {
          padding = { 2, 4 }, -- padding only on right side
          gap = 2,
          components = {
            kind_icon = {
              text = function(ctx)
                return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
              end,
            },
          },
        },
      },
    },

    sources = {
      default = { "avante", "lsp", "path",  "snippets" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
          },
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
