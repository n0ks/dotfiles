require("catppuccin").setup({
  term_colors = true,
  -- transparent_background = true,
  integrations = {
    gitsigns = true,
    telescope = true,
    fern = true,
  },
})

require("kanagawa").setup({
  transparent = true,
  dimInactive = false,
  globalStatus = true,
})

require("rose-pine").setup({
  ---@usage 'main'|'moon'
  dark_variant = "main",
  disable_background = true,
})

require("nightfox").setup({
  options = {
    transparent = true,
  },
})

-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme nightfox")
vim.cmd("colorscheme rose-pine")

vim.cmd([[
  set laststatus=3
  highlight Normal guibg=none
  highlight NonText guibg=none
]])
