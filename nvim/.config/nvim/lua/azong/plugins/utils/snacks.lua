return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = { { "<leader>su", "<cmd>lua Snacks.picker.undo()<cr>" } },
  opts = {
    scroll = { enabled = false },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = "<CMD>Telescope find_files<CR>" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = "<CMD>Telescope live_grep<CR>" },
          { icon = " ", key = "b", desc = "Explorer", action = "<CMD>Telescope file_browser<CR>" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
 █████╗ ███████╗ ██████╗ ███╗   ██╗ ██████╗
██╔══██╗╚══███╔╝██╔═══██╗████╗  ██║██╔════╝
███████║  ███╔╝ ██║   ██║██╔██╗ ██║██║  ███╗
██╔══██║ ███╔╝  ██║   ██║██║╚██╗██║██║   ██║
██║  ██║███████╗╚██████╔╝██║ ╚████║╚██████╔╝
╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝
 ]],
      },
    },
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
