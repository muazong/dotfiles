return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = { { "<leader>su", "<cmd>lua Snacks.picker.undo()<cr>" } },
  opts = {
    scroll = { enabled = false },
    dashboard = { enabled = false },

    scope = { enabled = true },
    words = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    indent = { enabled = true },
    bigfile = { enabled = true },
    explorer = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
}
