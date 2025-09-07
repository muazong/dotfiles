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
      delay = 1000,
      use_focus = true,
      ignore_whitespace = false,
      virt_text_priority = 100,
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
      local map = function(mode, key, func, desc)
        vim.keymap.set(mode, key, func, { buffer = bufnr, silent = true, desc = desc })
      end

      map("n", "<C-]>", gs.next_hunk, "Go to next Git hunk")
      map("n", "<C-[>", gs.prev_hunk, "Go to previous Git hunk")
      map("n", "<leader>hp", gs.preview_hunk, "Preview current Git hunk")
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Show full git blame for current line")
      map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle inline Git blame for current line")
      map("n", "<leader>hd", gs.diffthis, "View diff for current file")
      map("n", "<leader>td", gs.toggle_deleted, "Toggle display of deleted lines")
    end,
  },
}
