vim.g.mapleader = " "

require("alexng353")

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy",
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
})

vim.cmd.colorscheme "catppuccin-macchiato"

