return {
  "luukvbaal/statuscol.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    local statuscol = require("statuscol.builtin")

    return {
      segments = {
        { sign = { namespace = { "gitsign*" } } },
        { sign = { namespace = { "diagnostic*" }, colwidth = 2 } },
        { sign = { name = { "Bookmark" } } },
        { text = { statuscol.lnumfunc, " " } },
        { text = { statuscol.foldfunc, " " } },
      },
    }
  end,
}
