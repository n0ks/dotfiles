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
				return { "--hidden" }
			end,
		},
		find_files = {
			hidden = true,
			file_ignore_patterns = { ".git/" },
		},
	},
})

telescope.load_extension("git_worktree")
telescope.load_extension("fzf")
telescope.load_extension("media_files")

local M = {}

M.search_dotfiles = function()
	builtin.find_files({
		prompt_title = "< DOTFILES >",
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
				local cmd
				local isMac = 1 == vim.fn.has("macunix")
				local isLinux = 1 == vim.fn.has("linux")

				local hasMacExecutable = 1 == vim.fn.executable("m")
				local hasLinuxExecutable = 1 == vim.fn.executable("feh")

				if isMac and hasMacExecutable then
					cmd = "m wallpaper " .. selection.cwd .. "/" .. selection.value
				end

				if isLinux and hasLinuxExecutable then
					cmd = "feh --bg-fill " .. selection.cwd .. "/" .. selection.value
				end

				if cmd ~= nil then
					vim.fn.system(cmd)
				else
					vim.notify("Not possible to set wallpaper", vim.log.levels.INFO)
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

M.open_diff = function()
	require("telescope.builtin").git_commits({
		attach_mappings = function(_, map)
			map("n", "<c-o>", function()
				local selected_entry = state.get_selected_entry()
				local value = selected_entry["value"]
				-- close Telescope window properly prior to switching windows
				vim.api.nvim_win_close(0, true)
				local cmd = "DiffviewOpen " .. value

				vim.cmd(cmd)
			end)
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

M.live_grep_qflist = function()
	local qflist = vim.fn.getqflist()
	local filetable = {}
	local hashlist = {}

	for _, value in pairs(qflist) do
		local name = vim.api.nvim_buf_get_name(value.bufnr)

		if not hashlist[name] then
			hashlist[name] = true
			table.insert(filetable, name)
		end
	end

	builtin.live_grep({ search_dirs = filetable })
end

M.notifications = function()
	telescope.extensions.notify.notify()
end

vim.cmd(
	[[command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})]]
)

return M
