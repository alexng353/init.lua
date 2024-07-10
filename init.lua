vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

require("alexng353")

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
})

vim.cmd.colorscheme "catppuccin-macchiato"

-- Line Number Highlighting
vim.o.cursorlineopt = "number"
vim.o.cursorline = true

vim.cmd('highlight LineNr guifg=#FFD700')
vim.cmd('highlight CursorLineNr guifg=#00FFFF')
