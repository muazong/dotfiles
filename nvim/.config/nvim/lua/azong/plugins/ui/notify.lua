return {
  "rcarriga/nvim-notify",
  event = "VimEnter",
  opts = {
    timeout = 1000,
    fps = 60,
    render = "wrapped-compact",
    stages = "fade_in_slide_out",
    max_width = function()
      return math.floor(vim.o.columns * 0.35)
    end,
  },
}
