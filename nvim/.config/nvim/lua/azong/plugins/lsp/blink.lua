return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo build --release",
  -- version = "*",
  dependencies = {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
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
        menu = {
          auto_show = true,
        },
        ghost_text = { enabled = true },
      },
      keymap = {
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "select_next", "show" },
        ["<S-Tab>"] = { "select_prev" },
      },
    },
    completion = {
      trigger = { show_on_trigger_character = false },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "kind_icon", "label_description", "label", gap = 1 },
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
      ghost_text = { enabled = true },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
  },
  opts_extend = { "sources.default" },
}
