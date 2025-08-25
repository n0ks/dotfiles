return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"stevearc/overseer.nvim",
			{
				"microsoft/vscode-js-debug",
				-- After install, build it and rename the dist directory to out
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
				version = "1.*",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					---@diagnostic disable-next-line: missing-fields
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
						debugger_cmd = { "js-debug-adapter" },
						adapters = {
							"chrome",
							"pwa-node",
							"pwa-chrome",
							"pwa-msedge",
							"pwa-extensionHost",
							"node-terminal",
						},
					})
				end,
			},
		},
		keys = {
			-- Basic debugging keymaps, feel free to change to your liking!
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Debug: Start/Continue",
			},
			{
				"<F1>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step Into",
			},
			{
				"<F2>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step Over",
			},
			{
				"<F3>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step Out",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle Breakpoint",
			},
			{
				"<leader>B",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{
				"<F7>",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: See last session result.",
			},
			{
				"<M-i>",
				function()
					require("dapui").eval()
				end,
				desc = "Debug: Eval",
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local utils = require("dap.utils")

			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			-- require("dap-go").setup()
			require("nvim-dap-virtual-text").setup()

			local js_based_languages = {
				"typescript",
				"javascript",
				"typescriptreact",
				"javascriptreact",
			}
			dap.adapters = {
				["pwa-node"] = {
					type = "server",
					port = "${port}",
					host = "localhost",
					-- restart = true,
					executable = {
						command = "node",
						args = {
							vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
							"${port}",
						},
					},
				},
			}

			local vscode = require("dap.ext.vscode")

			vscode.type_to_filetypes["node"] = js_based_languages
			vscode.type_to_filetypes["pwa-node"] = js_based_languages
			vscode.load_launchjs(nil, {})

			for _, language in pairs(js_based_languages) do
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						-- protocol = "inspector",
						-- skipFiles = { "<node_internals>/**", "node_modules/**" },
						-- resolveSourceMapLocations = {
						--   "${workspaceFolder}/**",
						--   "!**/node_modules/**",
						-- },
					},
					{
						type = "pwa-node",
						request = "attach",
						port = 9231,
						name = "Attach to process ID",
						processId = utils.pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open

			dap.listeners.before.event_terminated["dapui_config"] = dapui.close

			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
			vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
			vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
			vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
			)

			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "•", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "•", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)

			dap.defaults.fallback.exception_breakpoints = { "raised" }

			dap.set_log_level("DEBUG")

			vim.cmd([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]])
		end,
	},
}
