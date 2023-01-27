local status, saga = pcall(require, "lspsaga")

if not status then
	return
end

saga.setup({
	request_timeout = 4000,
	lightbulb = {
		enable = false,
		enable_in_insert = true,
		virtual_text = false,
	},
	ui = {
		border = "rounded",
		title = true,
	},
})
