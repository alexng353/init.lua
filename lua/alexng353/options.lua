-- 80 column line
vim.cmd('autocmd VimEnter * silent! set colorcolumn=80')
vim.cmd('autocmd VimEnter * silent! hi ColorColumn ctermbg=#242424 guibg=#242424')

vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.api.nvim_set_option("ignorecase", true)
vim.api.nvim_set_option("smartcase", true)
vim.api.nvim_set_option("incsearch", true)

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd('filetype plugin indent on')
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.mouse = ''

-- UFO stuff
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true


-- Line Number Highlighting
vim.cmd('highlight LineNr guifg=#FFD700')
vim.cmd('highlight CursorLineNr guifg=#00FFFF')

vim.o.cursorlineopt = "number"
vim.o.cursorline = true
