local telescope = require('telescope.builtin')

require('mason').setup({})

-- LSP keymaps on attach. Builds on the 0.11+ default mappings (grn, grr, gri,
-- gra, grt, gO, <C-s>) — these <leader>l* mappings are kept for muscle memory.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = function(desc) return { buffer = bufnr, desc = desc } end

    vim.keymap.set('n', '<leader>lf', function()
      vim.lsp.buf.format({ async = true })
      print('formatted buffer')
    end, opts('Format file'))
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts('[l]SP Code [a]ction'))
    vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts('[l]SP [r]ename'))
    vim.keymap.set('n', 'gr', telescope.lsp_references, opts('[g]oto [r]eferences'))
    vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts('[g]oto [d]efinitions'))
    vim.keymap.set('n', 'gI', telescope.lsp_implementations, opts('[g]oto [I]mplementations'))
    vim.keymap.set('n', '<leader>lD', telescope.lsp_type_definitions, opts('Goto Type [D]efinitions'))
    vim.keymap.set('n', '<leader>ls', telescope.lsp_document_symbols, opts('Goto Document [s]ymbols'))
    vim.keymap.set('n', '<leader>lS', telescope.lsp_dynamic_workspace_symbols, opts('Goto Workspace [S]ymbols'))
  end,
})

-- Detach dockerls from .dockerignore buffers (it attaches by mistake).
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'dockerls' then
      local filename = vim.api.nvim_buf_get_name(args.buf)
      if filename:match('%.dockerignore$') then
        vim.lsp.buf_detach_client(args.buf, client.id)
      end
    end
  end,
})

vim.lsp.enable({
  'ts_ls',
  'rust_analyzer',
  'lua_ls',
  'tinymist',
  'dockerls',
  'tailwindcss',
  'mdx_analyzer',
})

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
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
  sources = cmp.config.sources({
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
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

for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then
      return
    end
    return default_diagnostic_handler(err, result, context, config)
  end
end
