-- Disable auto comment
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- Rebember folds
vim.cmd([[ 
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* if &ft !=# 'help' | mkview | endif
    autocmd BufWinEnter *.* if &ft !=# 'help' | silent! loadview | endif
  augroup END
]])

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- Auto split vertical a help filetype opened
vim.cmd([[
  augroup split_vertical
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  augroup END
]])

-- Set filetype
vim.cmd([[autocmd BufNewFile,BufRead *.handlebars set filetype=html]])
vim.cmd([[autocmd BufNewFile,BufRead *.hbs set filetype=html]])
vim.cmd([[autocmd BufNewFile,BufRead *.http set filetype=http]])
