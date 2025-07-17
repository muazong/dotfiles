return {
  "rcarriga/nvim-notify",
  enabled = false,
  event = "VimEnter",
  opts = {
    timeout = 1000,
    fps = 60,
    render = "wrapped-compact",
    stages = "fade_in_slide_out",
    max_width = function()
      return math.floor(vim.o.columns * 0.5)
    end,
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

      local max_len = 0
      for _, line in ipairs(lines) do
        local trimmed_len = vim.fn.strdisplaywidth(vim.trim(line))
        max_len = math.max(max_len, trimmed_len)
      end

      if max_len > 0 then
        pcall(vim.api.nvim_win_set_width, win, max_len + 2)
      end
    end,
  },
}
