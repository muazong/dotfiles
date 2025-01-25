return {
  { -- Treesitter
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "luadoc",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "bash",
          "json",
          "cpp",
          "markdown",
          "markdown_inline",
          "regex",
          "gitignore",
          "git_config",
          "toml",
          "html",
          "css",
          "scss",
          "http",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = { "tmux" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          use_languagetree = true,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
  { -- Treesitter Context
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 0,
      trim_scope = "outer",
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      patterns = {
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
      },
      zindex = 20,
      mode = "cursor",
      separator = nil,
      on_attach = nil,
    },
    config = function()
      vim.keymap.set({ "n", "v" }, "<S-z>", function()
        require("treesitter-context").go_to_context(vim.v.count1)
      end, { silent = true })

      -- Treesitter Context bottom underline
      vim.cmd([[
        hi TreesitterContextBottom gui=underline guisp=#E6C384
        hi TreesitterContextLineNumberBottom gui=underline guisp=#E6C384
      ]])
    end,
  },
}
