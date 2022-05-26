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
	dark_variant = "moon",
	disable_background = true,
})

require("nightfox").setup({
	options = {
		transparent = true,
	},
})

vim.g.nightflyTransparent = 1
vim.g.nightflyWinSeparator = 2
-- vim.cmd("colorscheme nightfly")
-- vim.cmd("colorscheme catppuccin")
-- vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme nightfox")
-- vim.cmd("colorscheme rose-pine")

-- highlight Normal guibg=none
-- highlight NonText guibg=none
vim.cmd([[
  set laststatus=3
]])
