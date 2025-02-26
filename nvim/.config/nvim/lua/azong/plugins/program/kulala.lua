return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<leader>rr", '<cmd>lua require("kulala").run()<cr>' },
    { "<leader>ra", '<cmd>lua require("kulala").run_all()<cr>' },
    { "<leader>rl", '<cmd>lua require("kulala").replay()<cr>' },
  },
  opts = {},
}
