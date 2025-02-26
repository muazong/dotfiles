return {
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
      })
    end,
  },
}
