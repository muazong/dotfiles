local opts = vim.opt

opts.confirm = true
opts.filetype = "on"

opts.encoding = "utf-8"
opts.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

opts.shell = "/bin/fish"

opts.laststatus = 3

opts.showmode = false
opts.showcmd = false
opts.ruler = false

opts.path:append({ "**" })

opts.number = true
opts.relativenumber = false
opts.cursorline = true
opts.breakindent = true
opts.linebreak = true
opts.wrap = false
opts.textwidth = 80
opts.colorcolumn = "0"
opts.signcolumn = "yes"

opts.undofile = true
opts.swapfile = false
opts.backup = false
opts.writebackup = false

opts.termguicolors = true
opts.background = "dark"

opts.virtualedit = "block"
opts.inccommand = "split"

opts.history = 30
opts.updatetime = 50
opts.timeoutlen = 800

opts.tabstop = 2
opts.smarttab = true
opts.smartindent = true
opts.shiftwidth = 2
opts.numberwidth = 2
opts.expandtab = true
opts.shiftround = true
opts.copyindent = true

opts.iskeyword:append({ "_" })
opts.backspace = { "start", "eol", "indent" }

opts.scrolloff = 8
opts.sidescrolloff = 8

opts.autoread = true
opts.autowrite = true
opts.autoindent = true

opts.ignorecase = true
opts.infercase = true
opts.smartcase = true
opts.hlsearch = true

opts.splitright = true
opts.splitbelow = true
opts.splitkeep = "cursor"

if vim.fn.has("unix") == 1 or vim.fn.has("mac") == 1 then
	opts.clipboard:append("unnamedplus")
elseif vim.fn.has("win32") == 1 then
	opts.clipboard:append("unnamed")
end

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Configure for Kitty terminal
vim.cmd([[
" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"
let &t_ut=''
]])

-- KEYMAPS
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
map("n", "<C-b>", "<cmd>Lexplore<cr>")

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

-- On/Off wrap
map("n", "<Leader>nw", function()
	print("No Wrap")
	vim.cmd("set nowrap")
end)
map("n", "<Leader>sw", function()
	print("Wrap")
	vim.cmd("set wrap")
end)

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

-- AUTOCMD
-- Disable auto comment
vim.cmd([[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]])

-- Rebember folds
vim.cmd([[ 
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave *.* if &ft !=# 'help' | mkview | endif
    autocmd BufWinEnter *.* if &ft !=# 'help' | silent! loadview | endif
  augroup END
]])

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Auto split vertical a help filetype opened
vim.cmd([[
  augroup split_vertical
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  augroup END
]])

-- Set filetype
vim.cmd([[autocmd BufNewFile,BufRead *.handlebars set filetype=html]])
vim.cmd([[autocmd BufNewFile,BufRead *.hbs set filetype=html]])
vim.cmd([[autocmd BufNewFile,BufRead *.http set filetype=http]])

-- Colorscheme
vim.cmd("colorscheme habamax")
