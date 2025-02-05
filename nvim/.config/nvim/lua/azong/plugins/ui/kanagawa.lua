return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      functionStyle = { italic = false, bold = true },
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
            float = {
              bg = "none",
            },
            syn = {
              parameter = "#BDE8CA",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          NormalFloat = { bg = "#2A2A37" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },
          NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
          MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          String = { italic = true, fg = "#C3FF99" },
          Function = { italic = true, bold = true, fg = "#A594F9" },
          Type = { italic = true, fg = "#C4E4FF", bold = true },
          Number = { fg = "#FEF9D9" },
          Keyword = { fg = "#FDAF75" },
          Statement = { fg = "#8967B3" },
          Operator = { fg = "#E85C0D" },
          Special = { fg = "#A0DEFF" },

          SomePluginHl = { fg = colors.theme.syn.type, bold = true },

          -- Telescope theme
          TelescopeTitle = { fg = theme.ui.bg_p1, bold = true, bg = "#FF5D62" },
          TelescopeResultsTitle = { fg = theme.ui.bg_p1, bold = true, bg = "#FF9E3B" },
          TelescopePreviewTitle = { fg = theme.ui.bg_p1, bold = true, bg = "#98BB6C" },

          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          TelescopeResultsDiffAdd = { fg = "#98BB6C" },
          TelescopeResultsDiffChange = { fg = "#E6C384" },
          TelescopeResultsDiffDelete = { fg = "#FF5D62" },

          TelescopeMatching = { fg = "#FF9E3B" },
          TelescopePromptPrefix = { fg = "#E46876" },
        }
      end,
    })

    vim.cmd("colorscheme kanagawa-wave")
  end,
}

