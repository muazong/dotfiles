vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config"),
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
