return {
  { -- Mason
    "mason-org/mason.nvim",
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
    dependencies = "mason-org/mason.nvim",
    lazy = true,
  },
  { -- Mason tool installer
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "mason-org/mason.nvim",
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
