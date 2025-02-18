return {
  "epwalsh/pomo.nvim",
  version = "*",
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  dependencies = { "rcarriga/nvim-notify" },
  opts = {
    notifier = { sticky = true },
    sessions = {
      pomodoro = {
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "30m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "30m" },
        { name = "Long Break", duration = "10m" },
      },
    },
  },
}
