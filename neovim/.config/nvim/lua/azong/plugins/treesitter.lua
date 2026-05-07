vim.pack.add({
  "https://github.com/neovim-treesitter/nvim-treesitter",
  "https://github.com/neovim-treesitter/treesitter-parser-registry",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "tsx",
    "jsx",
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "lua",
    "vim",
    "json",
  },
  callback = function()
    vim.treesitter.start() -- highlighting
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- folds
    vim.wo.foldmethod = "expr"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
  end,
})

require("nvim-treesitter").install({
  "javascript",
  "typescript",
  "tsx",
  "jsx",
  "lua",
  "vim",
  "json",
  "ecma",
  "jsdoc",
  "luadoc",
  "vimdoc",
})
