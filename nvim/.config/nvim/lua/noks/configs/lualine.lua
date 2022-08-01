local navic = require("nvim-navic")
local palette = require("nightfox.palette").load("duskfox")

require("lualine").setup({
  extensions = { "quickfix", "fugitive" },
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = " | ",
    icons_enabled = 1,
    globalstatus = false,
  },
  tabline = { lualine_a = { { "filename", color = { bg = palette.blue.base, fg = palette.fg0 } } } },
  winbar = {
    lualine_a = {
      { navic.get_location, cond = navic.is_available or false, color = { bg = palette.bg0, fg = palette.fg0 } },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "b:gitsigns_status" },
    lualine_c = {},
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      "encoding",
      "filetype",
    },
  },
})
