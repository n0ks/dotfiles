
let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

nnoremap <silent><nowait><M-q> :call ToggleQFList(1)<CR>
nnoremap <silent><leader>q :call ToggleQFList(0)<CR>

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            cclose
        else
            copen
        end
    else
        echo 'toggle locallist'
        if g:the_primeagen_qf_l == 1
            lclose
        else
            lopen
        end
    endif
endfun
