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
      os.execute("fcitx5-remote -c")
    end
  end,
})
