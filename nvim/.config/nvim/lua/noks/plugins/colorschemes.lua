return {

	{
		"AlexvZyl/nordic.nvim",
		-- priority = 1000,
		-- lazy = false,
		config = function()
			-- require("nordic").load()
		end,
		opts = {
			bold_keywords = false,
			transparent = {
				bg = true,
				float = true,
			},
			bright_border = true,
		},
	},
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "night",
			transparent = true,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				sidebars = "transparent",
				floats = "transparent",
			},
			sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
			hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
			dim_inactive = true, -- dims inactive windows
			lualine_bold = false,
		},
		config = function()
			-- vim.api.nvim_command("colorscheme tokyonight-night")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "main",
			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
		},
		config = function()
			-- vim.api.nvim_command("colorscheme rose-pine-main")
		end,
	},
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

	{
		"rebelot/kanagawa.nvim",
		-- priority = 1000,
		-- lazy = false,
		opts = {
			transparent = true,
			dimInactive = false,
			theme = "wave",
			overrides = function(colors)
				local theme = colors.theme
				return {
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				}
			end,
		},
		config = function()
			-- vim.api.nvim_command("colorscheme kanagawa")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		-- priority = 1000,
		config = function()
			-- require("cyberdream").setup({
			--   transparent = true,
			--   cache = true,
			-- })

			-- vim.cmd("colorscheme cyberdream")
		end,
	},
}
