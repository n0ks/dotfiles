local inspect = require("noks.configs.inspect")
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dapui.setup({
  layout = {
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.30, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 0.25 },
    },
  },
  icons = { expanded = "▾", collapsed = "▸" },
})

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

dap.defaults.fallback.exception_breakpoints = { "raised" }

dap.set_log_level("TRACE")

vim.cmd([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]])

-- ╭──────────────────────────────────────────────────────────╮
-- │ Adapters                                                 │
-- ╰──────────────────────────────────────────────────────────╯
-- NODE / TYPESCRIPT
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
}

-- Chrome
dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
}

-- Go
dap.adapters.go = {
  type = "executable",
  command = "node",
  args = {
    vim.fn.stdpath("data") .. "/mason/packages/go-debug-adapter",
  },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Configurations                                           │
-- ╰──────────────────────────────────────────────────────────╯
dap.configurations.javascript = {
  {
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.configurations.javascript = { {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    url = "http://localhost:3000",
    -- port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.javascriptreact = {
  {
    type = "chrome",
    request = "attach",
    name = "Debug react",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    url = "http://localhost:3000",
    -- port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.typescriptreact = {
  {
    type = "chrome",
    request = "attach",
    name = "Debug react typescript",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    -- port = 9222,
    webRoot = "${workspaceFolder}",
  },
}

dap.configurations.go = {
  {
    type = "go",
    request = "attach",
    name = "Attach Debugger",
    cwd = vim.fn.getcwd(),
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    type = "go",
    name = "Debug",
    request = "launch",
    showLog = true,
    program = "${file}",
    console = "externalTerminal",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
  {
    name = "Test Current File",
    type = "go",
    request = "launch",
    showLog = true,
    mode = "test",
    program = ".",
    dlvToolPath = vim.fn.exepath("dlv"),
  },
}

