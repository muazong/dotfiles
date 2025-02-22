local M = {}

local KEYBOARD_TYPES = {
  default = "Default",
  telex = "Vietnamese Telex",
}

local message = KEYBOARD_TYPES.default
local telex_enabled = false

local toggle_telex = function()
  telex_enabled = not telex_enabled

  if telex_enabled then
    vim.o.keymap = "vietnamese-telex_utf-8"
    message = KEYBOARD_TYPES.telex
  else
    vim.o.keymap = ""
    message = KEYBOARD_TYPES.default
  end

  vim.notify(message, vim.log.levels.INFO, {
    title = "Keyboard Layout",
  })
end

vim.keymap.set("n", "<Leader>v", toggle_telex, { noremap = true, silent = true })

return M
