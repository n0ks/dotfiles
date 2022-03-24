require("catppuccin").setup({
	term_colors = true,
	transparent_background = true,
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

vim.cmd("colorscheme kanagawa")
-- vim.cmd("colorscheme catppuccin")

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  set laststatus=3
]])
