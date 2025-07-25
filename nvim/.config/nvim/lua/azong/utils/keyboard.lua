local M = {}

M.layouts = {
  default = "EN",
  telex = "VI",
}

M.telex_enabled = false
M.layout = M.layouts.default
M.notify_id = nil

M.toggle_keyboard = function()
  M.telex_enabled = not M.telex_enabled
  M.layout = M.telex_enabled and M.layouts.telex or M.layouts.default
  vim.o.keymap = M.telex_enabled and "vietnamese-telex_utf-8" or ""

  if M.notify_id then
    ---@diagnostic disable-next-line: undefined-global
    Snacks.notifier.hide(M.notify_id)
  end

  M.notify_id = vim.notify("Current: " .. M.layout, vim.log.levels.INFO, { title = "🖮Typing Mode" })
end

vim.keymap.set("n", "<Leader>v", M.toggle_keyboard, { noremap = true, silent = true })

return M
