local o, opt, fn, g = vim.o, vim.opt, vim.fn, vim.g

local indent = 2

vim.cmd([[
	filetype plugin indent on

  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 2
  let g:netrw_altv = 0
  let g:netrw_winsize = 15
  let g:netrw_banner=0
  let g:term_buf = 0
  let g:NetrwIsOpen=0

  let g:fugitive_summary_format = "%s <%an> - %ar"

  "projects
  let g:nvim_tree_update_cwd = 1
  let g:nvim_tree_respect_buf_cwd = 1

  " markdown
  let g:mkdp_auto_close = 0

  " vim-test
  let test#strategy = 'neovim'
  let test#neovim#term_position = "vert botright 70"
  let test#javascript#jest#options = "--color=always"

  let g:ultest_use_pty = 1
  let g:ultest_pass_sign = "👌"
  let g:ultest_fail_sign = "💩"
  let g:ultest_running_sign = '🚀'
  let g:ultest_deprecation_notice = 0

  let g:asyncrun_open = 8
]])

g.mapleader = " "

opt.cmdheight = 0
opt.backspace = { "eol", "start", "indent" }
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.undodir = "~/.vim/undodir"
opt.undofile = true
opt.pumheight = 15

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

-----------------------------------------------------------------------------//
-- Cursor {{{1
-----------------------------------------------------------------------------//
-- This is from the help docs, it enables mode shapes, "Cursor" highlight, and blinking
opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}
opt.cursorline = false
opt.laststatus = 3
opt.lazyredraw = true
opt.list = true

opt.mouse = "a"
opt.number = true
opt.rnu = true
opt.scrolloff = 18
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = "yes"
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.wrap = false

opt.backup = false
opt.swapfile = false
opt.writebackup = false

opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess = opt.shortmess + { c = true }

opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100

opt.termguicolors = true

o.conceallevel = 0
