vim.g.mapleader = " "

require("alexng353")
--local treesitter = require "plugins/treesitter"
--local leap = require "plugins/leap"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  { 
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",

  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  "nvim-lua/plenary.nvim",
  "ThePrimeagen/harpoon",
  -- leap,
  -- treesitter,
}, {
  root = vim.fn.stdpath("data") .. "/lazy-alex",
  lockfile = vim.fn.stdpath("config") .. "/lazy-alex-lock.json", -- lockfile generated after running update.
})


-- Load custom vimscript user config
vim.cmd('autocmd VimEnter * silent! source ~/.nvimrc')
vim.cmd('autocmd VimEnter * silent! set colorcolumn=80')
vim.cmd('autocmd VimEnter * silent! hi ColorColumn ctermbg=#242424 guibg=#242424')


vim.api.nvim_set_option("clipboard","unnamed")


vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.colorscheme "catppuccin-macchiato"

-- Harpoon stuff
-- sk("n", "", "", { noremap = true, silent = true })
