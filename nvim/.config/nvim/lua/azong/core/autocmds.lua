-- Disable auto comment
vim.api.nvim_create_autocmd("FileType", {
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
