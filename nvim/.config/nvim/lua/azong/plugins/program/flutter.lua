return {
  { -- Tools
    "nvim-flutter/flutter-tools.nvim",
    enabled = false,
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = true,
  },
  { -- Hot reload
    "reisub0/hot-reload.vim",
    enabled = false,
    ft = { "dart" },
  },
}
