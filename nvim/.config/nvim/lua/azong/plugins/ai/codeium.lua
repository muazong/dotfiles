return {
  "Exafunction/codeium.nvim",
  enabled = false,
  cmd = "Codeium",
  event = "InsertEnter",
  build = ":Codeium Auth",
  opts = {
    enable_cmp_source = true,
    virtual_text = {
      enabled = false,
      key_bindings = { accept = false },
    },
  },
}
