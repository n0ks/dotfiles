return {

	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				term_colors = false,
				flavour = "mocha",
				transparent_background = true,
				show_end_of_buffer = false,
				float = {
					transparent = true,
					solid = true,
				},
				color_overrides = {
					all = {
						text = "#ffffff",
					},
					-- mocha = {
					-- 	base = "#000000",
					-- 	mantle = "#000000",
					-- 	crust = "#000000",
					-- },
				},
				integrations = {
					gitsigns = true,
					telescope = true,
					dap = {
						enabled = true,
						enable_ui = true,
					},
				},
			})

			vim.api.nvim_command("colorscheme catppuccin")
		end,
	},

}
