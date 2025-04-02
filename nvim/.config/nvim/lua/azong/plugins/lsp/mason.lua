return {
  { -- Mason
    "williamboman/mason.nvim",
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
      })
    end,
  },
  { -- Mason lspconfig
    "williamboman/mason-lspconfig.nvim",
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
        "omnisharp",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",

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
