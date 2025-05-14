return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
      cs = { "clang-format" },
      sh = { "shfmt" },
      fish = { "shfmt" },
    },
    format_after_save = {
      lsp_fallback = true,
      timeout_ms = 300,
    },
  },
}
