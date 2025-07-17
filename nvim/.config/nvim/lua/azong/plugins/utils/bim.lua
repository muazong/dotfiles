return {
  "sontungexpt/bim.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("bim").setup()
  end,
}
