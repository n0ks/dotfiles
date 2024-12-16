return {
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapVirtualTextToggle", "DapContinue", "DapDisconnect" },
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dap-go").setup()

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
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      })

      vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
      vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
      vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

      vim.fn.sign_define(
        "DapBreakpoint",
        { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
      )

      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "•", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      vim.fn.sign_define(
        "DapLogPoint",
        { text = "•", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
      )

      dap.defaults.fallback.exception_breakpoints = { "raised" }
      -- dap.defaults.fallback.force_external_terminal = true
      -- dap.defaults.fallback.external_terminal = {
      -- 	command = "/usr/local/bin/alacritty",
      -- 	args = { "-e" },
      -- }

      dap.set_log_level("TRACE")

      vim.cmd([[au FileType dap-repl lua require('dap.ext.autocompl').attach()]])
    end,
  },
}
