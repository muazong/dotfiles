return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<C-t>", "<cmd>ToggleTerm<CR>" },
    {
      "<leader>lg",
      "<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazygit', hidden = true }):toggle()<CR>",
      desc = "Lazygit",
    },
  },
  config = function()
    vim.keymap.set({ "n", "t" }, "<C-t>", '<Cmd>exe v:count1 . "ToggleTerm"<CR>')

    require("toggleterm").setup({
      direction = "float",
      auto_scroll = true,
      float_opts = {
        border = "rounded",
        title_pos = "center",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
        winblend = 0,
        zindex = 100,
      },
    })
  end,
}
