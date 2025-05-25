return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local nls = require("null-ls")
		nls.setup({
			sources = {
				nls.builtins.diagnostics.golangci_lint.with({ extra_args = { "--fast" } }),
				nls.builtins.formatting.gofumpt,
				nls.builtins.formatting.dart_format.with({ extra_args = { "-l 120" } }),
				nls.builtins.formatting.goimports_reviser.with({
					extra_args = { "-rm-unused", "-company-prefixes" },
				}),
				-- nls.builtins.diagnostics.shellcheck,
				nls.builtins.formatting.golines.with({
					extra_args = {
						"--max-len=180",
						"--base-formatter=gofumpt",
					},
				}),
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
	end,
}
