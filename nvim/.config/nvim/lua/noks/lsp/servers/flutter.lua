local M = {}

M.setup = function()
	require("flutter-tools").setup({
		fvm = true,
		debugger = {
			enabled = true,
			run_via_dap = true,
			-- valid only when run_via_dap is false
			-- register_configurations = function(paths)
			-- 	require("dap").configurations.dart = {
			-- 		{
			-- 			type = "dart",
			-- 			request = "launch",
			-- 			name = "Launch flutter (default)",
			-- 			program = "${workspaceFolder}/lib/main.dart",
			-- 			cwd = "${workspaceFolder}",
			-- 		},
			-- 		{
			-- 			type = "dart",
			-- 			request = "launch",
			-- 			name = "Launch flutter (DEV)",
			-- 			program = "${workspaceFolder}/lib/main_development.dart",
			-- 			cwd = "${workspaceFolder}",
			-- 			args = { "--flavor", "development" },
			-- 		},
			-- 		{
			-- 			type = "dart",
			-- 			request = "attach",
			-- 			name = "Attach (DEV)",
			-- 			program = "${workspaceFolder}/lib/main_development.dart",
			-- 			cwd = "${workspaceFolder}",
			-- 			args = { "--flavor", "development" },
			-- 		},
			-- 	}
			-- end,
		},
		lsp = {
			color = {
				enabled = true,
			},
			on_attach = function(_, bufnr)
				vim.lsp.handlers["textDocument/publishDiagnostics"] =
					vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						virtual_text = false,
						underline = true,
					})

				vim.cmd([[
              command FlutterRunDevelopment :FlutterRun --flavor development --target=lib/main_development.dart
              command BuildRunner AsyncRun -mode=term -focus=0 -rows=12 flutter pub run build_runner build --delete-conflicting-outputs
              command L10n AsyncRun -mode=term -focus=0 -rows=12 flutter gen-l10n
              command -nargs=1 CreateBlocFolder :lcd %:h | AsyncRun mkdir bloc && touch bloc/<args>.state.dart bloc/<args>.events.dart
              command DartFix AsyncRun -cwd=$(VIM_FILEDIR) dart fix --apply 
              command DartFixDry AsyncRun -cwd=$(VIM_FILEDIR) dart fix --dry-run 
          ]])

				require("noks.lsp.handlers").on_attach(_, bufnr)
			end,

			capabilities = require("noks.lsp.handlers").capabilities,
		},
	})
end

return M
