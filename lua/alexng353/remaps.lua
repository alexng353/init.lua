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

-- LSP
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format()
  print("formatted buffer")
end)

