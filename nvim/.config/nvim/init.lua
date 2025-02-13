require("noks.settings")
require("noks.globals")
require("noks.configs.keymaps")
require("noks.configs.autocmds")

vim.cmd("source" .. "~/.config/nvim/general/funfun.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local opts = {
  performance = {
    -- defaults = { lazy = true },
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tar",
        "tutor",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHanlers",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
      },
    },
  },
}

require("lazy").setup({
  spec = {
    { import = "noks.plugins" },
  },
}, opts)
