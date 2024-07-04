local M = {}

local nls = require("null-ls")

M.setup = function()
	nls.setup({
		sources = {
			-- nls.builtins.diagnostics.golangci_lint,
			-- nls.builtins.diagnostics.shellcheck,
			-- nls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			nls.builtins.formatting.gofumpt,
			nls.builtins.formatting.goimports_reviser.with({ extra_args = { "-rm-unused", "-company-prefixex" } }),
			nls.builtins.formatting.golines,
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
