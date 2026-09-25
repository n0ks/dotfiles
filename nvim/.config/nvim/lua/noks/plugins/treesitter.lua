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

-- Wrappers so the lazy `keys` specs below stay readable. They are only called
-- once the plugin is loaded, so requiring inside them is what triggers it.
local function select_textobject(query)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end
end

local function move(direction)
  return function()
    require("nvim-treesitter-textobjects.move")[direction]("@function.outer", "textobjects")
  end
end

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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      -- select
      { "af", select_textobject("@function.outer"), mode = { "x", "o" }, desc = "a function" },
      { "if", select_textobject("@function.inner"), mode = { "x", "o" }, desc = "inner function" },
      { "ac", select_textobject("@class.outer"), mode = { "x", "o" }, desc = "a class" },
      { "ic", select_textobject("@class.inner"), mode = { "x", "o" }, desc = "inner class" },
      -- move
      { "]]", move("goto_next_start"), mode = { "n", "x", "o" }, desc = "Next function start" },
      { "][", move("goto_next_end"), mode = { "n", "x", "o" }, desc = "Next function end" },
      { "[[", move("goto_previous_start"), mode = { "n", "x", "o" }, desc = "Previous function start" },
      { "[]", move("goto_previous_end"), mode = { "n", "x", "o" }, desc = "Previous function end" },
    },
    opts = {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    },
  },
}
