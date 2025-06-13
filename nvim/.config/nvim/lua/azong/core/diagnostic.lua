local diagnostic = vim.diagnostic
local severity = diagnostic.severity
local _border = "rounded"

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
  float = { border = _border },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local function lsp_floating_handler(result, config, focusable)
      if not (result and result.contents) then
        return
      end
      return vim.lsp.util.open_floating_preview(
        result.contents,
        "markdown",
        vim.tbl_extend("force", config or {}, { border = _border, focusable = focusable })
      )
    end

    client.handlers["textDocument/hover"] = function(_, result, _, config)
      return lsp_floating_handler(result, config, true)
    end

    client.handlers["textDocument/signatureHelp"] = function(_, result, _, config)
      return lsp_floating_handler(result and result.signatures and result.signatures[1], config, false)
    end
  end,
})
