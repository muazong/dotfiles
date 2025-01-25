return {
  "echasnovski/mini.animate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "echasnovski/mini.nvim" },
  opts = {
    cursor = {
      enable = true,
    },
    scroll = {
      enable = false,
    },
    resize = {
      enable = true,
      timing = function(_, n)
        return 10 / n
      end,
    },
    open = {
      enable = false,
    },
    close = {
      enable = false,
    },
  },
}
