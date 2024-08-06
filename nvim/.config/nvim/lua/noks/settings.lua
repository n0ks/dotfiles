local o, opt, fn, g = vim.o, vim.opt, vim.fn, vim.g
local indent = 2

vim.cmd([[
 filetype plugin indent on
  " vim-test
  let test#strategy = 'neovim'
  let test#neovim#term_position = "vert botright 70"
  let test#javascript#jest#options = "--color=always"
  set t_Co=256
]])

opt.termguicolors = true

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

opt.cmdheight = 1

opt.backspace = { "eol", "start", "indent" }
opt.clipboard = "unnamedplus"
opt.encoding = "utf-8"
opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
opt.syntax = "enable"
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
opt.fillchars = {
	eob = " ", -- suppress ~ at EndOfBuffer
	diff = "╱", -- alternatives = ⣿ ░ ─
	msgsep = " ", -- alternatives: ‾ ─
	fold = " ",
	foldopen = "▽", -- '▼'
	foldclose = "▷", -- '▶'
	foldsep = " ",
}
-- opt.undofile = true
opt.pumheight = 15
opt.listchars = { eol = nil, tab = "▸ ", trail = "·" }
opt.background = "dark"

opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

opt.hlsearch = true
opt.incsearch = true
opt.cursorline = true
opt.inccommand = "nosplit"
opt.ignorecase = true
opt.smartcase = true
vim.opt.wildignore = {
	"*.o",
	"*.obj,*~",
	"*.git*",
	"*.meteor*",
	"*vim/backups*",
	"*sass-cache*",
	"*mypy_cache*",
	"*__pycache__*",
	"*cache*",
	"*logs*",
	"*node_modules*",
	"**/node_modules/**",
	"*DS_Store*",
	"*.gem",
	"log/**",
	"tmp/**",
}
opt.wildmenu = true

opt.guicursor = {
	[[n-v-c:block]],
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
opt.wrap = true

opt.backup = false
opt.swapfile = false
opt.writebackup = false
-- opt.regexpengine = 1
opt.completeopt = { "menu", "menuone", "noselect" }

opt.foldmethod = "manual"

opt.shortmess = {
	t = true, -- truncate file messages at start
	A = true, -- ignore annoying swap file messages
	o = true, -- file-read message overwrites previous
	O = true, -- file-read message overwrites previous
	T = true, -- truncate non-file messages in middle
	f = true, -- (file x of x) instead of just (x of x
	F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
	s = true,
	c = true,
	W = true, -- Don't show [w] or written when writing
}

opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↳"
opt.laststatus = 3

o.conceallevel = 0
