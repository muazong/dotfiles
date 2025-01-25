return {
  "b0o/incline.nvim",
  keys = { { "<Leader>ss", "<Cmd> split<CR>" }, { "<Leader>sv", "<Cmd> vsplit<CR>" } },
  dependencies = { "nvim-web-devicons", "rebelot/kanagawa.nvim" },
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    local kanaColors = require("kanagawa.colors").setup()
    local palette = kanaColors.palette

    require("incline").setup({
      highlight = {
        groups = {
          InclineNormal = { guibg = palette.winterBlue, guifg = palette.roninYellow },
          InclineNormalNC = { guifg = palette.katanaGray, guibg = palette.winterBlue },
        },
      },
      window = { margin = { vertical = 0, horizontal = 1 }, zindex = 24 },
      hide = {
        cursorline = true,
        focused_win = false,
        only_win = true,
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

        if vim.bo[props.buf].modified then
          filename = "● " .. filename
        elseif filename == "" then
          filename = "[No Name]"
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          guibg = "#44406e",
        }
      end,
    })
  end,
}
