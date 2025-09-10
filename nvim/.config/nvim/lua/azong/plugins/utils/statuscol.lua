return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    local statuscol = require("statuscol.builtin")

    return {
      segments = {
        { sign = { namespace = { "diagnostic*" }, colwidth = 2 } },
        { sign = { namespace = { "gitsign*" } } },
        { text = { statuscol.lnumfunc, " " } },
        { text = { statuscol.foldfunc, " " } },
      },
    }
  end,
}
