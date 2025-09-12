-- Disable auto comment
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Rebember folds
local remember_folds = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = remember_folds,
  pattern = "*.*",
  callback = function()
    if vim.bo.filetype ~= "help" then
      vim.cmd("mkview")
    end
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = remember_folds,
  pattern = "*.*",
  callback = function()
    if vim.bo.filetype ~= "help" then
      vim.cmd("silent! loadview")
    end
  end,
})

-- Highlight on yank
--[[ vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
}) ]]

-- Auto split vertical a help filetype opened
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("split_vertical", { clear = true }),
  pattern = "*txt",
  callback = function()
    if vim.bo.buftype == "help" then
      vim.cmd("wincmd L")
    end
  end,
})

-- Set custom filetypes
local set_filetypes = vim.api.nvim_create_augroup("set_filetypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = set_filetypes,
  pattern = { "*.handlebars", "*.hbs" },
  callback = function()
    vim.bo.filetype = "html"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = set_filetypes,
  pattern = "*.http",
  callback = function()
    vim.bo.filetype = "http"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = set_filetypes,
  pattern = ".env.*",
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- Auto remove whitespace at end of line
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Set terminal keymaps
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("set_terminal_keymaps", { clear = true }),
  pattern = "term://*",
  callback = function()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>]], opts)
  end,
})

-- Exit all terminal windows with :wqa (alias :Wqa)
vim.api.nvim_create_user_command("Wqa", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  vim.cmd("wqa")
end, {})

vim.cmd("cabbrev wqa Wqa")
