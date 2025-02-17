return {
  "anuvyklack/windows.nvim",
  dependencies = "anuvyklack/middleclass",
  keys = {
    { "<leader>ss", "<cmd>split<cr>" },
    { "<leader>sv", "<cmd>vsplit<cr>" },
  },
  config = function()
    require("windows").setup()
  end,
}
