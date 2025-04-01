local M = {}

local map = vim.keymap.set
local last_notification = nil
M.state = "No Wrap"

local function notify_with_clear(msg, title, icon)
  if last_notification then
    require("notify").dismiss(last_notification)
  end
  last_notification = require("notify")(icon .. " " .. msg, "info", {
    title = title,
    timeout = 2000,
  })
end

map("n", "<Leader>nw", function()
  vim.cmd("set nowrap")
  M.state = "No Wrap"
  notify_with_clear("No Wrap", "Wrap Toggle", "❎")
end)

map("n", "<Leader>sw", function()
  vim.cmd("set wrap")
  M.state = "Wrap"
  notify_with_clear("Wrap", "Wrap Toggle", "📖")
end)

return M
