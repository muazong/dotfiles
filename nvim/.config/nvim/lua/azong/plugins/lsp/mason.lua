return {
  {
    "mason-org/mason.nvim",
    event = "BufReadPre",
    build = ":MasonUpdate",
    cmd = { "Mason" },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          backdrop = 100,
          border = "rounded",
          width = 0.6,
          height = 0.8,
        },
        registries = {
          "github:mason-org/mason-registry",
          "github:crashdummyy/mason-registry",
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = "mason-org/mason.nvim",
    event = "BufReadPre",
    opts = {
      ensure_installed = {
        "html",
        "vue_ls",
        "vtsls",
        "cssls",
        "jsonls",
        "pylsp",
        "lua_ls",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",
      },
      automatic_installation = true,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "mason-org/mason.nvim",
    event = "BufReadPre",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "shfmt",
          "clang-format",
          "eslint_d",
          "black",
          "isort",
        },
      })
    end,
  },
}
