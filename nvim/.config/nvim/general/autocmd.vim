autocmd FileType netrw setl bufhidden=delete
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
au BufRead,BufNewFile Fastfile set filetype=ruby

augroup fixlist
    autocmd!
    autocmd BufWinEnter quickfix call SetQFControlVariable()
    autocmd BufWinLeave * call UnsetQFControlVariable()
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END


" Set to auto read when a file is changed from the outside.
augroup read_file_on_change
  autocmd!

  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
augroup END



