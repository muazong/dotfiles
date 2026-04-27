if vim.fn.has("nvim-0.12") == 1 then
	require("azong.core")
	require("azong.utils")
	require("azong.plugins")
else
	vim.notify("Neovim version 0.12 or higher is required.", vim.log.levels.ERROR)
end
