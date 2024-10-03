return {
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		build = function()
			vim.cmd.GoInstallDeps()
		end,
		opts = {},
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.dbs = {
				{ name = "snippetbox", url = "mysql://root@localhost/snippetbox" },
			}
		end,
	},
}
