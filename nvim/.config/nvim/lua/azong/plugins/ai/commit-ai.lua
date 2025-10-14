return {
  "Abizrh/commit-ai.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("commit-ai").setup({
      icons = false,
      language = "en", -- default language
      -- unopiniated commit conventions
      git_conventions = {
        docs = { icon = "", prefix = "docs", type = "Documentation changes" },
        fix = { icon = "", prefix = "fix", type = "Bug fix" },
        feat = { icon = "", prefix = "feat", type = "New feature" },
        enhance = { icon = "", prefix = "enhance", type = "Enhancement" },
        chore = { icon = "", prefix = "chore", type = "Chore" },
        refactor = { icon = "", prefix = "refactor", type = "Breaking change" },
      },
      provider_options = {
        gemini = {
          model = "gemini-2.0-flash",
          api_key = vim.env.GEMINI_API_KEY, -- assuming you have set GEMINI_API_KEY in .zshrc or .bashrc
          stream = false,
        },
      },
    })
  end,
}
