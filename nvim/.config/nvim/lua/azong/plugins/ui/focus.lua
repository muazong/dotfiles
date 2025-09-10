return {
  "nvim-focus/focus.nvim",
  keys = {
    { "<leader>ss", "<cmd>split<cr>", desc = "Split horizontally" },
    { "<leader>sv", "<cmd>vsplit<cr>", desc = "Split vertically" },
  },
  config = function()
    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("FocusDisable", { clear = true }),
      callback = function(_)
        if vim.tbl_contains({ "nofile", "prompt", "popup" }, vim.bo.buftype) then
          vim.w.focus_disable = true
        else
          vim.w.focus_disable = false
        end
      end,
    })

    require("focus").setup({
      commands = false,
      ui = {
        cursorline = false,
        signcolumn = false,
      },
    })
  end,
}
