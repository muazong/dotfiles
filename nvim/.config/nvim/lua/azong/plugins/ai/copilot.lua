return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = true },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
