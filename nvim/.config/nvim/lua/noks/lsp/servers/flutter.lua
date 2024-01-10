local M = {}

local map = require("noks.configs.utils").map

M.setup = function()
	require("flutter-tools").setup({
		closing_tags = {
			enabled = false,
		},
		debugger = {
			enabled = true,
			run_via_dap = true,
			register_configurations = function(_)
				-- require("dap").configurations.dart = {}
				require("dap.ext.vscode").load_launchjs()
			end,
		},
		dev_log = {
			open_cmd = "tabnew",
			notify_errors = false,
		},
		dev_tools = {
			autostart = true,
		},
		lsp = {
			settings = {
				showTodos = false,
				renameFilesWithClasses = "always",
				documentation = "full",
			},
			color = {
				enabled = true,
			},
			capabilities = require("noks.lsp.handlers").capabilities,
			on_attach = function(_, bufnr)
				vim.lsp.handlers["textDocument/publishDiagnostics"] =
					vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						virtual_text = false,
						underline = true,
					})

				map("n", "<F1>", ":FlutterRun<CR>")
				map("n", "<F2>", ":FlutterReload<CR>")
				map("n", "<F3>", ":FlutterRestart<CR>")
				map("n", "<F4>", ":lua require('telescope').extensions.flutter.commands()<CR>")

				vim.cmd([[
              command FlutterRunDevelopment :FlutterRun --flavor development --target=lib/main_development.dart
              command BuildRunner AsyncRun -mode=term -focus=0 -rows=12 flutter pub run build_runner build --delete-conflicting-outputs
              command L10n AsyncRun -mode=term -focus=0 -rows=12 flutter gen-l10n
              command -nargs=1 CreateBlocFolder :lcd %:h | AsyncRun mkdir bloc && touch bloc/<args>.state.dart bloc/<args>.events.dart
              command DartFix AsyncRun -cwd=$(VIM_FILEDIR) dart fix --apply
              command DartFixDry AsyncRun -cwd=$(VIM_FILEDIR) dart fix --dry-run
              command ToFreezed AsyncRun! -cwd=$(VIM_FILEDIR) quicktype "$(VIM_FILEPATH)" -l dart --no-enums --use-freezed -o "$(VIM_FILEPATH)"
          ]])

				require("noks.lsp.handlers").on_attach(_, bufnr)
			end,
		},
	})
end

return M
