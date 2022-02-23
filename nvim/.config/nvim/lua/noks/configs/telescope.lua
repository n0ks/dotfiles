local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local inspect = require("noks.configs.inspect")

telescope.setup({
	defaults = {
		color_devicons = true,
		prompt_prefix = " λ ",
		selection_caret = " > ",
		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,
		layout_strategy = "flex",
		winblend = 0,
		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-s>"] = actions.toggle_selection,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
			},
			n = {
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
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
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
		},
	},
	pickers = {
		buffers = {
			show_all_buffers = false,
			ignore_current_buffer = true,
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
telescope.load_extension("media_files")

local M = {}

M.search_dotfiles = function()
	builtin.find_files({
		prompt_title = "< DOTFILES >",
		path_display = { "smart" },
		cwd = "$HOME/.dotfiles",
		find_command = { "rg", "--files", "--iglob", "!*.{jpg,png,ttf}", "--hidden" },
		previewer = false,
		follow = false,
	})
end

M.search_wallpapers = function()
	builtin.find_files({
		prompt_title = "< WALLPAPERS >",
		cwd = "$HOME/wallpapers",
		find_command = { "rg", "--files" },
		previewer = false,
		follow = false,
		attach_mappings = function(bufnr, _)
			actions.select_default:replace(function()
				actions.close(bufnr)

				local selection = require("telescope.actions.state").get_selected_entry(bufnr)

				local cmd = "feh --bg-fill " .. selection.cwd .. "/" .. selection.value

				if selection then
					vim.fn.system(cmd)
				end
			end)
			return true
		end,
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

M.document_symbols = function()
	require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_dropdown({
		hidden = true,
		depth = 1,
		previewer = false,
		layout_config = {
			width = 0.5,
			height = 0.35,
		},
	}))
end


return M
