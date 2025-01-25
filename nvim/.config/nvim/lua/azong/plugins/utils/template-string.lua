return {
  "axelvc/template-string.nvim",
  ft = { "js", "jsx", "javascript", "ts", "tsx", "typescript", "javascriptreact", "typescriptreact" },
  opts = {
    filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte" },
    jsx_brackets = true,
    remove_template_string = false,
    restore_quotes = {
      normal = [[']],
      jsx = [["]],
    },
  },
}
