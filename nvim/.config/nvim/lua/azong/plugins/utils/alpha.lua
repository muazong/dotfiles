return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "   █████╗ ███████╗ ██████╗ ███╗   ██╗ ██████╗   ",
      "  ██╔══██╗╚══███╔╝██╔═══██╗████╗  ██║██╔════╝   ",
      "  ███████║  ███╔╝ ██║   ██║██╔██╗ ██║██║  ███╗  ",
      "  ██╔══██║ ███╔╝  ██║   ██║██║╚██╗██║██║   ██║  ",
      "  ██║  ██║███████╗╚██████╔╝██║ ╚████║╚██████╔╝  ",
      "  ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("n", " 󱦰 New File", "<cmd>ene<CR>"),
      dashboard.button("b", " 󱦰 File Browser", "<cmd>Telescope file_browser<CR>"),
      dashboard.button("f", "󰱼 󱦰 Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("o", " 󱦰 Notes", "<cmd>Neorg workspace notes<CR>"),
      dashboard.button("l", "󰒲 󱦰 Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("m", " 󱦰 Mason", "<cmd>Mason<CR>"),
      dashboard.button("c", " 󱦰 LeetCode", "<cmd>Leet<CR>"),
      dashboard.button("s", " 󱦰 Configuration", "<cmd>cd ~/.config/nvim<CR><cmd>e init.lua<CR>"),
      dashboard.button("q", " 󱦰 Quit", "<cmd>qa<CR>"),
    }

    -- Set footer
    local handle = io.popen("nvim --version")
    if handle then
      local nvim_version = handle:read("*a"):match("NVIM v(%S+)")
      handle:close()
      dashboard.section.footer.val = { " v" .. nvim_version }
    else
      print("Failed to open handle")
    end
    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
