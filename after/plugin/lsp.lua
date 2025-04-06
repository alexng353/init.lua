local lsp_zero = require('lsp-zero')
local telescope = require('telescope.builtin')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({
    buffer = bufnr,
    preserve_mappings = false
  })

  vim.keymap.set("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
    print("formatted buffer")
  end, { buffer = bufnr, desc = 'Format file' })

  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = '[l]SP Code [a]ction', buffer = bufnr })
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[l]SP [r]ename', buffer = bufnr })
  vim.keymap.set('n', 'gr', telescope.lsp_references, { desc = '[g]oto [r]eferences', buffer = bufnr })
  vim.keymap.set('n', 'gd', telescope.lsp_definitions, { desc = '[g]oto [d]efinitions', buffer = bufnr })
  vim.keymap.set('n', 'gI', telescope.lsp_implementations, { desc = '[g]oto [I]mplementations', buffer = bufnr })
  vim.keymap.set('n', '<leader>lD', telescope.lsp_type_definitions,
    { desc = 'Goto Type [D]efinitions', buffer = bufnr })
  vim.keymap.set('n', '<leader>ls', telescope.lsp_document_symbols,
    { desc = 'Goto Document [s]ymbols', buffer = bufnr })
  vim.keymap.set('n', '<leader>lS', telescope.lsp_dynamic_workspace_symbols,
    { desc = 'Goto Workspace [S]ymbols', buffer = bufnr })
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'rust_analyzer'
  },
  handlers = {
    lsp_zero.default_setup,
    ts_ls = function()
      require('lspconfig').ts_ls.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
        -- settings = {
        --   typescript = {
        --     tsserver = {
        --       maxTsServerMemory = 8192
        --     }
        --   }
        -- }
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
  -- matlab_ls = function()
  -- end
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local luasnip = require('luasnip')

-- Set up nvim-cmp
cmp.setup({
  snippet = {
    -- REQUIRED: This tells nvim-cmp how to expand snippets
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  -- You can add your other sources here, such as 'supermaven'
  sources = cmp.config.sources({
    { name = 'luasnip' },  -- LuaSnip integration
    { name = 'nvim_lsp' }, -- LSP source
    -- Add other sources as necessary
    -- { name = 'supermaven' },
  }),
})

-- Load LuaSnip snippets
-- require("luasnip.loaders.from_vscode").lazy_load() -- Load snippets from VSCode-style snippets
--


for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
