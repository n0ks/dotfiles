return {
	"yetone/avante.nvim",
	cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle", "AvanteEdit" },
	version = false,
	opts = {
		behaviour = {
			auto_suggestions = false,
		},
		suggestion = {
			debounce = 1000,
		},

		-- add any opts here
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{
			"HakonHarnes/img-clip.nvim",
			cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle", "AvanteEdit" },
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
