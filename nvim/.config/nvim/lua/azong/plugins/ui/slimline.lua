return {
  "sschleemilch/slimline.nvim",
  event = "BufReadPre",
  config = function()
    vim.opt.laststatus = 4
    require("slimline").setup({
      bold = true,
      style = "fg", -- or "bg"

      components = {
        left = {
          "mode",
          "git",
          "searchcount",
          "selectioncount",
          function()
            local wrap = require("azong.utils.wrap")
            local h = require("slimline.highlights")
            local c = require("slimline").config

            local status = vim.g.supermaven_is_running and "󰚩 ON" or "󰜺 OFF"

            return h.hl_component(
              { secondary = " " .. wrap.state, primary = "Supermaven " .. status },
              h.hls.components["path"],
              c.sep
            )
          end,
        },
        center = { "path" },
        right = { "filetype_lsp", "diagnostics", "progress" },
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
