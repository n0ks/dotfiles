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

-- dap.listeners.after["event_initialized"]["dapui"] = function()
-- 	require("dapui").open()
-- end

-- dap.listeners.after["event_terminated"]["dapui"] = function()
-- 	require("dapui").close()
-- 	vim.cmd("bd! \\[dap-repl]")
-- end

vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]

dap.configurations.typescript = {
	{
		console = "integratedTerminal",
		cwd = vim.fn.getcwd(),
		name = "Run",
		outFiles = { "${workspaceFolder}/build/*.js" },
		program = "${file}",
		protocol = "inspector",
		request = "launch",
		sourceMaps = true,
		type = "node2",
	},
	{
		cwd = vim.fn.getcwd(),
		name = "Attach to process",
		processId = require("dap.utils").pick_process,
		protocol = "inspector",
		request = "attach",
		skipFiles = { "<node_internals>/**/*.js" },
		sourceMaps = true,
		type = "node2",
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
		name = "Launch file",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		restart = true,
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

dap.adapters.go = {
	type = "executable",
	command = "node",
	args = {
		vim.fn.stdpath("data") .. "/dapinstall/go/" .. "/vscode-go/out/src/debugAdapter/goDebug.ts",
	},
}

dap.configurations.go = {
	{
		type = "go",
		request = "attach",
		name = "Attach Debugger",
		cwd = vim.fn.getcwd(),
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		type = "go",
		name = "Debug",
		request = "launch",
		showLog = true,
		program = "${file}",
		console = "externalTerminal",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		name = "Test Current File",
		type = "go",
		request = "launch",
		showLog = true,
		mode = "test",
		program = ".",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
}

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
