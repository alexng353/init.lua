-- Leader
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<Cr>:echo 'wrote to file'<Cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qq", ":q<Cr>", { noremap = true, silent = true })
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

-- Harpoon Keymaps

vim.keymap.set("t", "<Esc><C-n>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.keymap.set('v', '<Tab>', ':normal I<Tab><CR>', { noremap = true })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

