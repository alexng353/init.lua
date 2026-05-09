-- 80 column line
vim.cmd('autocmd VimEnter * silent! set colorcolumn=80')
vim.cmd('autocmd VimEnter * silent! hi ColorColumn ctermbg=#242424 guibg=#242424')
-- vim.cmd('autocmd VimEnter * silent! hi ColorColumn ctermbg=#ffffff guibg=#ffffff')

vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd('filetype plugin indent on')
vim.filetype.add({ extension = { rts = "typescript" } })
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.mouse = ''

vim.opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- UFO stuff
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.termguicolors = true
vim.opt.shell = "/bin/zsh"

vim.o.wrap = false

vim.opt.termguicolors = true

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = vim.fn.expand("~") .. "/Documents/Obsidian Vault/**",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})
