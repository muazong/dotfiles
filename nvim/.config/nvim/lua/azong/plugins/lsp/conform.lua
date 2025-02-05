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
      html = { "prettierd" },
      json = { "prettierd" },
      vue = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      lua = { "stylua" },
      cpp = { "clang-format" },
      c = { "clang-format" },
      cs = { "csharpier" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      sql = { "sql_formatter" },
    },
    format_after_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
}
