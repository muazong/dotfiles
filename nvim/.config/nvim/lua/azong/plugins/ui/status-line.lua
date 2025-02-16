return {
  "beauwilliams/statusline.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local statusline = require("statusline")

    statusline.tabline = false
    statusline.lsp_diagnostics = true
  end,
}
