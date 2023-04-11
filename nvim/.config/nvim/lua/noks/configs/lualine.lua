local navic = require("nvim-navic")

require("lualine").setup({
	extensions = { "quickfix", "fugitive" },
	options = {
		theme = "auto",
		icons_enabled = 1,
		globalstatus = true,
	},
	tabline = {
		lualine_a = {
			{
				"filename",
				color = { bg = "#363646", fg = "#C8C093" },
				separator = { left = "", right = "" },
			},
		},
		lualine_x = {
			{ "tabs" },
		},
	},
	winbar = {},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "b:gitsigns_status" },
		lualine_c = {
			{
				function()
					return navic.get_location()
				end,
				cond = function()
					return navic.is_available()
				end,
			},
		},
		lualine_x = {
			"filetype",
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = { error = " ", warn = " ", info = " ", hint = " " },
			},
			{
				encoding = function()
					-- Override 'encoding': Don't display if encoding is UTF-8.
					local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
					return ret
				end,
			},
			{
				fileformat = function()
					local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
					return ret
				end,
			},
		},
	},
})
