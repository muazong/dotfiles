return {
  "folke/noice.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        enabled = true,
        silent = true,
        view = nil,
        opts = {},
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "Error executing lua",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "Invalid 'end_row'",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "Invalid 'end_col'",
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "msg_show",
          kind = "emsg",
        },
        opts = { skip = true },
      },
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
      {
        filter = {
          event = "msg_show",
          kind = "lua_print",
          find = "^nil$",
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
}
