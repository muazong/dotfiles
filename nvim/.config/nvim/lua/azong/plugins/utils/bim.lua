return {
  "sontungexpt/bim.nvim",
  event = "InsertEnter",
  config = function()
    require("bim").setup()
  end,
}
