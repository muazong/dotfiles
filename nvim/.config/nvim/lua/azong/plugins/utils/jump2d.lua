return {
  "nvim-mini/mini.jump2d",
  version = "*",
  opts = {
    spotter = nil,
    labels = "abcdefghijklmnopqrstuvwxyz",
    view = {
      dim = false,
      n_steps_ahead = 0,
    },
    allowed_lines = {
      blank = true,
      cursor_before = true,
      cursor_at = true,
      cursor_after = true,
      fold = true,
    },
    allowed_windows = {
      current = true,
      not_current = true,
    },
    hooks = {
      before_start = nil,
      after_jump = nil,
    },
    mappings = {
      start_jumping = "<leader>ff",
    },
    silent = false,
  },
}
