return {
  { -- Mason
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
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
  },
  { -- Mason lspconfig
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
        "markdown_oxide",
        "basedpyright",
        "lua_ls",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",
      },
      automatic_installation = true,
    },
  },
  { -- Mason tool installer
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "mason-org/mason.nvim",
    event = "BufReadPre",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "shfmt",
          "mypy",
          "flake8",
          "eslint_d",
          "black",
          "isort",
          -- "kulala-fmt",
        },
      })
    end,
  },
}
