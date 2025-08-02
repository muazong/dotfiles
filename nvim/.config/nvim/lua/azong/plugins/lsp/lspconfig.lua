return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local map = vim.keymap.set
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
    capabilities = vim.tbl_deep_extend("force", capabilities, {
      textDocument = {
        foldingRange = {
          dynamicRegistration = false,
          lineFoldingOnly = true,
        },
      },
    })
    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      map("n", "<leader>lr", "<cmd>LspRestart<cr>", opts)
      map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      map("n", "gf", "<cmd>Telescope lsp_references<cr>", opts)
      map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)
      map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
      map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
      map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
      map("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
      map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
