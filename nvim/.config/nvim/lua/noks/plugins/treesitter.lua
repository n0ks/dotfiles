local parsers = {
  "bash",
  "css",
  "dart",
  "dockerfile",
  "go",
  "gomod",
  "gowork",
  "gotmpl",
  "html",
  "javascript",
  "tsx",
  "lua",
  "scss",
  "typescript",
  "json",
  "ruby",
  "vim",
  "vimdoc",
  "yaml",
  "markdown",
  "markdown_inline",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({})
      require("nvim-treesitter").install(parsers)

      -- On the `main` branch highlight/indent are no longer config options;
      -- they are started per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("noks_treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang or not vim.treesitter.language.add(lang) then
            return
          end
          if not pcall(vim.treesitter.start, args.buf, lang) then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
