vim.pack.add({
  "https://github.com/windwp/nvim-autopairs",
})

local autopairs_group = vim.api.nvim_create_augroup("LazyAutopairs", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = autopairs_group,
  once = true,
  callback = function()
    vim.cmd("packadd nvim-autopairs")
    require("nvim-autopairs").setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
      },
    })
  end,
})
