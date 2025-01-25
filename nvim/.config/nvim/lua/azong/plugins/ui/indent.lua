return {
  { -- Indent scope
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      symbol = "│",
    },
    dependencies = {
      "echasnovski/mini.nvim",
      {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
          indent = {
            char = "┊",
            tab_char = "│",
          },
          scope = { show_start = false, show_end = false },
          exclude = {
            filetypes = {
              "help",
              "alpha",
              "Trouble",
              "trouble",
              "lazy",
              "mason",
              "notify",
              "toggleterm",
            },
          },
        },
      },
    },
  },
  { -- Auto indent
    "vidocqh/auto-indent.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      lightmode = true,
      indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
      end,
      ignore_filetype = {},
    },
  },
}
