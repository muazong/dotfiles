return {
  "andrewferrier/debugprint.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    keymaps = {
      normal = {
        plain_below = "<leader>p",
      },
      visual = {
        variable_below = "<leader>p",
      },
    },
    commands = {
      toggle_comment_debug_prints = "ToggleCommentDebugPrints",
      delete_debug_prints = "DeleteDebugPrints",
      reset_debug_prints_counter = "ResetDebugPrintsCounter",
    },
  },
}
