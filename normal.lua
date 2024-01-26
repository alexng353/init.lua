vim.g.mapleader = " "

require("alexng353")
local treesitter = require "plugins/treesitter"
local leap = require "plugins/leap"

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
  {
    "KadoBOT/nvim-spotify",
    opts = {
      status = {
        update_interval = 10000,
        format = '%s %t by %a'
      },
    },
    build = "make"
  },
  {
    "andweeb/presence.nvim",
    lazy = false,
  },
  {
    "wakatime/vim-wakatime",
    event = "User AstroFile",
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "right", -- bottom | top | left | right
          ratio = 0.3,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      copilot_node_command = "node", -- Node.js version must be > 18.x
      server_opts_overrides = {},
    },
  },
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  leap,
  treesitter,
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
