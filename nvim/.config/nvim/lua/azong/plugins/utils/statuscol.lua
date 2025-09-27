return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    local statuscol = require("statuscol.builtin")

    return {
      segments = {
        { sign = { namespace = { "gitsign*" }, auto = true, colwidth = 2 } },
        { sign = { namespace = { "diagnostic*" }, auto = true, colwidth = 2 } },
        { sign = { name = { "Dap*" }, auto = true, colwidth = 2 } },
        { sign = { name = { "Bookmark" }, auto = true, colwidth = 2 } },
        { text = { statuscol.lnumfunc, " " } },
        { text = { statuscol.foldfunc, " " } },
      },
    }
  end,
}
