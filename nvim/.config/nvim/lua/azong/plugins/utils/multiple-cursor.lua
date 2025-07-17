return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    set({ "v" }, "<c-n>", function()
      mc.matchAddCursor(1)
    end)
    set({ "v" }, "<c-s>", function()
      mc.matchSkipCursor(1)
    end)
    set({ "v" }, "<c-p>", function()
      mc.matchAddCursor(-1)
    end)
    set({ "v" }, "<c-x>", function()
      mc.matchSkipCursor(-1)
    end)

    set({ "n", "x" }, "<c-q>", mc.toggleCursor)

    mc.addKeymapLayer(function(layerSet)
      layerSet("n", "q", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)

    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
