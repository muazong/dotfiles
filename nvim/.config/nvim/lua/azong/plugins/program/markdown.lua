return {
  { -- Markdown preview use local server
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_port = "5000"
    end,
  },
  { -- Markdown preview inside neovim
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "md" },
    config = function()
      require("markview").setup({
        preview = {
          icon_provider = "devicons",
        },
      })
    end,
  },
}
