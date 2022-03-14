local M = {}
local lspconfig = require("lspconfig")

M.setup = function()
	lspconfig.tsserver.setup({
		capabilities = require("noks.lsp.handlers").capabilities,
		on_attach = function(client, bufnr)
			local ts_utils = require("nvim-lsp-ts-utils")

			ts_utils.setup({
				debug = true,
				disable_commands = false,
				enable_import_on_completion = true,
				import_all_timeout = 5000, -- ms
				eslint_bin = "eslint_d",
				import_all_priorities = {
					same_file = 1, -- add to existing import statement
					local_files = 2, -- git files or files with relative path markers
					buffer_content = 3, -- loaded buffer content
					buffers = 4, -- loaded buffer names
				},
				import_all_scan_buffers = 100,
				import_all_select_source = true,
				filter_out_diagnostics_by_severity = { "hint" },
				filter_out_diagnostics_by_code = {},
				auto_inlay_hints = true,
				inlay_hints_highlight = "Comment",
				update_imports_on_move = false,
				require_confirmation_on_move = false,
				enable_formatting = false,
			})

			require("noks.lsp.handlers").on_attach(client, bufnr)
			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			local opts = { silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)

			vim.cmd([[ command! ESfix execute '!npm run lint:fix' ]])
			-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
		end,
	})
end

return M
