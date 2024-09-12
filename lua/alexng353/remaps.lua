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
vim.keymap.set('n', "<leader>bc", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local next_buf = vim.fn.bufnr('#')

  -- If there's no alternate buffer, create a new empty one
  if next_buf == -1 then
    vim.cmd('enew')
  else
    vim.cmd('buffer ' .. next_buf)
  end

  -- Now delete the original buffer
  vim.api.nvim_buf_delete(current_buf, {})
end, { noremap = true, silent = true })
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
SurroundSelection = function(start_char, end_char)
  -- Get the current visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the lines in the visual selection
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- If the selection is on a single line, adjust the start and end columns
  if #lines == 1 then
    lines[1] = lines[1]:sub(1, start_pos[3] - 1) ..
    start_char .. lines[1]:sub(start_pos[3], end_pos[3]) .. end_char .. lines[1]:sub(end_pos[3] + 1)
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


-- Insert lorem ipsum
local lipsum =
"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
vim.keymap.set('n', "<leader>il", function()
  vim.api.nvim_put({ lipsum }, "c", true, true)
end, { noremap = true, silent = true })


-- snippets

local ls = require("luasnip")

vim.keymap.set({"i"}, "<D-[>", function()
  ls.expand()
  print("expanded")
end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- vim.cmd([[
--   autocmd InsertCharPre * lua AutoExpandSnippet()
-- ]])
--
-- vim.api.nvim_create_autocmd("", {
--
-- function AutoExpandSnippet()
--   print("expanding")
--   local luasnip = require('luasnip')
--   local line = vim.api.nvim_get_current_line()
--   local col = vim.fn.col('.') - 1
--
--   -- Check if 'sk' is at the cursor position
--   if string.sub(line, col - 1, col) == "sk" then
--     -- Expand the snippet
--     luasnip.expand()
--   end
-- end

-- Autocommand to auto-expand snippets when a match is found
vim.api.nvim_create_autocmd("TextChangedI", {
  pattern = "*", -- Apply to all filetypes, you can change this to specific filetypes
  callback = function()
    local luasnip = require("luasnip")
    -- if luasnip.expand_or_jumpable() then
    --   luasnip.expand_or_jump() -- Automatically expand the snippet
    -- end
    if luasnip.expandable() then
      luasnip.expand()
    end
  end,
})

-- local luasnip = require("luasnip")
-- vim.keymap.set('i', "<Tab>",
--   function()
--     print("tab")
--     if luasnip.expand_or_jumpable() then
--       luasnip.expand_or_jump()
--     end
--   end,
-- { silent = true }
-- )
