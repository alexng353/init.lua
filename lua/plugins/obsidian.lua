return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "Obsidian Vault",
        path = "~/Documents/Obsidian Vault",
      },
    },
  },
}
