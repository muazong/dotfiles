local trigger_text = ";"

return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    enabled = function()
      return not vim.tbl_contains({}, vim.bo.filetype)
        and vim.bo.buftype ~= "nofile"
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    sources = {
      default = {
        "lsp",
        "snippets",
        "path",
        "buffer",
        -- "codeium",
        -- "copilot",
      },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          score_offset = 90,
          min_keyword_length = 2,
          async = true,
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 25,
          fallbacks = { "snippets", "buffer", "lsp" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          enabled = true,
          max_items = 3,
          module = "blink.cmp.sources.buffer",
          score_offset = 15,
        },
        --[[ copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        }, ]]
        --[[ codeium = {
          name = "codeium",
          module = "blink.compat.source",
          score_offset = 10,
          async = true,
        }, ]]
      },
    },
    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<S-CR>"] = { "hide" }, -- `hide` keeps `auto_insert`, `cancel` does not
      ["<C-Space>"] = { "show" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },
    cmdline = {
      keymap = {
        ["<CR>"] = { "fallback" }, -- CR = execute (no need for accept since using `auto_insert`)
        ["<Tab>"] = { "select_next", "show" },
        ["<S-Tab>"] = { "select_prev" },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
    },
    completion = {
      trigger = {
        show_in_snippet = false, -- since we overload `<Tab>` with jumping & selection
      },
      list = {
        cycle = { from_top = false }, -- cycle at bottom, but not at the top
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        window = {
          scrollbar = false,
          border = "rounded",
          max_width = 50,
          max_height = 20,
        },
      },
      menu = {
        border = vim.g.borderStyle,
        draw = {
          align_to = "none", -- keep in place
          treesitter = { "lsp" },
          columns = {
            { "kind_icon", "label_description", "label", gap = 1 },
          },
          components = {
            label = { width = { max = 35 } },
            label_description = { width = { max = 20 } },
            kind_icon = {
              text = function(ctx)
                -- detect emmet-ls
                local source, client = ctx.item.source_id, ctx.item.client_id
                local lspName = client and vim.lsp.get_client_by_id(client).name
                if lspName == "emmet_language_server" then
                  source = "emmet"
                end

                -- use source-specific icons, and `kind_icon` only for items from LSPs
                local sourceIcons = {
                  snippets = "󰩫",
                  buffer = "󰦨",
                  emmet = "",
                  path = "",
                  cmdline = "󰘳",
                  codeium = "",
                }
                return sourceIcons[source] or ctx.kind_icon
              end,
            },
          },
        },
      },
      ghost_text = { enabled = true },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "normal",
      kind_icons = {
        -- different icons of the corresponding source
        Text = "󰉿", -- `buffer`
        Snippet = "󰞘", -- `snippets`
        File = "", -- `path`
        Copilot = "", -- `copilot`,

        Folder = "󰉋",
        Method = "󰊕",
        Function = "󰡱",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰀫",
        Class = "󰜁",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Color = "󰏘",
        Reference = "",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      },
    },
  },
  dependencies = {
    "rafamadriz/friendly-snippets",
    { "fang2hou/blink-copilot", enabled = false },
    { "saghen/blink.compat", enabled = false, opts = { enable_events = true } },
  },
}
