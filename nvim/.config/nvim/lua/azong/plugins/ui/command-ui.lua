return {
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    opts = {
      always_check = false,
      timeout = 1000,
      fps = 144,
      render = "wrapped-compact",
      stages = "fade_in_slide_out",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.35)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      fps = 60,
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "completion request failed",
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = "notify",
            find = "unsupported value.",
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          position = {
            row = "20%",
            col = "50%",
          },
          size = {
            min_width = 50,
          },
        },
        popupmenu = {
          position = {
            row = "45%",
            col = "50%",
          },
          size = {
            width = "60%",
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
        },
      },
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          filter = { pattern = "^:%s*!", icon = "", lang = "bash" },
        },
      },
    },
  },
}
