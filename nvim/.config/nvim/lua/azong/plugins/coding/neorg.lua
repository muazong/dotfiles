return {
  { -- Neorg
    "nvim-neorg/neorg",
    cmd = "Neorg",
    version = "*",
    config = function()
      vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)")

      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Workspace/Notes",
              },
              index = "index.norg",
            },
          },
        },
        open_last_workspace = true,
      })
    end,
  },
  { -- Neorg dependencies
    { "pysan3/pathlib.nvim", lazy = true },
    { "nvim-neotest/nvim-nio", lazy = true },
    { "nvim-neorg/lua-utils.nvim", lazy = true },
    dependencies = "nvim-neorg/neorg",
  },
}
