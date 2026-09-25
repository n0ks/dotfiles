return {
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeOpen" },
		opts = {

			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				api.events.subscribe(api.events.Event.FileCreated, function(file)
					vim.cmd("edit " .. file.fname)
				end)

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				-- Only the mappings that diverge from default_on_attach above
				vim.keymap.set("n", "<", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end,
			sort_by = "case_sensitive",
			sync_root_with_cwd = false,
			hijack_cursor = true,
			notify = {
				threshold = vim.log.levels.ERROR,
			},
			hijack_netrw = true,
			disable_netrw = true,
			renderer = {
				group_empty = true,
				full_name = true,
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
					},
				},
				indent_markers = {
					enable = true,
				},
			},
			update_focused_file = {
				enable = true,
				update_root = false,
				ignore_list = { "help" },
			},
			filters = {
				dotfiles = true,
				custom = {
					-- "^.git$",
				},
			},
		},
}
