return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		branch = "main",
		lazy = false,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					-- Enable treesitter highlighting and disable regex syntax
					pcall(vim.treesitter.start)
					-- Enable treesitter-based indentation
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			local ensureInstalled = {
				"bash",
				"css",
				"dart",
				"dockerfile",
				"go",
				"gomod",
				"gowork",
				"gotmpl",
				"html",
				"javascript",
				"tsx",
				"lua",
				"scss",
				"typescript",
				"ruby",
				"vim",
				"vimdoc",
				"markdown",
				"markdown_inline",
			}
			local alreadyInstalled = require("nvim-treesitter.config").get_installed()
			local parsersToInstall = vim.iter(ensureInstalled)
				:filter(function(parser)
					return not vim.tbl_contains(alreadyInstalled, parser)
				end)
				:totable()
			require("nvim-treesitter").install(parsersToInstall)
		end,
	},
}
