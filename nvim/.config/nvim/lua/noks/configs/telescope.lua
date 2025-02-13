local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

local M = {}

M.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "< DOTFILES >",
    cwd = "$HOME/.dotfiles",
    find_command = { "rg", "--files", "--iglob", "!*.{jpg,png,ttf}", "--iglob", "!.git", "--hidden" },
    previewer = false,
    follow = false,
  })
end

M.search_notes = function()
  builtin.find_files({
    prompt_title = "< NOTES >",
    cwd = "$HOME/.dotfiles/private/notes",
    find_command = { "rg", "--files", "--iglob", "!*.{jpg,png,ttf}", "--hidden" },
    previewer = true,
    follow = false,
  })
end

M.find_files = function()
  builtin.find_files({
    prompt_title = "< Find Files >",
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
      map("n", "<cr>", actions.git_switch_branch)
      return true
    end,
  })
end

M.open_diff = function()
  builtin.git_commits({
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

vim.cmd(
  [[command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})]]
)

return M
