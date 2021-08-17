local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    color_devicons = true,
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',
    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    mappings = {
        i = {
            ["<C-x>"] = false,
            ["<C-a>"] = actions.send_to_qflist,
            ["<C-s>"] = actions.toggle_selection,
            ["<C-q>"] = actions.send_selected_to_qflist,
        },
    }
  },
  extensions = {
    fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
    }
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
    }
}

require('telescope').load_extension('fzy_native')
require("telescope").load_extension("git_worktree")

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
        find_command = {'rg', '--files', '--iglob', '!.git', '--hidden'},
        previewer = false,
        follow = false
    })
end

M.git_branches = function()
    require("telescope.builtin").git_branches({
        attach_mappings = function(_, map)
            map('i', '<c-d>', actions.git_delete_branch)
            map('n', '<c-d>', actions.git_delete_branch)
            return true
        end
    })
end

return M
 

