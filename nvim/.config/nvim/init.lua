if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("azong.utils.debug").dump(...)
end
vim.print = _G.dd

require("azong.core")
require("azong.utils")
require("azong.lazy")
