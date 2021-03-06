local actions = require("telescope.actions")

require("harpoon").setup({
	menu = {
		width = 100,
		height = 20,
	},
})

require("telescope").setup({
	defaults = {
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		color_devicons = true,
		prompt_prefix = "❯ ",
		selection_caret = " ➡️ ",
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-s>"] = actions.toggle_selection,
				["<C-q>"] = actions.smart_send_to_qflist,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			show_all_buffers = true,
			theme = "ivy",
			mappings = {
				i = { ["<c-x>"] = "delete_buffer" },
				n = { ["<c-x>"] = "delete_buffer" },
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("projects")

local M = {}

M.search_bv = function()
	require("telescope.builtin").find_files({
		prompt_title = "< Banco BV >",
		cwd = "$HOME/Documents/Projects/flutter_bvpd/",
	})
end

M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< DOTFILES >",
		cwd = "$HOME/.dotfiles",
		find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
		previewer = false,
		follow = false,
	})
end

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			return true
		end,
	})
end

return M
