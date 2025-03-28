local M = {}

M.layouts = {
  default = "Default",
  telex = "Vietnamese Telex",
}

M.message = M.layouts.default
M.telex_enabled = false

M.toggle_keyboard = function()
  M.telex_enabled = not M.telex_enabled

  vim.o.keymap = M.telex_enabled and "vietnamese-telex_utf-8" or ""
  M.message = M.telex_enabled and M.layouts.telex or M.layouts.default

  vim.schedule_wrap(vim.notify)(M.message, vim.log.levels.INFO, { title = "⌨️ Typing Mode" })
end

vim.keymap.set("n", "<Leader>v", M.toggle_keyboard, { noremap = true, silent = true })

return M
