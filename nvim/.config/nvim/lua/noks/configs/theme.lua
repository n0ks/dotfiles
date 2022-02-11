vim.g.rose_pine_variant = "moon"
vim.g.rose_pine_bold_vertical_split_line = true
vim.g.rose_pine_disable_background = true

-- vim.cmd("colorscheme rose-pine")

require("catppuccin").setup({
  transparent_background = true,
	term_colors = true,
  transparent_background = true,
	integrations = {
		gitsigns = true,
    telescope = true,
    fern = true
	},
})

vim.cmd("colorscheme catppuccin")

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
]])

-- vim.g.rose_pine_disable_background = true
