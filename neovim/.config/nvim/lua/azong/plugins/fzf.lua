vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

local function fzf_lazy(cmd)
  vim.cmd("packadd fzf-lua")

  require("fzf-lua").setup({
    ui_select = true,
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
