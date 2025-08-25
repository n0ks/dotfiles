--
return {
  {
    "akinsho/flutter-tools.nvim",
    config = function()
      require("flutter-tools").setup({
        closing_tags = {
          enabled = false,
        },
        fvm = true,
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            -- require("dap").configurations.dart = {}
            require("dap.ext.vscode").load_launchjs()
          end,
        },
        dev_log = {
          enabled = false,
          open_cmd = "tabedit",
          notify_errors = false,
          filter = function(log)
            if string.find(log, "flutter") then
              return log
            end
            return nil
          end,
        },
        dev_tools = {
          autostart = true,
        },
        lsp = {
          settings = {
            showTodos = false,
            renameFilesWithClasses = "always",
            documentation = "full",
            lineLength = 120,
          },
          color = {
            enabled = true,
          },
          on_attach = function(_, bufnr)
            local map = require("noks.configs.utils").map

            vim.o.textwidth = 120

            vim.lsp.handlers["textDocument/publishDiagnostics"] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = false,
                  underline = true,
                  inlayHint = false,
                })

            map("n", "<F1>", ":FlutterRun<CR>")
            map("n", "<F2>", ":FlutterReload<CR>")
            map("n", "<F3>", ":FlutterRestart<CR>")
            map("n", "<F4>", ":lua require('telescope').extensions.flutter.commands()<CR>")

            vim.cmd([[
              command! BuildRunner AsyncRun -mode=term -focus=0 -rows=12 dart run build_runner build --delete-conflicting-outputs
              command! L10n AsyncRun -mode=term -focus=0 -rows=12 flutter gen-l10n
              command! DartFix AsyncRun -cwd=$(VIM_FILEDIR) dart fix --apply
              command! Golden AsyncRun -cwd=$(VIM_CWD) flutter test --update-goldens
              command! ToFreezed AsyncRun! -cwd=$(VIM_FILEDIR) quicktype "$(VIM_FILEPATH)" -l dart --no-enums --use-freezed -o "$(VIM_FILEPATH)"
          ]])
          end,
        },
      })
    end,
  },
}
