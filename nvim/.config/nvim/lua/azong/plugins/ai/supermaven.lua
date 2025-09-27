return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = function()
    vim.g.supermaven_is_running = true

    vim.keymap.set("n", "<leader>sm", function()
      if vim.g.supermaven_is_running then
        vim.cmd("SupermavenStop")
        vim.notify("󰜺 Supermaven stopped", vim.log.levels.INFO, {
          title = "Supermaven",
        })
        vim.g.supermaven_is_running = false
      else
        vim.cmd("SupermavenStart")
        vim.notify("󰚩 Supermaven started", vim.log.levels.INFO, {
          title = "Supermaven",
        })
        vim.g.supermaven_is_running = true
      end
    end, { desc = "Toggle Supermaven" })

    return {
      disable_inline_completion = false,
      disable_keymaps = false,
      keymaps = {
        accept_suggestion = "<C-f>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    }
  end,
}
