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
      local ts = require("nvim-treesitter")
      ts.setup({})

      -- Parsers live in `stdpath("data")/site` (nvim-treesitter's default
      -- install_dir), not in the plugin clone, which is wiped on every update.
      -- Installing unconditionally on every startup fired a download each
      -- time, so only ever install what is actually missing, and only on
      -- demand -- `install()` has hung in this environment before.
      local function missing_parsers()
        local installed = ts.get_installed("parsers")
        return vim.tbl_filter(function(lang)
          return not vim.tbl_contains(installed, lang)
        end, parsers)
      end

      vim.api.nvim_create_user_command("TSInstallMissing", function()
        local missing = missing_parsers()
        if #missing == 0 then
          vim.notify("nvim-treesitter: nothing missing", vim.log.levels.INFO)
          return
        end
        ts.install(missing)
      end, { desc = "Install the configured parsers that are not present yet" })

      vim.schedule(function()
        local missing = missing_parsers()
        if #missing > 0 then
          vim.notify(
            ("nvim-treesitter: missing %s -- run :TSInstallMissing"):format(table.concat(missing, ", ")),
            vim.log.levels.WARN
          )
        end
      end)

      -- go.nvim names the go-template filetypes gotexttmpl/gohtmltmpl; the
      -- parser is called gotmpl.
      vim.treesitter.language.register("gotmpl", { "gotexttmpl", "gohtmltmpl" })

      -- On the `main` branch highlight/indent are no longer config options;
      -- they are started per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("noks_treesitter", { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang or not vim.treesitter.language.add(lang) then
            return
          end
          -- vim.treesitter.start() clears 'syntax'. Starting it for a language
          -- whose highlights query is missing therefore leaves the buffer with
          -- no highlighting at all, rather than falling back to syntax.
          local has_query = pcall(vim.treesitter.query.get, lang, "highlights")
            and vim.treesitter.query.get(lang, "highlights") ~= nil
          if not has_query then
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
      -- `am`/`im` rather than `af`/`if`: those are mini.ai's function-call textobject.
      { "am", select_textobject("@function.outer"), mode = { "x", "o" }, desc = "a method" },
      { "im", select_textobject("@function.inner"), mode = { "x", "o" }, desc = "inner method" },
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
