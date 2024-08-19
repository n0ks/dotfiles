local capabilities = require("noks.lsp.handlers").capabilities
local on_attach = require("noks.lsp.handlers").on_attach
local map = require("noks.configs.utils").map
local util = require("lspconfig/util")

local M = {}

M.setup = function()
  require("go").setup({
    go = "go",                     -- go command, can be go[default] or e.g. go1.18beta1
    goimports = "goimports_reviser", -- goimports command, can be gopls[default] or either goimports or golines if need to split long lines
    gofmt = "gofumpt",             -- gofmt through gopls: alternative is gofumpt, goimports, golines, gofmt, etc
    fillstruct = "gopls",          -- set to fillstruct if gopls fails to fill struct
    max_line_len = 0,              -- max line length in golines format, Target maximum line length for golinesgo
    lsp_cfg = true,                -- true: use non-default gopls setup specified in go/lsp.lua
    -- false: do nothing
    -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
    --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    -- false: do not set default gofmt in gopls format to gofumpt
    lsp_on_attach = nil, -- nil: use on_attach function defined in go/lsp.lua,
    --      when lsp_cfg is true
    -- if lsp_on_attach is a function: use this function as on_attach function for gopls
    lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
    diagnostic = { -- set diagnostic to false to disable vim.diagnostic.config setup,
      -- true: default nvim setup
      hdlr = false, -- hook lsp diag handler and send diag to quickfix
      underline = false,
      virtual_text = { spacing = 2, prefix = "" }, -- virtual text setup
      signs = { "", "", "", "" }, -- set to true to use default signs, an array of 4 to specify custom signs
      update_in_insert = false,
    },
    lsp_document_formatting = true,
    lsp_inlay_hints = {
      enable = true,
      style = "inlay",
      -- Note: following setup only works for style = 'eol', you do not need to set it for 'inlay'
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",
      -- whether to show variable name before type hints with the inlay hints or not
      -- default: false
      show_variable_name = true,
      -- prefix for parameter hints
      parameter_hints_prefix = "󰊕 ",
      show_parameter_hints = true,
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 6,
      -- The color of the hints
      highlight = "Comment",
    },
    gopls_cmd = nil,        -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
    gopls_remote_auto = true, -- add -remote=auto to gopls
    gocoverage_sign = "█",
    sign_priority = 5,      -- change to a higher number to override other signs
    dap_debug = false,      -- set to false to disable dap
    dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
    -- false: do not use keymap in go/dap.lua.  you must define your own.
    -- Windows: Use Visual Studio keymap
    dap_debug_vt = { enabled_commands = true, all_frames = true }, -- bool|table put your dap-virtual-text setup here set to false to disable

    dap_port = 38697,                                            -- can be set to a number, if set to -1 go.nvim will pick up a random port
    dap_timeout = 15,                                            --  see dap option initialize_timeout_sec = 15,
    dap_retries = 20,                                            -- see dap option max_retries
    build_tags = "tag1,tag2",                                    -- set default build tags
    textobjects = true,                                          -- enable default text objects through treesittter-text-objects
    test_runner = "go",                                          -- one of {`go`,  `dlv`, `ginkgo`, `gotestsum`}
    verbose_tests = true,                                        -- set to add verbose flag to tests deprecated, see '-v' option
  })
end

function on_attatch_go(c, b)
  on_attach(c, b)
  map("n", "<leader>ir", ":GoIfErr<CR>")
end

M.settings = {
  on_attach = on_attatch_go,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      templateExtensions = {
        "html",
        "tmpl",
      },
      completeUnimported = true,
      usePlaceholders = true,
      gofumpt = true,
      linksInHover = false,
      analyses = {
        unusedparams = true,
      },
      codelenses = {
        generate = true,
        gc_details = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_depdendency = true,
        vendor = true,
      },
    },
  },
}

return M
