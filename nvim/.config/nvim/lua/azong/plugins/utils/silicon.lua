return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  main = "nvim-silicon",
  config = function()
    require("nvim-silicon").setup({
      command = "silicon",
      disable_defaults = false,
      debug = false,
      font = "JetBrainsMono Nerd Font=34; Noto Emoji=34",
      theme = "OneHalfDark",
      background = "#7E9CD8",
      background_image = nil,
      pad_horiz = 100,
      pad_vert = 80,
      no_round_corner = false,
      no_window_controls = false,
      no_line_number = false,
      line_offset = function(args)
        return args.line1
      end,
      line_pad = 0,
      tab_width = 2,
      language = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":e")
      end,
      shadow_blur_radius = 16,
      shadow_offset_x = 8,
      shadow_offset_y = 8,
      shadow_color = nil,
      gobble = true,
      to_clipboard = true, -- BUG: may produce an error if run on WSL2
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
      wslclipboard = nil, -- never | always | auto
      wslclipboardcopy = nil, -- keep | delete
      output = function()
        return "./" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
      end,
    })
  end,
}
