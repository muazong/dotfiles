vim.pack.add({
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

local lazy_comment_group = vim.api.nvim_create_augroup("LazyComment", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = lazy_comment_group,
	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte", "*.lua", "*.vim" },
	callback = function()
		-- 1. Nạp cả hai plugin
		vim.cmd("packadd Comment.nvim")
		vim.cmd("packadd nvim-ts-context-commentstring")

		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		require("Comment").setup({
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})

		vim.api.nvim_clear_autocmds({ group = "LazyComment" })
	end,
})
