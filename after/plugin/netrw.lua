vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'a', '%', { noremap = true, silent = true })
    end,
})
