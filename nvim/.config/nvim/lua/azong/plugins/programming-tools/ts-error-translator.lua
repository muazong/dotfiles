return {
  "dmmulroy/ts-error-translator.nvim",
  ft = { "typescript", "typescriptreact", "ts", "tsx", "javascript", "javascriptreact", "js", "jsx", "vue" },
  config = function()
    local ts_error_translator = require("ts-error-translator")

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == "vtsls" then
          ts_error_translator.setup()
        end
      end,
    })
  end,
}
