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
      local opts = function(description)
        return { desc = description, buffer = bufnr, noremap = true }
      end

      map("n", "<leader>lr", "<cmd>LspRestart<cr>", opts("Restart LSP"))
      map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts("Resname"))
      map("n", "gf", "<cmd>Telescope lsp_references<cr>", opts("Goto References"))
      map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts("Goto Definitions"))
      map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts("LSP Code Action"))

      -- map("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts("Goto Previous Diagnostic"))
      -- map("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts("Goto Next Diagnostic"))

      -- Previous diagnostic + show float
      map("n", "gp", function()
        vim.diagnostic.jump({ count = -1 })
        vim.schedule(function()
          vim.diagnostic.open_float(nil, { scope = "cursor", focus = false })
        end)
      end, opts("Goto Previous Diagnostic"))

      -- Next diagnostic + show float
      map("n", "gn", function()
        vim.diagnostic.jump({ count = 1 })
        vim.schedule(function()
          vim.diagnostic.open_float(nil, { scope = "cursor", focus = false })
        end)
      end, opts("Goto Next Diagnostic"))

      map("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover()<cr>", opts("Hover"))
      map("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<cr>", opts("Open Diagnostic Window Float"))
      map("n", "<leader>lh", function()
        local enabled = vim.lsp.inlay_hint.is_enabled()
        vim.lsp.inlay_hint.enable(not enabled)
        vim.notify("Inlay hints " .. (enabled and "disabled" or "enabled"))
      end, opts("Toggle LSP Inlay Hint"))
    end

    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
