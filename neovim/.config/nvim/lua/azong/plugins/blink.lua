vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("^1"),
  },
})

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  group = group,
  once = true,
  callback = function()
    require("blink.cmp").setup({
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "supermaven", "buffer", "snippets" },
        providers = {
          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            async = true,
            timeout_ms = 500,
            max_items = 20,
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
          supermaven = {
            name = "supermaven",
            module = "blink-cmp-supermaven",
            async = true,
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
          snippets = {
            name = "snippets",
            max_items = 5,
          },
        },
      },
      keymap = {
        preset = "none",
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

        ["<Tab>"] = { "select_next", "fallback_to_mappings" },
        ["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

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
        ghost_text = { enabled = true },
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
            columns = { { "label", "label_description", gap = 1 } },
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
    })
  end,
})
