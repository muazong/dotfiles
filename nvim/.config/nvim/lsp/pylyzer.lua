vim.lsp.config("pylyzer", {
  settings = {
    python = {
      checkOnType = true,
      diagnostics = true,
      inlayHints = true,
      smartCompletion = true,
    },
  },
})
