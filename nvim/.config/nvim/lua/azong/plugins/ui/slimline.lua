return {
  "sschleemilch/slimline.nvim",
  event = "VimEnter",
  config = function()
    require("slimline").setup({
      bold = true,
      style = "fg", -- or "bg"

      components = {
        left = {
          "mode",
          "git",
        },
        center = {
          "path",
        },
        right = {
          -- Show keyboard input
          function()
            local keyboard = require("azong.utils.keyboard")
            local h = require("slimline.highlights")
            local c = require("slimline").config

            return h.hl_component({ primary = " " .. keyboard.layout }, h.hls.components["path"], c.sep)
          end,
          "diagnostics",
          -- "filetype_lsp",
          "progress",
        },
      },

      configs = {
        mode = {
          verbose = false,
          hl = {
            normal = "Type",
            insert = "Function",
            pending = "Boolean",
            visual = "Keyword",
            command = "String",
          },
        },
        git = {
          hl = {
            primary = "Function",
          },
          icons = {
            branch = "",
            added = "+",
            modified = "~",
            removed = "-",
          },
        },
        path = {
          directory = true,
          icons = {
            folder = " ",
            modified = "",
            read_only = "",
          },
        },
        diagnostics = {
          workspace = true,
          icons = {
            ERROR = " ",
            WARN = " ",
            HINT = "󱩎 ",
            INFO = " ",
          },
        },
        progress = {
          follow = "mode",
          icon = " ",
        },
      },

      spaces = {
        components = "─",
        left = "─",
        right = "─",
      },
      sep = {
        hide = {
          first = true,
          last = true,
        },
        left = "",
        right = "",
      },
      hl = {
        base = "Comment",
        primary = "Normal",
        secondary = "Comment",
      },
    })
  end,
}
