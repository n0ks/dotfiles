require("no-neck-pain").setup({
	colors = {
		blend = 0.5,
	},
	buffers = {
		setNames = false,
		filename = "notes",
		scratchPad = {
			setNames = false,
			enabled = true,
			filename = "notes",
			-- location = "~/Documents/",
		},
		right = {
			enabled = false,
		},
		bo = {
			filetype = "md",
		},
	},
})
