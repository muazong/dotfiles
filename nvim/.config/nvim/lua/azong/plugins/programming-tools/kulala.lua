return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<leader>rr", '<cmd>lua require("kulala").run()<cr>', desc = "Kulala run" },
    { "<leader>ra", '<cmd>lua require("kulala").run_all()<cr>', desc = "Kulala run all" },
    { "<leader>rl", '<cmd>lua require("kulala").replay()<cr>', desc = "Kulala replay" },
  },
  opts = {
    ui = {
      display_mode = "split", -- float
      split_direction = "vertical", -- vertical
      default_view = "headers_body",
      default_winbar_panes = { "headers_body", "headers", "body", "verbose" },
    },
    kulala_keymaps = {
      ["Show all"] = {
        "1",
        function()
          require("kulala.ui").show_headers_body()
        end,
      },
      ["Show headers"] = {
        "2",
        function()
          require("kulala.ui").show_headers()
        end,
      },
      ["Show body"] = {
        "3",
        function()
          require("kulala.ui").show_body()
        end,
      },
      ["Show verbose"] = {
        "4",
        function()
          require("kulala.ui").show_verbose()
        end,
      },
    },
  },
}
