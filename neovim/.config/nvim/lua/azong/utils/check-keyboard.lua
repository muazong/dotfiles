local is_vi = false

local function get_layout()
  local handle = io.popen("fcitx5-remote -n")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result then
      return result:gsub("%s+", "")
    end
  end
  return ""
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TermLeave" }, {
  pattern = "*",
  callback = function()
    local layout = get_layout()
    if layout == "unikey" then
      is_vi = true
      os.execute("fcitx5-remote -c")
    else
      is_vi = false
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "TermEnter" }, {
  pattern = "*",
  callback = function()
    if is_vi then
      os.execute("fcitx5-remote -o")
    end
  end,
})
