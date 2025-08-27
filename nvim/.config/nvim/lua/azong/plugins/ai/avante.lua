return {
  "yetone/avante.nvim",
  build = "make",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    provider = "gemini",
    providers = {
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash-lite",
        timeout = 30000,
        context_window = 1048576,
        use_ReAct_prompt = true,
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
    },
    behaviour = {
      auto_set_keymaps = false,
    },
    selection = {
      enabled = false,
    },
  },
}
