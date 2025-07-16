return {
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
