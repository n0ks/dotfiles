local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		color_devicons = true,
    prompt_prefix = " λ ",
		selection_caret = " > ",
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		layout_strategy = "flex",
		winblend = 0,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-s>"] = actions.toggle_selection,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close
			},
			n = {
				["<C-q>"] = actions.smart_send_to_qflist,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			show_all_buffers = true,
			previewer = false,
			theme = "dropdown",
			mappings = {
				i = { ["<c-x>"] = "delete_buffer" },
				n = { ["<c-x>"] = "delete_buffer" },
			},
		},
		live_grep = {
			file_ignore_patterns = { ".git/" },
		},
		find_files = {
			hidden = true,
			file_ignore_patterns = { ".git/" },

		},
	},
})

telescope.load_extension("git_worktree")
telescope.load_extension("projects")
telescope.load_extension("fzf")

local M = {}

M.search_dotfiles = function()
	builtin.find_files({
		prompt_title = "< DOTFILES >",
		cwd = "$HOME/.dotfiles",
		find_command = { "rg", "--files", "--iglob", "!*.{jpg,png}", "--hidden" },
		previewer = false,
		follow = false,
	})
end

M.git_branches = function()
	builtin.git_branches({
		attach_mappings = function(_, map)
			map("i", "<c-d>", actions.git_delete_branch)
			map("n", "<c-d>", actions.git_delete_branch)
			map("i", "<c-b>", actions.git_create_branch)
			map("n", "<c-b>", actions.git_create_branch)
			return true
		end,
	})
end

return M
