return {
  "rafcamlet/tabline-framework.nvim",
  event = "VimEnter",
  config = function()
    require("tabline_framework").setup({
      render = function(tab)
        tab.add(" ")

        local current = vim.fn.tabpagenr()
        local max_tab_display = 5

        tab.make_tabs(function(info)
          if math.abs(info.index - current) > max_tab_display then
            return
          end

          local filename = info.filename or "[No name]"
          if #filename > 20 then
            filename = "…" .. string.sub(filename, -17)
          end

          local icon = ""
          local icon_color = "#FFFFFF"

          if info.filename then
            icon = tab.icon(info.filename) or ""
            icon_color = tab.icon_color(info.filename) or "#FFFFFF"
          else
            icon = "󰈔"
            icon_color = "#888888"
          end

          tab.add(" ")

          if info.index == current then
            tab.add({ tostring(info.index), gui = "bold,italic" })
            tab.add(" ")
            tab.add({ filename, gui = "bold,italic" })
            tab.add({ " " .. icon, fg = icon_color })

            if info.modified then
              tab.add({ " ", gui = "bold" })
            end

            tab.add(" ")
          else
            tab.add(" " .. tostring(info.index) .. " ")
            tab.add(filename)
            tab.add({ " " .. icon, fg = icon_color })

            if info.modified then
              tab.add(" ")
            end

            tab.add("  ")
          end
        end)

        tab.add_spacer()

        -- Diagnostics (LSP)
        local diagnostics = {
          {
            icon = "  ",
            count = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR }),
            fg = "#FF5D62",
          },
          {
            icon = "  ",
            count = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN }),
            fg = "#E6C384",
          },
          {
            icon = "  ",
            count = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.INFO }),
            fg = "#A3D4D5",
          },
          {
            icon = " 󱩎 ",
            count = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.HINT }),
            fg = "#7E9CD8",
          },
        }

        for _, d in ipairs(diagnostics) do
          tab.add({ d.icon .. d.count, fg = d.fg })
        end

        tab.add(" ")
      end,

      hl = { fg = "#727169", bg = "#1F1F28" },
      hl_sel = { fg = "#FEF9D9", bg = "#1F1F28", gui = "italic,bold" },
      hl_fill = { fg = "#727169", bg = "#1F1F28" },
    })
  end,
}
