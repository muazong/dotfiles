local map = vim.keymap.set
local keymap_opts = { silent = true, noremap = true }

-- Leader
vim.g.mapleader = " "

-- Command
map("n", ";", ":")

-- No highlight
map("n", "<CR>", "<cmd>noh<cr>", keymap_opts)

-- Insert leave
map({ "n", "v", "s", "i" }, "<C-c>", "<ESC>", keymap_opts)
map({ "i" }, "jk", "<ESC>", keymap_opts)
map({ "v", "s" }, "q", "<ESC>", keymap_opts)
map("c", "<C-c>", "<C-u><Esc>", keymap_opts)

-- Do not yank
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "s", '"_s')
map({ "n", "v" }, "c", '"_c')

-- Paste key
map("x", "p", [["_dP]])

-- File Explorer
vim.keymap.set("n", "<C-b>", function()
	local current_file = vim.fn.expand("%:t")
	vim.cmd("Lexplore " .. vim.fn.expand("%:p:h"))
	vim.schedule(function()
		if current_file ~= "" then
			vim.fn.search(current_file)
			vim.cmd("normal! zz")
		end
	end)
end, { desc = "Lexplore focus currnent file open" })

-- Increase/Decrease keys
map("n", "=", "<C-a>")
map("v", "=", "g<C-a>")
map("n", "-", "<C-x>")
map("v", "-", "g<C-x>")

-- Select all
map("n", "<C-a>", "ggVG")
map("v", "<C-a>", "<Nop>")

-- Replace word under cursor
map("n", "<Leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move to begin/end of line
map({ "n", "v" }, "<Leader>a", "$", keymap_opts)
map({ "n", "v" }, "<Leader>i", "0", keymap_opts)

-- Better up/down
map({ "n", "x" }, "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true, silent = true })

-- Move fold
vim.cmd([[map <C-space> %]])

-- Move line up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", keymap_opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", keymap_opts)

-- Move keys
map({ "i", "c" }, "<A-h>", "<Left>")
map({ "i", "c" }, "<A-l>", "<Right>")
map({ "i", "c" }, "<A-j>", "<Down>")
map({ "i", "c" }, "<A-k>", "<Up>")

-- PageUp/PageDown
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Go to highlight word
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Better indenting
map("v", "<S-Tab>", "<gv", keymap_opts)
map("v", "<Tab>", ">gv", keymap_opts)

-- Buffer
map("n", "<C-x>", "<Cmd> bd<CR>", keymap_opts)
map("n", "te", "<Cmd> tabnew<CR>", keymap_opts)
map("n", "<C-n>", "<Cmd> tabnext<CR>", keymap_opts)
map("n", "<C-p>", "<Cmd> tabprevious<CR>", keymap_opts)
map("n", "<A-n>", "<Cmd> +tabmove<CR>", keymap_opts)
map("n", "<A-p>", "<Cmd> -tabmove<CR>", keymap_opts)

-- Split windows
map("n", "<Leader>ss", "<Cmd> split<CR>", keymap_opts)
map("n", "<Leader>sv", "<Cmd> vsplit<CR>", keymap_opts)

-- Resize windows
map("n", "<A-l>", "<C-w>>")
map("n", "<A-h>", "<C-w><")
map("n", "<A-k>", "<C-w>+")
map("n", "<A-j>", "<C-w>-")

-- Select active window
map("n", "<C-j>", "<C-w>j", keymap_opts)
map("n", "<C-k>", "<C-w>k", keymap_opts)
map("n", "<C-l>", "<C-w>l", keymap_opts)
map("n", "<C-h>", "<C-w>h", keymap_opts)

-- Update plugins
vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, { desc = "Update plugins" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		-- Thiết lập phím tắt chỉ dành riêng cho buffer netrw
		local opts = { buffer = true, remap = false, silent = true }

		vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
		vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
		vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
		vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
	end,
})

-- Disable keys
map("i", "<C-s>", "<Nop>")
map("i", "<C-a>", "<Nop>")
map("i", "<C-k>", "<Nop>")
map("i", "<C-l>", "<Nop>")

map("n", "q", "<Nop>")
map({ "n", "v" }, "Q", "<Nop>")

map({ "n", "v" }, "<up>", "<Nop>")
map({ "n", "v" }, "<down>", "<Nop>")
map({ "n", "v" }, "<right>", "<Nop>")
map({ "n", "v" }, "<left>", "<Nop>")

map("i", "<C-v>", "<Nop>")
map("i", "<C-x>", "<Nop>")

map("i", "<C-u>", "<Nop>")
map("i", "<C-d>", "<Nop>")

map({ "v" }, "<S-j>", "<Nop>")
map({ "v", "n" }, "<S-h>", "<Nop>")
map({ "v", "n" }, "<S-l>", "<Nop>")

map({ "n", "v" }, "<Space>", "<Nop>")
map({ "n", "v" }, "<BS>", "<Nop>")

map({ "n", "v" }, "<del>", "<Nop>")
map({ "n", "v" }, "<ins>", "<Nop>")

map({ "n", "v" }, "<C-->", "<Nop>")
map({ "n", "v" }, "<C-=>", "<Nop>")
