local status, saga = pcall(require, "lspsaga")

if not status then
	return
end

saga.setup({
	lightbulb = {
		enable = false,
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
	ui = {
		border = "rounded",
	},
})
