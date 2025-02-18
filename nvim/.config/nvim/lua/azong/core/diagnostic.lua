local diagnostic = vim.diagnostic
local severity = diagnostic.severity
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.diagnostic.config({
  float = { border = _border },
})

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
  virtual_text = {
    prefix = " ", -- 󰄛 | 󰩃 | ● | 󰝤
    spacing = 4,
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
