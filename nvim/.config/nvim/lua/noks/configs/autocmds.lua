local fn = vim.fn
local api = vim.api

local on_buf_load = { "BufNewFile", "BufRead" }

-- ╭───────────────────────╮
-- │ Autocmd Groups        │
-- ╰───────────────────────╯
local qflist_group = api.nvim_create_augroup("QFlist", { clear = true })
local highlight_yank_group = api.nvim_create_augroup("highlight_yank", { clear = true })
local read_file_on_change_group = api.nvim_create_augroup("read_file_on_change", { clear = true })
local lsp_node = api.nvim_create_augroup("LspNodeModules", { clear = true })

-- ╭──────────────────────────────╮
-- │ Set filetype or options     │
-- ╰──────────────────────────────╯

-- Auto-reload files when changed outside vim (wrapped in pcall)
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= 'c' then
      pcall(vim.cmd.checktime)
    end
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo", "fugitive", "null-ls-info" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "Fastfile", "Podfile" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.arb",
  callback = function()
    vim.bo.filetype = "json"
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.tmpl",
  callback = function()
    vim.bo.filetype = "html"
  end,
})

api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

api.nvim_create_autocmd("BufRead", {
  pattern = "*.yaml",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*/node_modules/*",
  group = lsp_node,
  callback = function()
    vim.diagnostic.disable(0)
  end,
})

-- ╭──────────────────────────────╮
-- │ Highlight on yank           │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = highlight_yank_group,
  callback = function()
    vim.highlight.on_yank({
      timeout = 40,
      on_visual = true,
      higroup = "IncSearch",
    })
  end,
})

-- ╭──────────────────────────────╮
-- │ Restore cursor position     │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
      vim.cmd("normal! zz")
    end
  end,
})

-- ╭──────────────────────────────╮
-- │ Disable completion in tree  │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufEnter", {
  pattern = "*NvimTree*",
  callback = function()
    vim.b.completion = false
  end,
})

-- ╭──────────────────────────────╮
-- │ Format go files             │
-- ╰──────────────────────────────╯
api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- Safely call go format, suppress errors if plugin not loaded
    local ok, go_format = pcall(require, "go.format")
    if ok and go_format and go_format.gofmt then
      pcall(go_format.gofmt)
    end
  end,
})
