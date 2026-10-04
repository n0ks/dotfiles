local inlay_hints = {
  includeInlayParameterNameHints = "literal",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

return {
  settings = {
    typescript = {
      inlayHints = inlay_hints,
      preferences = { importModuleSpecifier = "non-relative" },
      updateImportsOnFileMove = { enabled = "always" },
    },
    javascript = {
      inlayHints = inlay_hints,
      updateImportsOnFileMove = { enabled = "always" },
    },
  },
}
