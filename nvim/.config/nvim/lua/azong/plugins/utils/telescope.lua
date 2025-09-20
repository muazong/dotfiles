return {
  { -- Telescope
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = { "Telescope" },
    keys = {
      { "<C-f>", "<cmd>Telescope find_files<cr>" },
      { "<C-b>", "<cmd>Telescope file_browser<cr>" },
      { "<C-g>", "<cmd>Telescope live_grep<cr>" },
      { "<C-s>", "<cmd>Telescope grep_string<cr>" },
      { "tb", "<cmd>Telescope buffers<cr>" },
      { "?", "<cmd>Telescope help_tags<cr>" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = telescope.extensions.file_browser.actions

      telescope.setup({
        defaults = {
          path_display = { "smart" },
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
            find_command = {
              "fd",
              "--type",
              "f",
              "--follow",
              "--exclude",
              ".git",
              "--exclude",
              "node_modules",
              "--exclude",
              "dist",
              "--exclude",
              "venv",
              "--exclude",
              ".venv",
              "--exclude",
              "obj",
              "--exclude",
              "bin",
              "--exclude",
              "android",
              "--exclude",
              "ios",
              "--exclude",
              "macos",
              "--exclude",
              "windows",
              "--exclude",
              "web",
              "--exclude",
              "Migrations",
              "--exclude",
              "__pycache__",
              "--exclude",
              "build",
            },
            previewer = false,
            hidden = false,
            initial_mode = "insert",
          },
          live_grep = {
            initial_mode = "insert",
            additional_args = function()
              return {
                "--glob",
                "!.git/*",
                "--glob",
                "!node_modules/*",
                "--glob",
                "!dist/*",
                "--glob",
                "!venv/*",
                "--glob",
                "!obj/*",
                "--glob",
                "!bin/*",
                "--glob",
                "!android/*",
                "--glob",
                "!ios/*",
                "--glob",
                "!macos/*",
                "--glob",
                "!windows/*",
                "--glob",
                "!web/*",
                "--glob",
                "!Migrations/*",
                "--glob",
                "!__pycache__/*",
                "--glob",
                "!build/*",
                "--glob",
                "!bun.lock",
                "--glob",
                "!package.json",
                "--glob",
                "!package-lock.json",
              }
            end,
          },
          help_tags = {
            initial_mode = "insert",
          },
          buffers = {
            previewer = false,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            initial_mode = "normal",
            hidden = true,
            grouped = true,
            no_ignore = true,
            git_status = true,
            previewer = false,
            hijack_netrw = true,
            follow_symlinks = true,
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

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
    end,
  },
  { -- Telescope Bookmark
    "MattesGroeger/vim-bookmarks",
    dependencies = {
      "tom-anders/telescope-vim-bookmarks.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "mm", "<cmd>BookmarkToggle<cr>" },
      { "ma", "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>" },
      { "mc", "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file()<cr>" },
    },
    config = function()
      vim.g.bookmark_sign = "󰟙"
      vim.g.bookmark_highlight_lines = 1

      require("telescope").load_extension("vim_bookmarks")
    end,
  },
}
