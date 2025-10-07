return {
  "folke/flash.nvim",
  opts = {},
  keys = {
    {
      "<leader>ff",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
