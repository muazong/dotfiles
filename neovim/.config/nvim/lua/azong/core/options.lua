local opts = vim.opt

opts.confirm = true
opts.filetype = "on"

opts.encoding = "utf-8"
opts.fileencoding = "utf-8"
vim.scriptencoding = "utf-8"

opts.shell = "/bin/bash"

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
vim.g.netrw_winsize = 25
