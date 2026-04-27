---@diagnostic disable-next-line: duplicate-set-field
function _G.get_lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return "No LSP"
	end

	local names = {}
	for _, client in pairs(clients) do
		table.insert(names, client.name)
	end
	return table.concat(names, ", ")
end

vim.opt.statusline = "%f %h%m%r%= LSP: [%{v:lua.get_lsp_status()}] "

vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
	callback = function()
		vim.cmd("redrawstatus")
	end,
})
