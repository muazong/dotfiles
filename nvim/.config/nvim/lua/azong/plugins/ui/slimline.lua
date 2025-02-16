return {
  "sschleemilch/slimline.nvim",
  event = "VimEnter",
  config = function()
    require("slimline").setup({
      bold = true,
      verbose_mode = false,
      style = "fg", -- or "bg"
      mode_follow_style = true,
      workspace_diagnostics = true,
      components = {
        left = {
          "mode",
          "git",
        },
        center = {
          "path",
        },
        right = {
          "diagnostics",
          -- "filetype_lsp",
          "progress",
        },
      },
      spaces = {
        components = "",
        left = "",
        right = "",
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
        modes = {
          normal = "Type", -- highlight base of modes
          insert = "Function",
          pending = "Boolean",
          visual = "Keyword",
          command = "String",
        },
        base = "Comment", -- highlight of everything in in between components
        primary = "Normal", -- highlight of primary parts (e.g. filename)
        secondary = "Comment", -- highlight of secondary parts (e.g. filepath)
      },
      icons = {
        diagnostics = {
          ERROR = " ",
          WARN = " ",
          HINT = " ",
          INFO = " ",
        },
        git = {
          branch = "",
        },
        folder = " ",
        lines = " ",
        recording = " ",
        buffer = {
          modified = "",
          read_only = "",
        },
      },
    })
  end,
}
