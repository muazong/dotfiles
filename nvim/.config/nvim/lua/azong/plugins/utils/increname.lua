return {
  "smjonas/inc-rename.nvim",
  keys = { { "<leader>rn", "<cmd>IncRename<cr>" } },
  config = function()
    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })

    require("inc_rename").setup({
      cmd_name = "IncRename",
      -- input_buffer_type = "dressing",
      hl_group = "IncSearch",
      preview_empty_name = false,
      show_message = true,
      post_hook = nil,
    })
  end,
}
