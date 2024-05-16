-- Leader
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<Cr>:echo 'wrote to file'<Cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qq", ":x<Cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { noremap = true, silent = true });

-- "Greatest keymap ever"
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Movement
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("i", "<C-c>", "<Esc>")

-- Terminal
vim.keymap.set("t", "<Esc><C-N>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-space>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Select a whole block and indent it
vim.keymap.set('v', '<Tab>', ':normal I<Tab><Cr>', { noremap = true })

-- Dev
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
  print("reloaded current file")
end)

-- Buffer
vim.keymap.set('n', "[b", ":bprevious<CR>", { noremap = true })
vim.keymap.set('n', "]b", ":bnext<CR>", { noremap = true })
vim.keymap.set('n', "<leader>bc", function() vim.api.nvim_buf_delete(0, {}) end, { noremap = true })
vim.keymap.set('n', "<leader>bC", function() vim.api.nvim_buf_delete(0, { force = true }) end, { noremap = true })


-- Tab
vim.keymap.set('n', "[t", ":tabprevious<CR>", { noremap = true, desc = "Go to previous tab" })
vim.keymap.set('n', "]t", ":tabnext<CR>", { noremap = true, desc = "Go to next tab" })
vim.keymap.set('n', "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close tab" })
vim.keymap.set('n', "<leader>tC", ":tabonly<CR>", { noremap = true, desc = "Close all tabs except current" })
vim.keymap.set('n', "<leader>tn", ":tabnew<CR>", { noremap = true, desc = "New tab" })

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({
      timeout = 50
    })
  end,
  group = highlight_group,
  pattern = '*',
})
