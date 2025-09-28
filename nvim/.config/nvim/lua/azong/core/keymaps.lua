local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- Leader
vim.g.mapleader = " "

-- Command
map("n", ";", ":")

-- No highlight
map("n", "<CR>", "<cmd>noh<cr>", opts)

-- Insert leave
map({ "n", "v", "s", "i" }, "<C-c>", "<ESC>", opts)
map({ "i" }, "jk", "<ESC>", opts)
map({ "v", "s" }, "q", "<ESC>", opts)
map("c", "<C-c>", "<C-u><Esc>", opts)

-- Do not yank
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "s", '"_s')
map({ "n", "v" }, "c", '"_c')

-- Paste key
map("x", "p", [["_dP]])

-- Increase/Decrease keys
map("n", "=", "<C-a>")
map("v", "=", "g<C-a>")
map("n", "-", "<C-x>")
map("v", "-", "g<C-x>")

-- Select all
map("n", "<C-a>", "ggVG")
map("v", "<C-a>", "<Nop>")

-- Replace word under cursor
map("n", "<Leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })

-- Move to begin/end of line
map({ "n", "v" }, "<Leader>a", "$", { desc = "Move to begin of line", unpack(opts) })
map({ "n", "v" }, "<Leader>i", "0", { desc = "Move to end of line", unpack(opts) })

-- Better up/down
map({ "n", "x" }, "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true, silent = true })

-- Move fold
vim.cmd([[map <C-space> %]])

-- Move line up/down
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

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
map("v", "<S-Tab>", "<gv", opts)
map("v", "<Tab>", ">gv", opts)

-- Buffer
map("n", "<C-x>", "<Cmd> bd<CR>", opts)
map("n", "te", "<Cmd> tabnew<CR>", opts)
map("n", "<C-n>", "<Cmd> tabnext<CR>", opts)
map("n", "<C-p>", "<Cmd> tabprevious<CR>", opts)
map("n", "<A-n>", "<Cmd> +tabmove<CR>", opts)
map("n", "<A-p>", "<Cmd> -tabmove<CR>", opts)

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", i .. "gt", { noremap = true, silent = true })
end

-- Split windows
map("n", "<Leader>ss", "<Cmd> split<CR>", { desc = "Split Horizontal", unpack(opts) })
map("n", "<Leader>sv", "<Cmd> vsplit<CR>", { desc = "Split Vertical", unpack(opts) })

-- Resize windows
map("n", "<A-l>", "<C-w>>")
map("n", "<A-h>", "<C-w><")
map("n", "<A-k>", "<C-w>+")
map("n", "<A-j>", "<C-w>-")

-- Select active window
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-h>", "<C-w>h", opts)

map("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, noremap = true })

map("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, noremap = true })

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

map("i", "<C-q>", "<Nop>")
map("i", "<C-z>", "<Nop>")
map("i", "<C-b>", "<Nop>")
map("i", "<C-f>", "<Nop>")

map("i", "<C-n>", "<Nop>", { noremap = true, silent = true })
map("i", "<C-p>", "<Nop>", { noremap = true, silent = true })

map({ "v" }, "<S-j>", "<Nop>")
map({ "v", "n" }, "<S-h>", "<Nop>")
map({ "v", "n" }, "<S-l>", "<Nop>")

map({ "n", "v" }, "<Space>", "<Nop>")
map({ "n", "v" }, "<BS>", "<Nop>")

map({ "n", "v" }, "<del>", "<Nop>")
map({ "n", "v" }, "<ins>", "<Nop>")

map({ "n", "v" }, "<C-->", "<Nop>")
map({ "n", "v" }, "<C-=>", "<Nop>")
