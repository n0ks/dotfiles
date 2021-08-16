
nnoremap <leader>ps <cmd>Telescope find_files prompt_prefix=🗄 <cr>
nnoremap <leader>pl <cmd>Telescope live_grep prompt_prefix=🔍<cr>
nnoremap <leader>pb <cmd>Telescope buffers<cr>
nnoremap <leader>ph <cmd>Telescope help_tags<cr>
nnoremap <leader>gdi :Telescope git_bcommits<CR>
nnoremap <leader>pz :Files<CR>
nnoremap <leader>pf :Ag<CR>
nnoremap <leader>sb :lua require('rmc.telescope').search_bv()<CR>
nnoremap <leader>sd :lua require('rmc.telescope').search_dotfiles()<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>tr :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
nnoremap <leader>tc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>

command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
