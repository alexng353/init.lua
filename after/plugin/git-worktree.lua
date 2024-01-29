require("telescope").load_extension("git_worktree")

local map = vim.keymap.set

map('n', '<leader>gwc', require("telescope").extensions.git_worktree.create_git_worktree, { noremap = true , desc = "Create git worktree" })
