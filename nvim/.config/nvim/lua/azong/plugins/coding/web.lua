return {
  { -- Markdown preview
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_port = "5000"
    end,
  },
  { -- HTML
    { -- Auto rename tag
      "AndrewRadev/tagalong.vim",
      ft = {
        "xml",
        "html",
        "js",
        "jsx",
        "javascript",
        "ts",
        "tsx",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "angular",
        "svelte",
        "cshtml",
        "razor",
      },
    },
    { -- Treesitter Autotag
      "windwp/nvim-ts-autotag",
      ft = {
        "xml",
        "html",
        "js",
        "jsx",
        "javascript",
        "ts",
        "tsx",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
      },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("nvim-ts-autotag").setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
          },
          per_filetype = {
            ["html"] = {
              enable_close = false,
              enable_rename = false,
              enable_close_on_slash = false,
            },
          },
        })
      end,
    },
  },
}
