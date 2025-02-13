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
  -- foldopen = "▽", -- '▼'
  -- foldclose = "▷", -- '▶'
  foldsep = " ",
}
-- opt.undofile = true
opt.pumheight = 15

opt.listchars = {
  eol = nil,
  tab = "│─",
  trail = "·",
}

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
opt.rnu = false
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
  F = false, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  s = true,
  c = true,
  W = true, -- Don't show [w] or written when writing
}

opt.redrawtime = 1500
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.breakindent = true
opt.breakindentopt = "shift:2"
opt.showbreak = "↳"
opt.laststatus = 3

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

o.conceallevel = 0

local fn = vim.fn

function _G.qftf(info)
  local items
  local ret = {}
  -- The name of item in list is based on the directory of quickfix window.
  -- Change the directory for quickfix window make the name of item shorter.
  -- It's a good opportunity to change current directory in quickfixtextfunc :)
  --
  -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
  -- local root = getRootByAlterBufnr(alterBufnr)
  -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
  --
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fnameFmt1, fnameFmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local validFmt = "%s │%5d:%-3d│%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if fname == "" then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fnameFmt1:format(fname)
        else
          fname = fnameFmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      str = validFmt:format(fname, lnum, col, qtype, e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
