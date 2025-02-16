local diagnostic = vim.diagnostic
local severity = diagnostic.severity

local ERROR = severity.ERROR
local WARN = severity.WARN
local INFO = severity.INFO
local HINT = severity.HINT

local diagnosticSigns = {
  Icons = {
    [ERROR] = "",
    [WARN] = "",
    [INFO] = "",
    [HINT] = "󱩎",
  },
  Msgs = {
    [ERROR] = "ErrorMsg",
    [WARN] = "WarningMsg",
    [INFO] = "InfoMsg",
    [HINT] = "HintMsg",
  },
}

diagnostic.config({
  signs = {
    text = diagnosticSigns.Icons,
    texthl = diagnosticSigns.Msgs,
    -- linehl = diagnosticSigns.Msgs,
    numhl = diagnosticSigns.Msgs,
  },
  -- virtual_text = {
  --   prefix = "", -- 󰄛 | 󰩃 | ● | 󰝤
  --   spacing = 4,
  -- },
  virtual_text = false,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
})
