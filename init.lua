vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

require("alexng353")

-- require("lazy").setup("plugins", {
--   root = vim.fn.stdpath("data") .. "/lazy",
--   lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
-- })

vim.cmd.colorscheme "tokyonight-night"
-- vim.cmd.colorscheme "catppuccin-macchiato"
-- make the background transparent
-- vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')

-- Line Number Highlighting
vim.o.cursorlineopt = "number"
vim.o.cursorline = true

vim.cmd('highlight LineNr guifg=#FFD700')
vim.cmd('highlight CursorLineNr guifg=#00FFFF')

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")
  end
})
