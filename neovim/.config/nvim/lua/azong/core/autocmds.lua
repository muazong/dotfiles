-- Disable auto comment
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- Rebember folds
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	group = vim.api.nvim_create_augroup("remember_folds", { clear = true }),
	callback = function()
		if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" and vim.bo.ft ~= "help" then
			vim.cmd("silent! mkview")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("remember_folds_load", { clear = true }),
	callback = function()
		if vim.fn.expand("%") ~= "" and vim.bo.buftype == "" and vim.bo.ft ~= "help" then
			vim.cmd("silent! loadview")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({
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

-- Colorscheme
vim.cmd("colorscheme catppuccin")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NonText", { bg = "none" })

vim.cmd([[
  hi DiagnosticUnderlineError gui=undercurl cterm=undercurl
  hi DiagnosticUnderlineWarn gui=undercurl cterm=undercurl
  hi DiagnosticUnderlineInfo gui=undercurl cterm=undercurl
  hi DiagnosticUnderlineHint gui=undercurl cterm=undercurl
]])
