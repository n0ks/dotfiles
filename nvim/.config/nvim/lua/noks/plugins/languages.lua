return {

  {
    "olexsmir/gopher.nvim",
    ft = "go",
    enabled = false,
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    opts = {},
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = "goimports_reviser",                               -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
        gofmt = "gofumpt",                                             -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
        fillstruct = "gopls",                                          -- set to fillstruct if gopls fails to fill struct
        max_line_len = 0,                                              -- max line length in golines format, Target maximum line length for golinesgo
        lsp_cfg = true,                                                -- true: use non-default gopls setup specified in go/lsp.lua
        lsp_gofumpt = true,                                            -- true: set default gofmt in gopls format to gofumpt
        -- false: do not set default gofmt in gopls format to gofumpt
        lsp_on_attach = nil,                                           -- nil: use on_attach function defined in go/lsp.lua,
        lsp_keymaps = false,                                           -- set to false to disable gopls/lsp keymap
        lsp_document_formatting = true,
        dap_debug = false,                                             -- set to false to disable dap
        dap_debug_keymap = false,                                      -- true: use keymap for debugger defined in go/dap.lua
        dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable
        dap_port = 38697,                                              -- can be set to a number, if set to -1 go.nvim will pick up a random port
        dap_timeout = 15,                                              --  see dap option initialize_timeout_sec = 15,
        dap_retries = 20,                                              -- see dap option max_retries
        textobjects = true,                                            -- enable default text objects through treesittter-text-objects
        test_runner = "go",                                            -- one of {`go`,  `dlv`, `ginkgo`, `gotestsum`}
        verbose_tests = true,                                          -- set to add verbose flag to tests deprecated, see '-v' option
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.dbs = {
        { name = "snippetbox", url = "mysql://root@localhost/snippetbox" },
      }
    end,
  },
}
