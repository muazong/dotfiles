vim.pack.add({
	"https://github.com/luukvbaal/statuscol.nvim",
})

local statuscol_group = vim.api.nvim_create_augroup("LazyStatusCol", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = statuscol_group,
	once = true,
	callback = function()
		vim.cmd("packadd statuscol.nvim")

		local statuscol = require("statuscol.builtin")

		require("statuscol").setup({
			segments = {
				{ sign = { namespace = { "gitsign*" }, auto = true, colwidth = 2 } },
				{ sign = { namespace = { "diagnostic*" }, auto = true, colwidth = 2 } },
				{ sign = { name = { "Dap*" }, auto = true, colwidth = 2 } },
				{ sign = { name = { "Bookmark" }, auto = true, colwidth = 2 } },
				{ text = { statuscol.lnumfunc, " " } },
				{ text = { statuscol.foldfunc, " " } },
			},
		})

		vim.api.nvim_del_augroup_by_id(statuscol_group)
	end,
})
