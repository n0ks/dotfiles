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
			fileName = "notes",
			-- location = "~/",
		},
		right = {
			enabled = false,
		},
		bo = {
			filetype = "md",
		},
	},
})
