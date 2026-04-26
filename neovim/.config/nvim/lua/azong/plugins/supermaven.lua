vim.pack.add({
  "https://github.com/supermaven-inc/supermaven-nvim",
  "https://github.com/huijiro/blink-cmp-supermaven",
})

vim.g.supermaven_is_running = true

local function load_supermaven()
  if not package.loaded["supermaven-nvim"] then
    vim.cmd("packadd supermaven-nvim")
    vim.cmd("packadd blink-cmp-supermaven")
    require("supermaven-nvim").setup({
      disable_inline_completion = false,
      disable_keymaps = false,
      keymaps = {
        accept_suggestion = "<C-f>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    })
  end
end

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = load_supermaven,
})

vim.keymap.set("n", "<leader>sm", function()
  load_supermaven()
  if vim.g.supermaven_is_running then
    vim.cmd("SupermavenStop")
    vim.notify("󰜺 Supermaven stopped", vim.log.levels.INFO, { title = "Supermaven" })
    vim.g.supermaven_is_running = false
  else
    vim.cmd("SupermavenStart")
    vim.notify("󰚩 Supermaven started", vim.log.levels.INFO, { title = "Supermaven" })
    vim.g.supermaven_is_running = true
  end
end, { desc = "Toggle Supermaven" })
