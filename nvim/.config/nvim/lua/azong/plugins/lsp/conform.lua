return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    async = true,
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
      python = { "black" },
      lua = { "stylua" },
      sh = { "shfmt" },
      fish = { "shfmt" },
    },
    format_after_save = {
      lsp_fallback = true,
      timeout_ms = 300,
    },
  },
}
