vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.cmd("packadd nvim-lspconfig")

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
        return { desc = description, buffer = bufnr, noremap = true, silent = true }
      end

      map("n", "<leader>lr", "<cmd>lsp restart<cr>", opts("Restart LSP"))
      map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts("Resname"))
      map("n", "gf", "<cmd>FzfLua lsp_references<cr>", opts("Goto References"))
      map("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", opts("Goto Definitions"))
      map("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", opts("LSP Code Action"))

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

      map("n", "<S-k>", "<cmd>lua vim.lsp.buf.hover({ border = 'rounded' })<cr>", opts("Hover"))
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
})
