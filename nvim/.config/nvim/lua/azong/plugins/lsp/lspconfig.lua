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
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,

      -- TS/JS/Vue
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          -- root_dir = lspconfig.util.root_pattern(".git"),
          on_attach = on_attach,
          capabilities = capabilities,
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = {
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
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "vue",
          },
        })
      end,

      -- Tailwindcss
      ["tailwindcss"] = function()
        lspconfig["tailwindcss"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          root_dir = function(fname)
            return lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
              or lspconfig.util.root_pattern("postcss.config.js", "postcss.config.ts")(fname)
              or lspconfig.util.root_pattern("node_modules/tailwindcss")(fname)
          end,
        })
      end,

      -- C/C++
      ["clangd"] = function()
        lspconfig["clangd"].setup({
          on_attach = on_attach,
          capabilities = {
            offsetEncoding = "utf-8",
          },
          filetypes = { "cpp", "c" },
        })
      end,

      -- Lua
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
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
