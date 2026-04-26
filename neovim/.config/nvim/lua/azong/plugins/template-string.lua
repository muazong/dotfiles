vim.pack.add({
	"https://github.com/axelvc/template-string.nvim",
})

local lazy_template_string = vim.api.nvim_create_augroup("LazyTemplateString", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = lazy_template_string,
	pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.vue", "*.svelte" },
	callback = function()
		vim.cmd("packadd template-string.nvim")

		require("template-string").setup({
			filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte" },
			jsx_brackets = true,
			remove_template_string = false,
			restore_quotes = {
				normal = [[']],
				jsx = [["]],
			},
		})

		vim.api.nvim_clear_autocmds({ group = "LazyTemplateString" })
	end,
})
