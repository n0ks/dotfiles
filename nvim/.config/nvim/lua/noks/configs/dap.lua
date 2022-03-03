local dap = require("dap")
local dap_install = require("dap-install")
local inspect = require("noks.configs.inspect")
require("nvim-dap-virtual-text").setup()

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

dap.defaults.fallback.exception_breakpoints = { "raised" }

dap_install.config("chrome", {})

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
	},
}

require("dapui").setup({
	sidebar = {
		-- open_on_start = true,
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			{
				id = "scopes",
				size = 0.50, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.30 },
			{ id = "stacks", size = 0.15 },
			{ id = "watches", size = 0.15 },
		},
		position = "left", -- Can be "left" or "right"
	},
	icons = { expanded = "▾", collapsed = "▸" },
})

