return {
  "rafcamlet/tabline-framework.nvim",
  event = "VimEnter",
  config = function()
    require("tabline_framework").setup({
      render = function(tab)
        tab.add(" ")
        tab.make_tabs(function(info)
          if info.filename and info.modified then
            tab.add(" ")
            tab.add({ info.index, gui = "bold,italic" })
            tab.add({ " ", gui = "bold,italic" })

            tab.add({ info.filename, gui = "bold,italic" })

            tab.add({
              " " .. tab.icon(info.filename),
              fg = tab.icon_color(info.filename),
            })

            tab.add({ " ", gui = "bold" })

            tab.add(" ")
          elseif info.filename then
            tab.add(" " .. info.index .. " ")
            tab.add(info.filename)
            tab.add({
              " " .. tab.icon(info.filename),
              fg = tab.icon_color(info.filename),
            })
            tab.add("  ")
          else
            tab.add(" " .. info.index .. " [No name]  ")
          end
        end)

        tab.add_spacer()

        local errors = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
        local info = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO })
        local hint = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT })

        tab.add({ "  " .. errors, fg = "#FF5D62" })
        tab.add({ "  " .. warnings, fg = "#E6C384" })
        tab.add({ "  " .. info, fg = "#A3D4D5" })
        tab.add({ " 󱩎 " .. hint, fg = "#7E9CD8" })

        tab.add(" ")
      end,
      hl = { fg = "#727169", bg = "#1F1F28" },
      hl_sel = { fg = "#FEF9D9", bg = "#1F1F28", gui = "italic,bold" },
      hl_fill = { fg = "#727169", bg = "#1F1F28" },
    })
  end,
}
