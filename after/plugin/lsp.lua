local lsp_zero = require('lsp-zero')


lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })


  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format()
    print("formatted buffer")
  end, { buffer = bufnr, desc = 'Format current buffer' })

  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP Code Action', buffer = bufnr })
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = 'LSP Rename', buffer = bufnr })
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Goto References', buffer = bufnr })
  vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = 'Goto Definitions', buffer = bufnr })
  vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations,
    { desc = 'Goto Implementations', buffer = bufnr })
  vim.keymap.set('n', '<leader>lD', require('telescope.builtin').lsp_type_definitions,
    { desc = 'Goto Type Definitions', buffer = bufnr })
  vim.keymap.set('n', '<leader>ls', require('telescope.builtin').lsp_document_symbols,
    { desc = 'Goto Document Symbols', buffer = bufnr })
  vim.keymap.set('n', '<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols,
    { desc = 'Goto Workspace Symbols', buffer = bufnr })
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'tsserver', 'rust_analyzer' },
  handlers = {
    lsp_zero.default_setup,
    tsserver = function()
      require('lspconfig').tsserver.setup({
        settings = {
          typescript = {
            format = {
              enable = false,
            }
          }
        }
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {
                'vim',
                'jit'
              }
            }
          }
        }
      })
    end
  },
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_action.tab_complete(),
    ['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  })
})
