local M = {}

local null_ls = require("null-ls")

M.setup = function()
	null_ls.setup({
		sources = {
			-- null_ls.builtins.diagnostics.eslint_d,
			-- null_ls.builtins.code_actions.eslint_d,
			-- null_ls.builtins.formatting.eslint_d,
			null_ls.builtins.diagnostics.shellcheck,
			null_ls.builtins.code_actions.shellcheck,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			null_ls.builtins.formatting.prettier.with({
				filetypes = {
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"css",
					"scss",
					"less",
					"html",
					"json",
					"yaml",
					"markdown",
					"graphql",
				},
				-- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
			}),
		},
	})
end

return M
