return {
  { -- LSP config
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      -- { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
    },
    config = function()
      local map = vim.keymap.set
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        map("n", "<leader>lr", "<cmd>LspRestart<cr>", opts)
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
        -- VueJs
        ["volar"] = function()
          lspconfig["volar"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "vue" },
            init_options = {
              vue = {
                hybridMode = false,
              },
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
  },
  { -- Show diagnostics inline
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        -- "modern", "classic", "minimal", "powerline",
        -- "ghost", "simple", "nonerdfont", "amongus"
        preset = "ghost",

        hi = {
          error = "DiagnosticError",
          warn = "DiagnosticWarn",
          info = "DiagnosticInfo",
          hint = "DiagnosticHint",
          arrow = "NonText",
          background = "CursorLine",
          mixing_color = "None",
        },

        options = {
          show_source = false,
          use_icons_from_diagnostic = false,
          add_messages = true,
          throttle = 0,
          softwrap = 30,
          multiple_diag_under_cursor = false,
          multilines = {
            enabled = true,
            always_show = true,
          },
          show_all_diags_on_cursorline = false,
          enable_on_insert = true,
          enable_on_select = false,

          overflow = {
            -- Manage how diagnostic messages handle overflow
            -- Options:
            -- "wrap" - Split long messages into multiple lines
            -- "none" - Do not truncate messages
            -- "oneline" - Keep the message on a single line, even if it's long
            mode = "wrap",
          },
          break_line = {
            enabled = false,
            after = 30,
          },
          format = function(diagnostic)
            return diagnostic.message .. " [" .. diagnostic.source .. "]"
          end,
          virt_texts = {
            priority = 2048,
          },
          severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
          },
          overwrite_events = nil,
        },
      })
    end,
  },
}
