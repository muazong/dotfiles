return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    local opts = vim.opt
    local maps = vim.keymap.set

    opts.foldcolumn = "1"
    opts.foldlevel = 99
    opts.foldlevelstart = 99
    opts.foldenable = true

    maps("n", "zO", require("ufo").openAllFolds)
    maps("n", "zM", require("ufo").closeAllFolds)

    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end,
}
