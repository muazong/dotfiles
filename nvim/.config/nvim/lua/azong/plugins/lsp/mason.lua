return {
  { -- Mason
    "mason-org/mason.nvim",
    version = "1.11.0",
    cmd = "Mason",
    build = ":MasonUpdate",
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
  { -- Mason lspconfig
    "mason-org/mason-lspconfig.nvim",
    version = "1.32.0",
    dependencies = "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        "html",
        "ts_ls",
        "volar",
        "cssls",
        "jsonls",
        "lua_ls",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",

        -- "rzls",
        -- "roslynv4",
        -- "omnisharp",
        -- "somesass_ls",
        -- "jdtls",
        -- "sqlls",
        -- "clangd",
      },
    },
  },
  { -- Mason tool installer
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    lazy = true,
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "shfmt",
          "clang-format",
          "eslint_d",
          --[[ "sql-formatter" ]]
        },
      })
    end,
  },
}
