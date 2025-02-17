return {
  "akinsho/toggleterm.nvim",
  keys = { { "<C-t>", "<Cmd>ToggleTerm<CR>" } },
  config = function()
    vim.keymap.set({ "n", "t" }, "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>')

    require("toggleterm").setup({
      direction = "float",
      float_opts = {
        border = "rounded",
        title_pos = "center",
        width = 90,
        height = vim.o.lines - 3,
        winblend = 0,
        zindex = 100,
      },
    })
  end,
}
