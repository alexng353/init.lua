vim.keymap.set('n', '<leader>/', function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, { noremap = true, silent = true })
vim.keymap.set('v', '<leader>/', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>', { noremap = true, silent = true })
