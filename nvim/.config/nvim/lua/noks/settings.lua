local o, opt, fn, g = vim.o, vim.opt, vim.fn, vim.g

local indent = 2

vim.cmd([[
 filetype plugin indent on
  " vim-test
  let test#strategy = 'neovim'
  let test#neovim#term_position = "vert botright 70"
  let test#javascript#jest#options = "--color=always"
]])

g.mapleader = " "
g.fugitive_summary_format = "%s <%an> - %ar"

g.nvim_tree_update_cwd = 1
g.nvim_tree_respect_buf_cwd = 1
g.mkdp_auto_close = 0
g.asyncrun_open = 8

g.netrw_liststyle = 3
g.netrw_browse_split = 2
g.netrw_altv = 0
g.netrw_winsize = 15
g.netrw_banner = 0
g.term_buf = 0
g.NetrwIsOpen = 0

opt.cmdheight = 0
opt.backspace = { "eol", "start", "indent" }
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.undodir = "~/.vim/undodir"
opt.undofile = true
opt.pumheight = 15
opt.listchars = { eol = " ", tab = "▸ ", trail = "·" }

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
opt.wildmenu = true

opt.guicursor = {
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
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
