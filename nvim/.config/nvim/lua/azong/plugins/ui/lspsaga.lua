return {
  "nvimdev/lspsaga.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    lightbulb = {
      enable = true,
      sign = true,
      virtual_text = false,
    },
    symbol_in_winbar = {
      enable = true,
    },
    outline = {
      layout = "normal",
    },
    code_action = {
      show_server_name = true,
      extend_gitsigns = false,
      num_shortcut = true,
      keys = {
        quit = { "<C-c>", "q" },
        exec = "<CR>",
      },
    },
    scroll_preview = { scroll_down = "<C-d>", scroll_up = "<C-u>" },
    definition = {
      edit = "<CR>",
    },
    ui = {
      colors = {
        normal_bg = "#022746",
      },
    },
  },
}
