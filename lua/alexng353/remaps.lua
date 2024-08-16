-- Leader
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<Cr>:echo 'wrote to file'<Cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qq", ":x<Cr>", { noremap = true, silent = true })

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
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true })

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

-- Function to surround visual selection with brackets or quotes
SurroundSelection = function (start_char, end_char)
  -- Get the current visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the lines in the visual selection
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- If the selection is on a single line, adjust the start and end columns
  if #lines == 1 then
    lines[1] = lines[1]:sub(1, start_pos[3] - 1) .. start_char .. lines[1]:sub(start_pos[3], end_pos[3]) .. end_char .. lines[1]:sub(end_pos[3] + 1)
  else
    -- For multi-line selection, add start_char and end_char to the first and last lines
    lines[1] = lines[1]:sub(1, start_pos[3] - 1) .. start_char .. lines[1]:sub(start_pos[3])
    lines[#lines] = lines[#lines]:sub(1, end_pos[3]) .. end_char .. lines[#lines]:sub(end_pos[3] + 1)
  end

  -- Set the modified lines back to the buffer
  vim.fn.setline(start_pos[2], lines)

  -- Exit visual mode
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
end

-- Key mappings for visual mode
vim.api.nvim_set_keymap('v', '<leader>[', ':lua SurroundSelection("[", "]")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>\'', ':lua SurroundSelection("\'", "\'")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>"', ':lua SurroundSelection("\\\"", "\\\"")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>(', ':lua SurroundSelection("(", ")")<CR>', { noremap = true, silent = true })

