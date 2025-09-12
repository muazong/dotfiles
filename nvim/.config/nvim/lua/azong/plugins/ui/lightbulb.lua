return {
  "kosayoda/nvim-lightbulb",
  event = "LspAttach",
  config = function()
    require("nvim-lightbulb").setup({
      autocmd = {
        enabled = true,
        updatetime = 50,
      },
      float = {
        enabled = true,
        text = "💡",
        lens_text = "🔎",
        hl = "LightBulbFloatWin",
        win_opts = {
          focusable = false,
        },
      },
    })
  end,
}
