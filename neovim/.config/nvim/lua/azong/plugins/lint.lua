vim.pack.add({
	"https://github.com/mfussenegger/nvim-lint",
})

local lint_group = vim.api.nvim_create_augroup("LazyLint", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = lint_group,
	once = true,
	callback = function()
		vim.cmd("packadd nvim-lint")

		local lint = require("lint")

		lint.linters_by_ft = {
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			vue = { "eslint_d" },
			html = { "tidy" },
			bash = { "shellcheck" },
		}

		local active_lint_group = vim.api.nvim_create_augroup("ActiveLinting", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = active_lint_group,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>lt", function()
			lint.try_lint()
		end, { desc = "Trigger linting" })
	end,
})
