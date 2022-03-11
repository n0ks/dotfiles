local dap = require("dap")
local dap_install = require("dap-install")
local inspect = require("noks.configs.inspect")
require("nvim-dap-virtual-text").setup()

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

dap.defaults.fallback.exception_breakpoints = { "raised" }

dap_install.config("chrome", {})
dap_install.config("jsnode", {})

dap.configurations.typescript = {
	{
		name = "Run",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		outFiles = { "${workspaceFolder}/build/*.js" },
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/dapinstall/jsnode/" .. "/vscode-node-debug2/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
}

dap.configurations.typescriptreact = {
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
		console = "integratedTerminal",
	},
}

-- test latter

-- dap.adapters.go = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = {
-- 		vim.fn.stdpath("data") .. "/dapinstall/go/" .. "/vscode-go/out/src/debugAdapter/goDebug.ts",
-- 	},
-- }

-- dap.configurations.go = {
-- 	{
-- 		type = "go",
-- 		name = "Debug",
-- 		request = "launch",
-- 		showLog = true,
-- 		program = "${file}",
-- 		console = "externalTerminal",
-- 		dlvToolPath = vim.fn.exepath("dlv"),
-- 	},
-- 	{
-- 		name = "Test Current File",
-- 		type = "go",
-- 		request = "launch",
-- 		showLog = true,
-- 		mode = "test",
-- 		program = ".",
-- 		dlvToolPath = vim.fn.exepath("dlv"),
-- 	},
-- }

require("dapui").setup({
	sidebar = {
		-- open_on_start = true,
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			{
				id = "scopes",
				size = 0.30, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.25 },
			{ id = "stacks", size = 0.25 },
			{ id = "watches", size = 0.25 },
		},
		position = "left", -- Can be "left" or "right"
	},
	icons = { expanded = "▾", collapsed = "▸" },
})
