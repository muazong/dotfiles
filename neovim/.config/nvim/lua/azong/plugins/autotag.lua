vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
})

local autotag_group = vim.api.nvim_create_augroup("LazyAutotag", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = autotag_group,
  pattern = {
    "html",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "xml",
    "php",
    "markdown",
  },
  once = true,
  callback = function()
    vim.cmd("packadd nvim-ts-autotag")
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })
  end,
})
