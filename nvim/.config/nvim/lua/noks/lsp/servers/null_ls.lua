local M = {}

local nls = require("null-ls")

M.setup = function()
	nls.setup({
		sources = {
			-- nls.builtins.formatting.dart_format,
			-- nls.builtins.formatting.rubyfmt,
			nls.builtins.diagnostics.golangci_lint,
			-- nls.builtins.diagnostics.shellcheck,
			nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			nls.builtins.formatting.gofmt,
			nls.builtins.formatting.gofumpt,
			nls.builtins.formatting.goimports,
			nls.builtins.formatting.goimports,
			nls.builtins.formatting.shfmt,
			nls.builtins.formatting.stylua,
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
