return {
  "sontungexpt/stcursorword",
  event = "BufEnter",
  config = function()
    require("stcursorword").setup({
      highlight = {
        underline = true,
        fg = nil,
        bg = nil,
      },
    })

    -- Function to safely execute Cursorword commands without errors
    local function cursorword_safe_cmd(cmd)
      local ok, _ = pcall(function()
        vim.cmd(cmd)
      end)
      if not ok then
        return
      end
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        cursorword_safe_cmd("Cursorword enable")
      end,
    })

    -- Disable cursor word highlight when entering Insert mode
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "*:i",
      callback = function()
        cursorword_safe_cmd("Cursorword disable")
      end,
    })

    -- Re-enable cursor word highlight when returning to Normal mode
    vim.api.nvim_create_autocmd("ModeChanged", {
      pattern = "i:n",
      callback = function()
        cursorword_safe_cmd("Cursorword enable")
      end,
    })
  end,
}
