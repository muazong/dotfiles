return {
  "nvim-lualine/lualine.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "rebelot/kanagawa.nvim",
  },
  config = function()
    local kanaColors = require("kanagawa.colors").setup()
    local palette = kanaColors.palette

    local function kanagawa()
      local common = {
        c = { bg = palette.winterBlue, fg = palette.oldWhite, gui = "bold" },
        b = { bg = palette.sumiInk1, fg = palette.fujiWhite, gui = "italic" },
      }
      local modes = {
        normal = { a = { bg = palette.oldWhite, fg = palette.sumiInk2, gui = "boldItalic" } },
        insert = { a = { bg = palette.springGreen, fg = palette.sumiInk2, gui = "boldItalic" } },
        visual = { a = { bg = palette.peachRed, fg = palette.winterBlue, gui = "boldItalic" } },
        replace = { a = { bg = palette.springBlue, fg = palette.winterBlue, gui = "boldItalic" } },
        command = { a = { bg = palette.autumnYellow, fg = palette.winterBlue, gui = "boldItalic" } },
        inactive = { a = { bg = palette.waveAqua1, fg = palette.winterBlue, gui = "boldItalic" } },
      }

      for _, properties in pairs(modes) do
        properties.b = common.b
        properties.c = common.c
      end

      return modes
    end

    function string.split(str, delim)
      local result = {}
      local from = 1
      local delim_len = #delim

      while true do
        local start, finish = string.find(str, delim, from)
        if start == nil then
          table.insert(result, string.sub(str, from))
          break
        end
        table.insert(result, string.sub(str, from, start - 1))
        from = finish + delim_len
      end

      return result
    end

    local function activeLsp()
      local msg = ""
      local clients = vim.lsp.get_clients()

      for _, client in ipairs(clients) do
        if client.name ~= "typos_lsp" and client.attached_buffers[vim.api.nvim_get_current_buf()] then
          local name_parts = string.split(client.name, "_")
          if msg ~= "" then
            msg = msg .. ", "
          end
          msg = msg .. name_parts[1]
        end
      end

      if msg == "" then
        msg = "No Active Lsp"
      end

      return msg
    end
    require("lualine").setup({
      options = {
        theme = kanagawa,
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 50,
          tabline = 50,
          winbar = 50,
        },
        disabled_filetypes = { statusline = { "alpha" } },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "" },
            padding = 2,
          },
        },
        lualine_b = {
          { "branch", icon = "" },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { activeLsp, icon = "LSP:" },
        },
        lualine_c = {
          {
            "filename",
            path = 4,
            file_status = true,
            newfile_status = true,
            symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]", newfile = "[New]" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󱩎 " },
            always_visible = false,
            update_in_insert = true,
          },
        },
        lualine_y = {
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          "progress",
        },
        lualine_z = {
          {
            "location",
            separator = { left = "", right = "" },
            padding = 1,
          },
        },
      },
      extensions = {
        "lazy",
        "mason",
        "trouble",
        "toggleterm",
      },
    })
  end,
}
