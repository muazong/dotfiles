local M = {}

local map = vim.keymap.set
M.state = "No Wrap"

map("n", "<Leader>nw", function()
  vim.cmd("set nowrap")
  M.state = "No Wrap"
  vim.notify(M.state .. " ↠", vim.log.levels.INFO, { title = "Wrap Toggle" })
end)

map("n", "<Leader>sw", function()
  vim.cmd("set wrap")
  M.state = "Wrap"
  vim.notify(M.state .. " ↩", vim.log.levels.INFO, { title = "Wrap Toggle" })
end)

return M
