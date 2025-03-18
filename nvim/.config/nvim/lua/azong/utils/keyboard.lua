local M = {}

M.KEYBOARD_TYPES = {
  default = "Default",
  telex = "Vietnamese Telex",
}

M.message = M.KEYBOARD_TYPES.default
local telex_enabled = false

M.toggle_keyboard = function()
  telex_enabled = not telex_enabled

  if telex_enabled then
    vim.o.keymap = "vietnamese-telex_utf-8"
    M.message = M.KEYBOARD_TYPES.telex
  else
    vim.o.keymap = ""
    M.message = M.KEYBOARD_TYPES.default
  end

  vim.notify(M.message, vim.log.levels.INFO, {
    title = "Keyboard Layout",
  })
end

vim.keymap.set("n", "<Leader>v", M.toggle_keyboard, { noremap = true, silent = true })

return M
