vim.pack.add({
	"https://github.com/nguyenvukhang/nvim-toggler",
})

local toggler_config = {
	inverses = {
		["!=="] = "!==",
		["=="] = "!=",
		["min"] = "max",
		["Min"] = "Max",
		["MIN"] = "MAX",
		["yes"] = "no",
		["Yes"] = "No",
		["on"] = "off",
		["On"] = "Off",
		["up"] = "down",
		["Up"] = "Down",
		["top"] = "bottom",
		["Top"] = "Bottom",
		["left"] = "right",
		["Left"] = "Right",
		["1"] = "0",
		["true"] = "false",
		["True"] = "False",
		["stringify"] = "parse",
		["mouseup"] = "mousedown",
		["mouseover"] = "mouseout",
		["keyup"] = "keydown",
		["add"] = "remove",
		["before"] = "after",
		["Before"] = "After",
		["Relative"] = "Absolute",
		["relative"] = "absolute",
		["horizontal"] = "vertical",
		["Horizontal"] = "Vertical",
		[">"] = "<",
		["}"] = "{",
		["]"] = "[",
		[")"] = "(",
		["+"] = "-",
		["\\"] = "/",
	},
	remove_default_keybinds = true,
	remove_default_inverses = true,
}

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("packadd nvim-toggler")
	require("nvim-toggler").setup(toggler_config)
	vim.keymap.set("n", "<leader><leader>", function()
		require("nvim-toggler").toggle()
	end, { desc = "Toggle values", silent = true })
	require("nvim-toggler").toggle()
end, { desc = "Toggle values" })
