return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo build --release",
  dependencies = {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      require("luasnip").setup({
        history = true,
        delete_check_events = "TextChanged",
      })
    end,
  },
  opts = {
    enabled = function()
      return not vim.tbl_contains({}, vim.bo.filetype)
        and vim.bo.buftype ~= "nofile"
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "buffer", "snippets" },
      providers = {
        snippets = {
          name = "snippets",
          max_items = 5,
        },
        lsp = {
          name = "lsp",
          module = "blink.cmp.sources.lsp",
          async = true,
          timeout_ms = 500,
          max_items = 10,
        },
        buffer = {
          name = "buffer",
          max_items = 10,
          opts = {
            get_bufnrs = function()
              return vim.tbl_filter(function(bufnr)
                return vim.bo[bufnr].buftype == ""
              end, vim.api.nvim_list_bufs())
            end,
          },
        },
        path = {
          name = "path",
          max_items = 5,
          opts = {
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
      },
    },
    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },

      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    },
    cmdline = {
      completion = {
        ghost_text = { enabled = true },
        menu = {
          auto_show = true,
        },
      },
      keymap = {
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "select_next", "show" },
        ["<S-Tab>"] = { "select_prev" },
      },
    },
    completion = {
      ghost_text = { enabled = false },
      keyword = { range = "prefix" },
      trigger = {
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = true,
        show_on_accept_on_trigger_character = true,
        show_on_blocked_trigger_characters = { " ", "\n", "\t" },
        show_on_x_blocked_trigger_characters = { "'", '"', "(", "{", "[" },
      },
      menu = {
        auto_show = true,
        draw = {
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              width = { fill = true, max = 60 },
              text = function(ctx)
                local highlights_info = require("colorful-menu").blink_highlights(ctx)
                if highlights_info ~= nil then
                  return highlights_info.label
                else
                  return ctx.label
                end
              end,
              highlight = function(ctx)
                local highlights = {}
                local highlights_info = require("colorful-menu").blink_highlights(ctx)
                if highlights_info ~= nil then
                  highlights = highlights_info.highlights
                end
                for _, idx in ipairs(ctx.label_matched_indices) do
                  table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                end
                return highlights
              end,
            },
            kind_icon = {
              text = function(ctx)
                local source, client = ctx.item.source_id, ctx.item.client_id
                local lspName = client and vim.lsp.get_client_by_id(client).name
                if lspName == "emmet_language_server" then
                  source = "emmet"
                end

                local sourceIcons = {
                  snippets = "󰩫",
                  buffer = "󰦨",
                  emmet = "",
                  path = "",
                  cmdline = "󰘳",
                }
                return sourceIcons[source] or ctx.kind_icon
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
        window = {
          scrollbar = false,
          border = "rounded",
          max_width = 50,
          max_height = 20,
        },
      },
    },
    appearance = {
      nerd_font_variant = "mono",
      kind_icons = {
        -- different icons of the corresponding source
        Text = "󰉿", -- `buffer`
        Snippet = "󰞘", -- `snippets`
        File = "", -- `path`

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
}
