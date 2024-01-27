vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)', { silent = true, desc = 'Leap forward' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', '<Plug>(leap-backward)', { silent = true, desc = 'Leap backward' })
vim.keymap.set({ 'n', 'x', 'o' }, 'gls', '<Plug>(leap-from-window)',
  { silent = true, desc = 'Leap from window (global leap)' })
