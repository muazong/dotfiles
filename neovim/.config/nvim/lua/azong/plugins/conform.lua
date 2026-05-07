vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform_group = vim.api.nvim_create_augroup("LazyConform", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = conform_group,
  callback = function(args)
    vim.cmd("packadd conform.nvim")
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        vue = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        python = { "black", "isort" },
        lua = { "stylua" },
        sh = { "shfmt" },
        fish = { "shfmt" },
        java = { "google-java-format" },
      },
      format_after_save = {
        lsp_fallback = true,
        timeout_ms = 300,
      },
    })

    vim.api.nvim_del_augroup_by_id(conform_group)
    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
  end,
})
