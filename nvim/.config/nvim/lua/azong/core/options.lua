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
opts.relativenumber = true
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
