return {

  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    build = "make install_jsregexp",
    version = "2.2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      history = true,
      -- A comma-separated string with a space becomes the event " TextChangedI",
      -- which never fires, so snippet nodes stop updating while typing.
      updateevents = { "TextChanged", "TextChangedI" },
      enable_autosnippets = true,
    },
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      require("luasnip").filetype_extend("dart", { "flutter", "flutter_bloc" })
    end,
  },
}
