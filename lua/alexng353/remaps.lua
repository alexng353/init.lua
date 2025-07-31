-- This file definitely needs to be split up
-- Leader
vim.keymap.set("n", "<Leader>pv", vim.cmd.Ex, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<Cr>:echo 'wrote to file'<Cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qq", function()
  -- Save all writable and modified buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modifiable") and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
      vim.api.nvim_command("silent! write")
    end
  end
  -- Quit all
  vim.cmd("qa")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>qu", function()
  -- Save all writable and modified buffers
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "modifiable") and vim.api.nvim_buf_get_option(buf, "buftype") == "" then
      vim.api.nvim_command("silent! write")
    end
  end
  -- Quit all
  vim.cmd("qa")
end, { noremap = true, silent = true })

-- "Greatest keymap ever"
vim.keymap.set("x", "<leader>P", [["_dP]])

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
-- buf deleete
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
local function SurroundSelection(start_char, end_char)
  local api = vim.api

  -- Yank the current selection into register "x"
  vim.cmd('normal! "xy')
  local selected_text = vim.fn.getreg('x')

  -- Get the current line
  local line = api.nvim_get_current_line()

  -- Create the new surrounded text
  local new_text = start_char .. selected_text .. end_char

  -- Replace the selected text with the new one in the line
  local new_line = line:gsub(vim.pesc(selected_text), new_text, 1)

  -- Set the modified line
  api.nvim_set_current_line(new_line)
end

-- Key mappings for visual mode

vim.keymap.set('v', '[', function() SurroundSelection("[", "]") end, { noremap = true, silent = true })
vim.keymap.set('v', '\'', function() SurroundSelection("\'", "\'") end, { noremap = true, silent = true })
vim.keymap.set('v', '"', function() SurroundSelection("\"", "\"") end, { noremap = true, silent = true })
vim.keymap.set('v', '(', function() SurroundSelection("(", ")") end, { noremap = true, silent = true })
vim.keymap.set('v', '<leader>{', function() SurroundSelection("{", "}") end, { noremap = true, silent = true })
vim.keymap.set('v', '<M-e>', function() SurroundSelection("{", "}") end, { noremap = true, silent = true })

-- Insert lorem ipsum
local lipsum =
"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
vim.keymap.set('n', "<leader>il", function()
  vim.api.nvim_put({ lipsum }, "c", true, true)
end, { noremap = true, silent = true })
-- snippets

local ls = require("luasnip")

vim.keymap.set({ "i" }, "<D-[>", function()
  ls.expand()
  print("expanded")
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

local untrigger = function()
  -- get the snippet
  local snip = require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()].parent.snippet
  -- get its trigger
  local trig = snip.trigger
  -- replace that region with the trigger
  local node_from, node_to = snip.mark:pos_begin_end_raw()
  vim.api.nvim_buf_set_text(
    0,
    node_from[1],
    node_from[2],
    node_to[1],
    node_to[2],
    { trig }
  )
  -- reset the cursor-position to ahead the trigger
  vim.fn.setpos(".", { 0, node_from[1] + 1, node_from[2] + 1 + string.len(trig) })
end


vim.keymap.set({ "i", "s" }, "<c-x>", function()
  if require("luasnip").in_snippet() then
    untrigger()
    require("luasnip").unlink_current()
  end
end, {
  desc = "Undo a snippet",
})

-- Autocommand to auto-expand snippets when a match is found
vim.api.nvim_create_autocmd("TextChangedI", {
  pattern = "*", -- Apply to all filetypes, you can change this to specific filetypes
  callback = function()
    local luasnip = require("luasnip")
    if luasnip.expandable() then
      -- Start a new undo block in Insert mode (i_CTRL-G_u)
      -- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-G>u', true, false, true), 'i', true)
      luasnip.expand() -- Automatically expand the snippet
    end
  end,
})

vim.api.nvim_set_keymap('n', 'm', 's', { noremap = true, silent = true })

function convert_to_bmatrix()
  -- Get the visual selection
  local start_row, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]
  local end_row, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
  local lines = vim.fn.getline(start_row, end_row)

  -- Process each line to remove brackets and reformat for bmatrix
  for i, line in ipairs(lines) do
    -- Remove square brackets and trim whitespace
    line = line:gsub("[%[%]]", ""):gsub("^%s*(.-)%s*$", "%1")
    -- Replace spaces between elements with " & " for LaTeX compatibility
    lines[i] = line:gsub("%s+", " & ")
  end

  -- Join lines with " \\ " to format rows correctly in bmatrix
  local matrix_body = table.concat(lines, " \\\\\n")

  -- Replace selection with LaTeX bmatrix environment
  vim.fn.setline(start_row, "\\begin{bmatrix}")
  vim.fn.append(start_row, matrix_body)
  vim.fn.append(start_row + #lines, "\\end{bmatrix}")

  -- Remove original lines if the selection spanned multiple lines
  if #lines > 1 then
    vim.fn.deletebufline('%', start_row + 1, start_row + #lines)
  end
end

-- Map the function to a visual mode key (e.g., `<leader>b`)
vim.api.nvim_set_keymap('v', '<leader>b', [[:lua convert_to_bmatrix()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>cf', ':let @+ = expand("%:p")<CR>',
  { noremap = true, silent = true, desc = "Copy file path to clipboard" })

vim.api.nvim_set_keymap('v', '', ':GitBlameCopyFileURL<CR>',
  { noremap = true, silent = true, desc = "Copy file URL to clipboard" })

local Terminal = require('toggleterm.terminal').Terminal
local default_shell = Terminal:new({ cmd = 'zsh', hidden = true })
vim.keymap.set(
  'n',
  '<leader>to',
  function()
    default_shell:toggle()
  end,
  { noremap = true, silent = true, desc = "Toggle terminal" }
)
vim.keymap.set(
  'n',
  '<F12>',
  function()
    default_shell:toggle()
  end,
  { noremap = true, silent = true, desc = "Toggle terminal" }
)

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
end, { noremap = true, silent = true, desc = "Toggle zen mode" })

local exit_grp = vim.api.nvim_create_augroup("ExitHook", { clear = true })
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = exit_grp,
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf)
          and vim.api.nvim_buf_get_option(buf, "filetype") == "zenmode-bg"
      then
        require("zen-mode").toggle()
        break
      end
    end
  end,
})

-- Define a :Block command that adds `{` above and `}` below a visual‐line range
vim.api.nvim_create_user_command('Block', function(opts)
  -- opts.line1 and opts.line2 are 1‑indexed line numbers of the range
  local bufnr      = vim.api.nvim_get_current_buf()
  local start_line = opts.line1
  local end_line   = opts.line2

  -- Insert “{” on its own line above the first selected line
  -- nvim_buf_set_lines expects 0‑based indices; start==end means “insert at that index”
  vim.api.nvim_buf_set_lines(bufnr,
    start_line - 1, -- start (0‑based)
    start_line - 1, -- end (0‑based, exclusive)
    false,          -- strict_indexing?
    { '{' }         -- lines to insert
  )

  -- Insert “}” on its own line below the last selected line.
  -- Because we added one line above, the original end_line has shifted down by +1.
  vim.api.nvim_buf_set_lines(bufnr,
    end_line + 1, -- start (0‑based) = original end_line+1
    end_line + 1, -- end (exclusive)
    false,
    { '}' }
  )

  vim.lsp.buf.format({ async = true })
end, {
  range = true, -- make it accept a line range
  desc  = 'Surround visual selection with { }'
})
-- vim.keymap.set(
--   't',
--   '<F12>',
--   function()
--     default_shell:toggle()
--   end,
--   { noremap = true, silent = true, desc = "Open terminal" }
-- )

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.keymap.set('v', '<C-b>', function()
      SurroundSelection("*", "*")
    end, { noremap = true, silent = true })
    vim.keymap.set('v', '<C-i>', function()
      SurroundSelection("_", "_")
    end, { noremap = true, silent = true })
    vim.keymap.set('v', '<C-u>', function()
      SurroundSelection("#underline[", "]")
    end, { noremap = true, silent = true })
  end,
})
