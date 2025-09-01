vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = false,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
      inlayHints = {
        callArgumentNames = true,
        callArgumentNamesMatching = true,
        functionReturnTypes = true,
        genericTypes = true,
        variableTypes = true,
      },
    },
  },
})
