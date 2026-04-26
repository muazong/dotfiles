vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
})

local function fzf_lazy(cmd)
	vim.cmd("packadd fzf-lua")

	require("fzf-lua").setup({
		ui_select = true,
		previewers = {
			builtin = {
				extensions = {
					["png"] = { "chafa", "{file}" },
					["jpg"] = { "chafa", "{file}" },
					["jpeg"] = { "chafa", "{file}" },
					["gif"] = { "chafa", "{file}" },
					["webp"] = { "chafa", "{file}" },
				},
			},
		},
		files = {
			fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules",
		},
		grep = {
			rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e --glob '!node_modules'",
		},
	})

	vim.keymap.set("n", "<c-f>", "<cmd>FzfLua files<cr>")
	vim.keymap.set("n", "<c-g>", "<cmd>FzfLua live_grep<cr>")

	require("fzf-lua")[cmd]()
end

vim.keymap.set("n", "<c-f>", function()
	fzf_lazy("files")
end)
vim.keymap.set("n", "<c-g>", function()
	fzf_lazy("live_grep")
end)
