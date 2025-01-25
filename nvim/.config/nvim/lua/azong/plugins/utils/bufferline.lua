return {
  "akinsho/bufferline.nvim",
  keys = { { "te", "<Cmd> tabnew<CR>" } },
  config = function()
    local opts = { silent = true, noremap = true }
    vim.keymap.set("n", "<C-n>", "<Cmd> BufferLineCycleNext<CR>", opts)
    vim.keymap.set("n", "<C-p>", "<Cmd> BufferLineCyclePrev<CR>", opts)

    require("bufferline").setup({
      options = {
        mode = "tabs",
        sort_by = "id",
        separator_style = "slant",
        show_close_icon = false,
        show_tab_indicators = false,
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        diagnostics = "nvim_lsp",
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          if context.buffer:current() then
            local result = " "
            for diagnostic, total in pairs(diagnostics_dict) do
              local symbol

              if diagnostic == "error" then
                symbol = ""
              elseif diagnostic == "warning" then
                symbol = ""
              elseif diagnostic == "info" then
                symbol = ""
              elseif diagnostic == "hint" then
                symbol = "󱩎"
              end

              result = result .. symbol .. "󰿟" .. total .. " "
            end
            return result
          end
          return ""
        end,
      },
      highlights = {
        buffer_selected = {
          gui = "italic",
          bold = true,
          fg = "#FF9E3B",
        },
      },
    })
  end,
}
