-- Wrapper to fix deprecation warning for make_position_params
vim.lsp.util.make_position_params = (function(original)
  return function(window, offset_encoding)
    local client = vim.lsp.get_clients({ bufnr = vim.api.nvim_win_get_buf(window or 0) })[1]
    offset_encoding = offset_encoding or (client and client.offset_encoding) or "utf-16"
    return original(window, offset_encoding)
  end
end)(vim.lsp.util.make_position_params)

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
          client.capabilities.documentFormattingProvider = false
          client.capabilities.documentRangeFormattingProvider = false
        end
      })
    end,
    prettier = function()
      require('lspconfig').prettierd.setup()
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
    end,
    tinymist = function()
      require("lspconfig")["tinymist"].setup {
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onType",
          semanticTokens = "disable"
        }

      }
    end,
    dockerls = function()
      require('lspconfig').dockerls.setup({
        on_attach = function(client, bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          if filename:match("%.dockerignore$") then
            vim.lsp.buf_detach_client(bufnr, client.id)
            return
          end
        end,
      })
    end,
  }
})

-- Use local tailwindcss-language-server build (with class grouping)
vim.lsp.config('tailwindcss', {
  cmd = { 'node', '/home/alex/code/opensource/tailwindcss-intellisense/packages/tailwindcss-language-server/bin/tailwindcss-language-server', '--stdio' },
})
vim.lsp.enable('tailwindcss')

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
    { name = 'path' },
    -- Add other sources as necessary
    -- { name = 'supermaven' },
  }),
})

cmp.setup.filetype('markdown', {
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'buffer' },
  }),
  completion = {
    keyword_pattern = [[[^()\[\]\s]+]],
  },
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
