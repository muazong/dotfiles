return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "json" },
      callback = function()
        vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
      end,
    })

    vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>")

    require("rest-nvim").setup({
      result_split_horizontal = false,
      result_split_in_place = false,
      stay_in_current_window_after_split = false,
      skip_ssl_verification = false,
      encode_url = true,
      highlight = {
        enabled = true,
        timeout = 150,
      },
      result = {
        show_url = true,
        show_curl_command = true,
        show_http_info = true,
        show_headers = true,
        show_statistics = true,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
          end,
        },
      },
      jump_to_request = false,
      env_file = ".env",
      custom_dynamic_variables = {},
      yank_dry_run = true,
      search_back = true,
    })
  end,
}
