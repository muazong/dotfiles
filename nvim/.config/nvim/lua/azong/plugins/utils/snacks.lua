return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>su", "<cmd>lua Snacks.picker.undo()<cr>", desc = "Snacks Undo" },
    { "<leader>si", "<cmd>lua Snacks.picker.icons()<cr>", desc = "Snacks Icons" },
  },
  opts = {
    scroll = { enabled = false },

    picker = {
      enabled = true,
      prompt = " ",
      sources = {
        files = {
          args = {
            "--type",
            "f",
            "--no-ignore",
            "--exclude",
            ".*",
            "--exclude",
            "node_modules/",
            "--exclude",
            "obj/",
            "--exclude",
            "bin/",
            "--exclude",
            "android/",
            "--exclude",
            "ios/",
            "--exclude",
            "macos/",
            "--exclude",
            "windows/",
            "--exclude",
            "web/",
            "--exclude",
            "venv/",
            "--exclude",
            "Migrations/",
            "--exclude",
            "dist/",
            "--exclude",
            "__pycache__/",
            "--exclude",
            "build/",
            "--exclude",
            "%__virtual.cs$",
          },
        },
        grep = {
          args = {
            "--no-ignore",
            "--glob",
            "!.*/**",
            "--glob",
            "!node_modules/**",
            "--glob",
            "!obj/**",
            "--glob",
            "!bin/**",
            "--glob",
            "!android/**",
            "--glob",
            "!ios/**",
            "--glob",
            "!macos/**",
            "--glob",
            "!windows/**",
            "--glob",
            "!web/**",
            "--glob",
            "!venv/**",
            "--glob",
            "!Migrations/**",
            "--glob",
            "!dist/**",
            "--glob",
            "!__pycache__/**",
            "--glob",
            "!build/**",
          },
        },
      },
    },

    styles = {
      notification = {
        wo = { wrap = true },
      },
    },

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
          { icon = " ", key = "L", desc = "LeetCode", action = ":Leet" },
          { icon = " ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
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
    indent = { enabled = true },
    bigfile = { enabled = true },
    explorer = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
}
