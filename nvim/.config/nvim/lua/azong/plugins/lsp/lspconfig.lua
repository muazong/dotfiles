return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local map = vim.keymap.set
    local lspconfig = require("lspconfig")
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

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end,

        -- TypeScript / Vue LSP
        ["ts_ls"] = function()
          lspconfig["ts_ls"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
              hostInfo = "neovim",
              maxTsServerMemory = 4096,
              disableAutomaticTypeAcquisition = true,
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
            root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git"),

            settings = {
              typescript = {
                disableAutomaticTypeAcquisition = true,
                inlayHints = {
                  includeInlayParameterNameHints = "literal",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = false,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                disableAutomaticTypeAcquisition = true,
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            },
          })
        end,

        -- Tailwind CSS LSP
        ["tailwindcss"] = function()
          lspconfig["tailwindcss"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function(fname)
              return lspconfig.util.root_pattern(
                "tailwind.config.js",
                "tailwind.config.ts",
                "postcss.config.js",
                "postcss.config.ts",
                "package.json",
                ".git"
              )(fname) or vim.fn.getcwd()
            end,
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    { "tw`([^`]*)", 1 },
                    { 'tw="([^"]*)"', 1 },
                    { 'tw={"([^"}]*)"}', 1 },
                    { "tw\\.\\w+`([^`]*)", 1 },
                  },
                },
              },
            },
            filetypes = {
              "html",
              "css",
              "scss",
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
                telemetry = {
                  enable = false,
                },
              },
            },
            on_init = function(client)
              local join = vim.fs.joinpath
              local path = client.workspace_folders[1].name

              -- Don't do anything if there is project local config
              ---@diagnostic disable-next-line: undefined-field
              if vim.uv.fs_stat(join(path, ".luarc.json")) or vim.uv.fs_stat(join(path, ".luarc.jsonc")) then
                return
              end

              -- Apply neovim specific settings
              local runtime_path = vim.split(package.path, ";")
              table.insert(runtime_path, join("lua", "?.lua"))
              table.insert(runtime_path, join("lua", "?", "init.lua"))

              local nvim_settings = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  version = "LuaJIT",
                  path = runtime_path,
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    -- Make the server aware of Neovim runtime files
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath("config"),
                  },
                },
              }

              client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, nvim_settings)
            end,
          })
        end,
      },
      ensure_installed = {
        "html",
        "ts_ls",
        "volar",
        "cssls",
        "jsonls",
        "lua_ls",
        "typos_lsp",
        "tailwindcss",
        "css_variables",
        "emmet_language_server",

        -- "rzls",
        -- "roslynv4",
        -- "omnisharp",
        -- "somesass_ls",
        -- "jdtls",
        -- "sqlls",
        -- "clangd",
      },
    })
  end,
}
