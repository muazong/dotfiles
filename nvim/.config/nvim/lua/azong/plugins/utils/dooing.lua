return {
  {
    "atiladefreitas/dooing",
    cmd = "Dooing",
    keys = { { "<leader>dd", "<cmd>Dooing<cr>" } },
    config = function()
      require("dooing").setup({
        window = {
          width = 55,
          height = 20,
          border = "rounded",
          position = "top",
          padding = {
            top = 1,
            bottom = 1,
            left = 2,
            right = 2,
          },
        },
      })
    end,
  },
}
