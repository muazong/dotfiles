return {
  "y3owk1n/undo-glow.nvim",
  opts = {
    animation = {
      enabled = true,
      duration = 200,
      animation_type = "spring",
      window_scoped = true,
    },
    highlights = {
      undo = {
        hl_color = { bg = "#7FB4CA" },
      },
      redo = {
        hl_color = { bg = "#E6C384" },
      },
      paste = {
        hl_color = { bg = "#938AA9" },
      },
      yank = {
        hl_color = { bg = "#7A683A" },
      },
    },
    priority = 2048 * 3,
  },
  keys = {
    {
      "u",
      function()
        require("undo-glow").undo()
      end,
      mode = "n",
      desc = "Undo with highlight",
      noremap = true,
    },
    {
      "<C-r>",
      function()
        require("undo-glow").redo()
      end,
      mode = "n",
      desc = "Redo with highlight",
      noremap = true,
    },
    {
      "p",
      function()
        require("undo-glow").paste_below()
      end,
      mode = "n",
      desc = "Paste below with highlight",
      noremap = true,
    },
    {
      "P",
      function()
        require("undo-glow").paste_above()
      end,
      mode = "n",
      desc = "Paste above with highlight",
      noremap = true,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("TextYankPost", {
      desc = "Highlight when yanking (copying) text",
      callback = function()
        require("undo-glow").yank()
      end,
    })
  end,
}
