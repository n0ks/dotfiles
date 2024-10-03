return {

	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local previewers = require("telescope.previewers")
			require("telescope").setup({
				defaults = {
					color_devicons = true,
					prompt_prefix = " λ ",
					selection_caret = " > ",
					file_previewer = previewers.vim_buffer_cat.new,
					grep_previewer = previewers.vim_buffer_vimgrep.new,
					qflist_previewer = previewers.vim_buffer_qflist.new,
					layout_strategy = "flex",
					-- file_ignore_patterns = { ".git/", "%.js", "%.svg" },
					mappings = {
						i = {
							-- ["<C-x>"] = false,
							["<C-s>"] = actions.toggle_selection,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
						},
						n = {
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
					path_display = {
						truncate = 3,
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
					},
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
					},
				},
				pickers = {
					git_branches = {
						theme = "ivy",
						layout_config = {
							width = 0.75,
							preview_height = 0.2,
						},
					},
					lsp_document_symbols = {
						theme = "dropdown",
					},
					buffers = {
						show_all_buffers = false,
						ignore_current_buffer = true,
						previewer = false,
						theme = "dropdown",
						path_display = {
							shorten = { len = 1, exclude = { 1, -1 } },
						},
						mappings = {
							i = { ["<c-x>"] = "delete_buffer" },
							n = { ["<c-x>"] = "delete_buffer" },
						},
					},
					live_grep = {
						additional_args = function(opts)
							return { "--smart-case" }
						end,
					},
					find_files = {
						hidden = false,
						file_ignore_patterns = { ".git/" },
						previewer = false,
					},
					git_files = {
						file_ignore_patterns = { "%.png", "%.g.dart" },
					},
				},
			})

			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")

			-- telescope.load_extension("git_worktree")
			-- telescope.load_extension("media_files")
			-- telescope.load_extension("advanced_git_search")
			-- telescope.load_extension("textcase")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			-- "nvim-telescope/telescope-symbols.nvim",
			-- "aaronhallaert/advanced-git-search.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				lazy = true,
				build = "make",
			},
		},
	},
}
