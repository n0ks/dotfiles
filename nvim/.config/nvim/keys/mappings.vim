
" ----------------------------------------------------------------------------
" General
" ----------------------------------------------------------------------------
inoremap  jk <Esc>
inoremap  kj <Esc>
" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$
nnoremap J mzJ`z
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap cn *``cgn
nnoremap cN *``cgN
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Visually select the text that was last edited/pasted (Vimcast#26).
noremap gV `[v`]
nnoremap <M-h> <C-w>h
nnoremap <M-k> <C-w>k
nnoremap <M-j> <C-w>j
nnoremap <M-l> <C-w>l
nnoremap <leader>w <C-w>w 

nnoremap <silent><TAB> :bnext<CR>
nnoremap <silent><S-TAB> :bprevious<CR>
"
" nnoremap <silent> <TAB> :BufferNext<CR>
" nnoremap <silent> <S-TAB> :BufferPrevious<CR>
" Alternate way to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>
" Alternate way to quit
"nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
nnoremap <leader>bd :bd%<CR>

nmap gx :!open <c-r><c-a> 
nmap ,p "0p
nmap ,P "0P
nnoremap <silent><leader>r :source ~/.config/nvim/init.vim<CR>

nnoremap <leader>cd :lcd %:p:h

nnoremap <leader>Q :q<CR>
" Prevent common mistake of pressing q: instead :q
noremap q; :q
" Better tabbing
vnoremap < <gv
vnoremap > >gv
" paste last thing yanked
vnoremap <leader>p "_dP
nnoremap <C-d> 6j
nnoremap <C-u> 6k
" copy entire file
nnoremap <leader>Y gg"+yG
nnoremap <silent><esc> :noh<return><esc>
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim
nnoremap <leader>+ :vertical resize +15<CR>
nnoremap <leader>- :vertical resize -15<CR>
nnoremap <leader>ca :w <bar> %bd <bar> e# <bar> bd# <CR>
nnoremap <silent><leader>CC :call CleanNoNameEmptyBuffers()<CR>
" Replace word under cursor in file (case-sensitive)
nmap <leader>sr *:%s///gI<left><left><left>
" Replace word under cursor in line (case-sensitive)
nmap <leader>sl *:s///gI<left><left><left>

nnoremap ,fn :put =expand('%:t')<CR>
" tnoremap <Esc> <C-\><C-n>


"---------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------

nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" quickfix mapping, nextfile jumps
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

nnoremap <leader>mm :lua require('material.functions').toggle_style()<CR>
" ----------------------------------------------------------------------------
" Change ref pubspeC
" ----------------------------------------------------------------------------
"
nnoremap <leader>cbr :cfdo %s@ref: @ref: @gc
nnoremap <leader>cbv :cfdo %s@version: @version: @gc

" ----------------------------------------------------------------------------
" Git
" ----------------------------------------------------------------------------

nnoremap <leader>gc :GBranches<CR>
nnoremap <leader>gs :G<CR>
nnoremap <leader>ge :Ge:<CR>
nnoremap <leader>gb :G blame<CR>
nnoremap <leader>gm :G mergetool<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gh :diffget //2<CR>

"nnoremap <leader>rq :lua require('rest-nvim').run()<CR>
"nnoremap <F5> :lua require'dap'.continue()<CR>
"nnoremap <F10> :lua require'dap'.step_over()<CR>
"nnoremap <leader>b :lua require'dap'.toggle_breakpoint()<CR>


" ----------------------------------------------------------------------------
" Testing
" ----------------------------------------------------------------------------
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tg :TestVisit<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ts :TestSuite<CR>

" ----------------------------------------------------------------------------
" Harpoon
" ----------------------------------------------------------------------------
nnoremap <M-a> :lua require("harpoon.mark").add_file()<CR>
nnoremap <M-m> :lua require("harpoon.ui").toggle_quick_menu()<CR>

" ----------------------------------------------------------------------------
" Ftern
" ----------------------------------------------------------------------------
"
nnoremap <C-e> :lua require("FTerm").toggle()<CR>
nnoremap <C-q> :lua require("FTerm").close()<CR>


