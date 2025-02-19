return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local map = vim.keymap.set
    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

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

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      -- TS/JS/Vue
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = {
                  "js",
                  "jsx",
                  "ts",
                  "tsx",
                  "javascript",
                  "typescript",
                  "javascriptreact",
                  "typescriptreact",
                  "vue",
                },
              },
            },
          },
          filetypes = {
            "js",
            "jsx",
            "ts",
            "tsx",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
        })
      end,

      -- C/C++
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          capabilities = {
            offsetEncoding = "utf-8",
          },
          on_attach = on_attach,
          filetypes = { "cpp", "c" },
        })
      end,

      -- Lua
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        })
      end,
    })
  end,
}
