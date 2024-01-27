vim.g.mapleader = " "

require("alexng353")

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data") .. "/lazy-alex",
  lockfile = vim.fn.stdpath("config") .. "/lazy-alex-lock.json", -- lockfile generated after running update.
})

-- Load custom vimscript user config
vim.cmd('autocmd VimEnter * silent! source ~/.nvimrc')
vim.cmd('autocmd VimEnter * silent! set colorcolumn=80')
vim.cmd('autocmd VimEnter * silent! hi ColorColumn ctermbg=#242424 guibg=#242424')

vim.api.nvim_set_option("clipboard", "unnamed")
vim.api.nvim_set_option("ignorecase", true)
vim.api.nvim_set_option("smartcase", true)
vim.api.nvim_set_option("incsearch", true)


vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.colorscheme "catppuccin-macchiato"
