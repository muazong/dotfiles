return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  dependencies = { { "tris203/rzls.nvim", config = true } },
  config = true,
  init = function()
    vim.filetype.add({
      extension = {
        razor = "razor",
        cshtml = "razor",
      },
    })
  end,
}
