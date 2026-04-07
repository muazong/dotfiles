return {
  "josephburgess/nvumi",
  enabled = false,
  dependencies = { "folke/snacks.nvim" },
  keys = { { "<leader>on", "<cmd>Nvumi<cr>", desc = "Open Nvumi" } },
  opts = {
    virtual_text = "inline", -- or "inline"
    prefix = " 🚀 ", -- prefix shown before the output
    date_format = "iso", -- or: "uk", "us", "long"
    keys = {
      run = "<CR>", -- run/refresh calculations
      reset = "R", -- reset buffer
      yank = "<leader>y", -- yank output of current line
      yank_all = "<leader>Y", -- yank all outputs
    },
  },
}
