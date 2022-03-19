local M = {}

M.setup = function()
	require("flutter-tools").setup({
		ui = {
			border = nil,
			notification_style = nil,
		},
		fvm = true,
		dev_log = {
			open_cmd = "tabnew",
		},
		debugger = {
			enabled = true,
			run_via_dap = true,
			register_configurations = function(paths)
				P(paths)
				require("dap").configurations.dart = {
					{
						type = "dart",
						request = "launch",
						name = "Launch flutter (default)",
						program = "${workspaceFolder}/lib/main.dart",
						cwd = "${workspaceFolder}",
						dartSdkPath = paths.dart_sdk,
						flutterSdkPath = paths.flutter_sdk,
					},
					{
						type = "dart",
						request = "launch",
						name = "Launch flutter (DEV)",
						program = "${workspaceFolder}/lib/main_development.dart",
						cwd = "${workspaceFolder}",
						args = { "--flavor", "development" },
						dartSdkPath = paths.dart_sdk,
						flutterSdkPath = paths.flutter_sdk,
					},
				}
			end,
		},
		lsp = {
			on_attach = function(_, bufnr)
				vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics,
					{
						virtual_text = false,
						underline = true,
					}
				)
				vim.cmd(
					[[command FlutterRunDevelopment :FlutterRun --flavor development --target=lib/main_development.dart]]
				)
				require("noks.lsp.handlers").on_attach(_, bufnr)
			end,
			capabilities = require("noks.lsp.handlers").capabilities,
		},
	})
end

return M
