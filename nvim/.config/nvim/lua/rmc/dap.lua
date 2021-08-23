local dap = require("dap")

vim.fn.sign_define("DapBreakpoint", { text = "⭕", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🐛", texthl = "", linehl = "", numhl = "" })
dap.defaults.fallback.exception_breakpoints = { "raised" }

require("dapui").setup({
	sidebar = {
		open_on_start = true,
		elements = {
			-- Provide as ID strings or tables with "id" and "size" keys
			{
				id = "scopes",
				size = 0.45, -- Can be float or integer > 1
			},
			{ id = "breakpoints", size = 0.20 },
			{ id = "stacks", size = 0.20 },
			{ id = "watches", size = 00.20 },
		},
		width = 40,
		position = "left", -- Can be "left" or "right"
	},
})

-- .exit               Closes the REPL
-- .c or .continue     Same as |dap.continue|
-- .n or .next         Same as |dap.step_over|
-- .into               Same as |dap.step_into|
-- .into_target        Same as |dap.step_into{askForTargets=true}|
-- .out                Same as |dap.step_out|
-- .up                 Same as |dap.up|
-- .down               Same as |dap.down|
-- .goto               Same as |dap.goto_|
-- .scopes             Prints the variables in the current scopes
-- .threads            Prints all threads
-- .frames             Print the stack frames
-- .capabilities       Print the capabilities of the debug adapter
-- .b or .back         Same as |dap.step_back|
-- .rc or
-- .reverse-continue   Same as |dap.reverse_continue|
