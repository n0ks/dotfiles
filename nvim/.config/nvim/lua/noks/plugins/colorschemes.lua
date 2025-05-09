return {

	{
		"AlexvZyl/nordic.nvim",
		-- priority = 1000,
		-- lazy = false,
		config = function()
			-- vim.cmd([[colorscheme nordic]])
		end,
		opts = {
			bold_keywords = false,
			transparent = {
				bg = false,
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
		opts = {
			term_colors = true,
			flavour = "mocha",
			transparent_background = false,
			show_end_of_buffer = false,
			styles = {
				bold = true,
				italic = true,
				transparency = true,
			},
			highlight_overrides = {
				mocha = function(mocha)
					return {
						LineNr = { fg = mocha.subtext0 },
					}
				end,
			},
			color_overrides = {
				all = {
					text = "#ffffff",
				},
				mocha = {
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			integrations = {
				gitsigns = true,
				telescope = true,
				dap = {
					enabled = true,
					enable_ui = true,
				},
			},
		},
		config = function()
			-- vim.api.nvim_command("colorscheme catppuccin")
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		-- priority = 1000,
		-- lazy = false,
		opts = {
			transparent = false,
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
		"EdenEast/nightfox.nvim",
		-- priority = 1000,
		config = function()
			-- require("nightfox").setup({
			--   options = {
			--     transparent = true,
			--     styles = {
			--       comments = "italic",
			--       functions = "italic",
			--     },
			--   },
			-- })
			-- vim.cmd("colorscheme nightfox")
		end,
	},
	{
		"jesseleite/nvim-noirbuddy",
		enabled = false,
		dependencies = {
			{ "tjdevries/colorbuddy.nvim" },
		},
		-- lazy = false,
		-- priority = 1000,
		opts = {
			preset = "slate",
			colors = {
				primary = "#de2666",
			},
		},
	},
	{
		"scottmckendry/cyberdream.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			-- require("cyberdream").setup({
			--   transparent = true,
			--   cache = true,
			-- })

			-- vim.cmd("colorscheme cyberdream")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
        transparent_mode = true
      })

			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"zootedb0t/citruszest.nvim",
		-- lazy = false,
		-- priority = 1000,
		config = function()
			-- vim.cmd("colorscheme citruszest")
		end,
	},
}
