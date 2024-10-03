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
			dark_variant = "moon",
			disable_background = false,
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
			highlight_overrides = {
				mocha = function(mocha)
					return {
						LineNr = { fg = mocha.subtext0 },
					}
				end,
			},
			color_overrides = {
				mocha = {
					rosewater = "#EA6962",
					flamingo = "#EA6962",
					pink = "#D3869B",
					mauve = "#D3869B",
					red = "#EA6962",
					maroon = "#EA6962",
					peach = "#BD6F3E",
					yellow = "#D8A657",
					green = "#A9B665",
					teal = "#89B482",
					sky = "#89B482",
					sapphire = "#89B482",
					blue = "#7DAEA3",
					lavender = "#7DAEA3",
					text = "#D4BE98",
					subtext1 = "#BDAE8B",
					subtext0 = "#A69372",
					overlay2 = "#8C7A58",
					overlay1 = "#735F3F",
					overlay0 = "#5A4525",
					surface2 = "#4B4F51",
					surface1 = "#2A2D2E",
					surface0 = "#232728",
					base = "#1D2021",
					mantle = "#191C1D",
					crust = "#151819",
				},
				latte = {
					rosewater = "#c14a4a",
					flamingo = "#c14a4a",
					pink = "#945e80",
					mauve = "#945e80",
					red = "#c14a4a",
					maroon = "#c14a4a",
					peach = "#c35e0a",
					yellow = "#a96b2c",
					green = "#6c782e",
					teal = "#4c7a5d",
					sky = "#4c7a5d",
					sapphire = "#4c7a5d",
					blue = "#45707a",
					lavender = "#45707a",
					text = "#654735",
					subtext1 = "#7b5d44",
					subtext0 = "#8f6f56",
					overlay2 = "#a28368",
					overlay1 = "#b6977a",
					overlay0 = "#c9aa8c",
					surface2 = "#A79C86",
					surface1 = "#C9C19F",
					surface0 = "#DFD6B1",
					base = "#fbf1c7",
					mantle = "#F3EAC1",
					crust = "#E7DEB7",
				},
			},
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "bold" },
				functions = { "bold" },
				keywords = { "bold" },
				strings = {},
				variables = {},
				numbers = { "bold" },
				booleans = { "bold" },
				properties = {},
				types = { "bold" },
				operators = {},
			},
			integrations = {
				navic = true,
				gitsigns = true,
				telescope = true,
				fern = true,
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
		opts = {

			transparent = false,
			dimInactive = false,
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
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false,
					styles = {
						comments = "italic",
						functions = "italic,bold",
					},
				},
			})

			vim.cmd("colorscheme nordfox")
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
}
