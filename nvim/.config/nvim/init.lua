if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("azong.util.debug").dump(...)
end
vim.print = _G.dd

require("azong.core")
require("azong.util")
require("azong.lazy")
