-- Native Neovim commenting (0.10+). Uses `commentstring`, so it works in every
-- filetype regardless of whether a treesitter parser is installed.
-- `gcc` honors a count (e.g. 3<leader>/ comments 3 lines); `gc` is the operator.
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, silent = true, desc = 'Toggle comment line' })
vim.keymap.set('x', '<leader>/', 'gc', { remap = true, silent = true, desc = 'Toggle comment selection' })
