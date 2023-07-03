local M = {}

local nls = require("null-ls")

M.setup = function()
	nls.setup({
		sources = {
			nls.builtins.formatting.gofmt,
			nls.builtins.formatting.goimports,
			nls.builtins.diagnostics.golangci_lint,
			nls.builtins.diagnostics.eslint_d,
			nls.builtins.code_actions.eslint_d,
			nls.builtins.formatting.eslint_d,
			nls.builtins.diagnostics.shellcheck,
			nls.builtins.code_actions.shellcheck,
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.shfmt,
			-- nls.builtins.formatting.dart_format,
			nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			nls.builtins.formatting.prettier.with({
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
			}),
		},
	})
end

return M
