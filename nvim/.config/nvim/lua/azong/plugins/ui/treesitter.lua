return {
  { -- Treesitter
    "neovim-treesitter/nvim-treesitter",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "tsx",
          "jsx",
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact",
          "lua",
          "vim",
          "json",
        },
        callback = function()
          vim.treesitter.start() -- highlighting
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
          vim.wo.foldmethod = "expr"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
        end,
      })
    end,
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.install({
        "javascript",
        "typescript",
        "tsx",
        "jsx",
        "lua",
        "vim",
        "json",
        "ecma",
        "jsdoc",
        "luadoc",
        "vimdoc",
      })
    end,
  },
  { -- Treesitter Context
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "neovim-treesitter/nvim-treesitter" },
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
        hi TreesitterContextBottom gui=underline guisp=#A594F9
        hi TreesitterContextLineNumberBottom gui=underline guisp=#A594F9
      ]])
    end,
  },
}
