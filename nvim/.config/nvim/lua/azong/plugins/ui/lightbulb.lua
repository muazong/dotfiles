return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = {
        enabled = true,
        updatetime = 50,
      },
    })
  end,
}
