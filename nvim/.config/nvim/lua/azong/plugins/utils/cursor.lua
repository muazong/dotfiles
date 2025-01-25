return {
  { -- Multiple cursors
    "brenton-leighton/multiple-cursors.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      local autopairs = require("nvim-autopairs")
      local function disable_autopairs()
        autopairs.disable()
      end
      local function enable_autopairs()
        autopairs.enable()
      end

      map({ "v", "x" }, "<C-n>", "<cmd>MultipleCursorsAddJumpNextMatch<cr>", opts)
      map({ "v", "x" }, "<C-p>", "<cmd>MultipleCursorsJumpNextMatch<cr>", opts)
      map({ "v", "x" }, "<C-j>", "<cmd>MultipleCursorsAddDown<cr>", opts)
      map({ "v", "x" }, "<C-k>", "<cmd>MultipleCursorsAddUp<cr>", opts)

      require("multiple-cursors").setup({
        pre_hook = disable_autopairs,
        post_hook = enable_autopairs,
      })
    end,
  },
  { -- Cursor line
    "yamatsum/nvim-cursorline",
    lazy = false,
    opts = {
      cursorline = {
        enable = false,
        number = false,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true, bold = true },
      },
    },
  },
}
