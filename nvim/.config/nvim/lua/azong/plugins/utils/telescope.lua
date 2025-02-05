return {
  { -- Telescope
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true,
        keys = {
          { "<C-b>", "<CMD>Telescope file_browser<CR>" },
        }
      },
    },
    cmd = { "Telescope" },
    keys = {
      { "<C-f>", "<CMD>Telescope find_files<CR>" },
      { "<C-g>", "<CMD>Telescope live_grep<CR>" },
      { "<C-s>", "<CMD>:Telescope grep_string<CR>" },
      { "tb", "<CMD>:Telescope buffers<CR>" },
      { "?", "<CMD>:Telescope help_tags<CR>" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = telescope.extensions.file_browser.actions

      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = " ",
          initial_mode = "normal",
          layout_config = {
            width = 0.7,
            height = 0.8,
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-o>"] = actions.select_default,
              ["<C-c>"] = actions.close,
            },
            n = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["l"] = actions.select_default,
              ["<C-o>"] = actions.select_default,
              ["<C-c>"] = actions.close,
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            previewer = false,
            hidden = false,
            no_ignore = true,
            no_ignore_parent = true,
            file_ignore_patterns = {
              "^node_modules/",
              "^obj/",
              "^bin/",
              "^android/",
              "^ios/",
              "^macos/",
              "^windows/",
              "^web/",
              -- "^build/",
            },
            initial_mode = "insert",
          },
          live_grep = {
            grep_open_files = false,
            initial_mode = "insert",
          },
          help_tags = {
            initial_mode = "insert",
          },
          buffers = {
            previewer = false,
          },
        },
        extensions = {
          file_browser = {
            initial_mode = "normal",
            hidden = true,
            grouped = true,
            no_ignore = true,
            git_status = true,
            previewer = false,
            hijack_netrw = true,
            select_buffer = true,
            path = "%:p:h",
            dir_icon = "",
            sorting_strategy = "ascending",
            layout_config = {
              horizontal = { prompt_position = "top" },
              width = 0.7,
              height = 0.8,
            },
            mappings = {
              ["n"] = {
                ["a"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["c"] = fb_actions.change_cwd,
                ["Y"] = fb_actions.copy,
                ["H"] = fb_actions.toggle_hidden,
                ["M"] = fb_actions.move,
              },
            },
          },
        },
      })

      telescope.load_extension("file_browser")
      telescope.load_extension("vim_bookmarks")
    end,
  },
  { -- Telescope Bookmark
    "MattesGroeger/vim-bookmarks",
    dependencies = {
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    keys = {
      { "mm", "<Cmd> BookmarkToggle <CR>" },
      { "ma", "<Cmd> lua require('telescope').extensions.vim_bookmarks.all() <CR>" },
      { "mc", "<Cmd> lua require('telescope').extensions.vim_bookmarks.current_file() <CR>" },
    },
    config = function()
      vim.g.bookmark_sign = "󰟙"
      vim.g.bookmark_highlight_lines = 1
    end,
  },
}
