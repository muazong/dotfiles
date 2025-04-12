return {
  "rafcamlet/tabline-framework.nvim",
  event = "VimEnter",
  config = function()
    require("tabline_framework").setup({
      render = function(tab)
        tab.add(" ")

        local current = vim.fn.tabpagenr()
        local total_tabs = vim.fn.tabpagenr("$")
        local columns = vim.o.columns
        local max_tab_display = columns < 80 and 3 or (columns < 100 and 4 or 5)
        local visible_tabs = {}

        local half_display = math.floor(max_tab_display / 2)
        local start = math.max(1, current - half_display)
        local finish = math.min(total_tabs, start + max_tab_display - 1)

        if finish - start + 1 < max_tab_display then
          start = math.max(1, finish - max_tab_display + 1)
        end

        for i = start, finish do
          table.insert(visible_tabs, i)
        end

        if not vim.tbl_contains(visible_tabs, current) then
          table.insert(visible_tabs, current)
          table.sort(visible_tabs)
          if #visible_tabs > max_tab_display then
            if current <= half_display then
              table.remove(visible_tabs, #visible_tabs)
            else
              table.remove(visible_tabs, 1)
            end
          end
        end

        if start > 1 then
          tab.add({ "  ", gui = "bold", fg = "#E6C384" })
        end

        tab.make_tabs(function(info)
          if not vim.tbl_contains(visible_tabs, info.index) and info.index ~= current then
            return
          end

          local filename = info.filename or "[No name]"
          local full_filename = vim.fn.fnamemodify(filename, ":t")
          local base, ext = full_filename:match("^(.*)%.(.*)$")
          base = base or full_filename
          ext = ext and ("." .. ext) or ""

          local icon = ""
          local icon_color = "#FFFFFF"
          if info.filename then
            icon = tab.icon(info.filename) or ""
            icon_color = tab.icon_color(info.filename) or "#FFFFFF"
          else
            icon = "󰈔"
            icon_color = "#888888"
          end

          local display_name
          if info.index == current then
            display_name = base .. ext
          else
            display_name = base .. ext
            local limit = columns >= 100 and 10 or 8
            if #display_name > limit then
              display_name = display_name:sub(1, limit) .. "…"
            end
          end

          if info.index == current then
            tab.add({ " " .. info.index .. " ", gui = "bold,italic" })
            tab.add({ display_name, gui = "bold,italic" })
            tab.add({ " " .. icon, fg = icon_color })
            if info.modified then
              tab.add({ " ", gui = "bold" })
            end
          else
            tab.add(" " .. info.index .. " ")
            tab.add(display_name)
            tab.add({ " " .. icon, fg = icon_color })
            if info.modified then
              tab.add(" ")
            end
          end

          tab.add(" ")
        end)

        if finish < total_tabs then
          tab.add({ "  ", gui = "bold", fg = "#7E9CD8" })
        end

        tab.add_spacer()

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
