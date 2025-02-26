_G.dd = function(...)
  require("azong.utils.debug").dump(...)
end
vim.print = _G.dd

require("azong.utils.keyboard")
