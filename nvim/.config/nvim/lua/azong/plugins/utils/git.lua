return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 200,
    },
    watch_gitdir = {
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame_formatter = " <author>, <author_time:%H:%M %p, %Y-%m-%d> - <summary>",
    preview_config = {
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, key, func)
        vim.keymap.set(mode, key, func, { buffer = bufnr, silent = true })
      end

      map("n", "<C-]>", gs.next_hunk)
      map("n", "<C-[>", gs.prev_hunk)
      map("n", "<leader>hp", gs.preview_hunk)
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      map("n", "<leader>hd", gs.diffthis)
      map("n", "<leader>td", gs.toggle_deleted)
    end,
  },
}
