vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.api.nvim_create_autocmd("BufReadPre", {
  once = true,
  callback = function()
    vim.cmd("packadd mason.nvim")
    vim.cmd("packadd mason-lspconfig.nvim")
    vim.cmd("packadd mason-tool-installer.nvim")

    require("mason").setup({
      ui = {
        icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
        backdrop = 100,
        border = "rounded",
        width = 0.6,
        height = 0.8,
      },
      registries = { "github:mason-org/mason-registry", "github:Crashdummyy/mason-registry" },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "tsgo",
        "cssls",
        "jsonls",
        "lua_ls",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",
      },
      automatic_installation = true,
    })

    require("mason-tool-installer").setup({
      ensure_installed = { "stylua", "prettierd", "eslint_d" },
      auto_update = true,
      run_on_start = true,
    })
  end,
})
