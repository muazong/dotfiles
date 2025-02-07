return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local map = vim.keymap.set
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      map("n", "<leader>lr", "<cmd>LspRestart<cr>", opts)
      map("n", "<leader>rn", "<cmd>Lspsaga rename<cr>", opts)
      map("n", "gf", "<cmd>Lspsaga finder<cr>", opts)
      map("n", "gd", "<cmd>Lspsaga peek_definition<cr>", opts)
      map("n", "<leader>gd", "<cmd>Lspsaga goto_definition<cr>", opts)
      map("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", opts)
      map("n", "<leader>o", "<cmd>Lspsaga outline<cr>", opts)
      map("n", "gp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
      map("n", "gn", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
      map("n", "<s-k>", "<cmd>Lspsaga hover_doc<cr>", opts)
      map("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
    end

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end,

      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
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
