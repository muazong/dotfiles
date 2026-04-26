local M = {}

local map = vim.keymap.set
local isWrap = vim.opt.wrap:get()
M.state = "No Wrap"

map("n", "<Leader>ww", function()
  if isWrap then
    vim.cmd("set nowrap")
    M.state = "No Wrap"
    vim.notify(M.state .. " ↠", vim.log.levels.INFO, { title = "Wrap Toggle" })
    isWrap = false
  else
    vim.cmd("set wrap")
    M.state = "Wrap"
    vim.notify(M.state .. " ↩", vim.log.levels.INFO, { title = "Wrap Toggle" })
    isWrap = true
  end
end, { desc = "Toggle Wrap" })

return M
