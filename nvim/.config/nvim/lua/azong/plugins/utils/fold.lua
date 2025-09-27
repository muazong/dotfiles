return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "kevinhwang91/promise-async" },
  init = function()
    local opts = vim.opt

    opts.foldcolumn = "1"
    opts.foldlevel = 99
    opts.foldlevelstart = 99
    opts.foldenable = true
    opts.fillchars = {
      foldopen = "",
      foldclose = "",
      fold = " ",
      foldsep = " ",
      diff = "╱",
      eob = " ",
    }
  end,
  config = function()
    require("ufo").setup({})
  end,
}
