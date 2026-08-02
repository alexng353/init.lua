return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = false,
  config = function()
    require('ts_context_commentstring').setup {
      -- We don't want the CursorHold autocmd; we compute on demand below.
      enable_autocmd = false,
    }

    -- Make Neovim's native commenting (gc/gcc -> <leader>/) context-aware:
    -- intercept the `commentstring` lookup and compute it from treesitter at
    -- comment time. Returns nil for plain buffers (e.g. toml), so it falls
    -- back to the filetype default.
    local get_option = vim.filetype.get_option
    vim.filetype.get_option = function(filetype, option)
      return option == 'commentstring'
          and require('ts_context_commentstring.internal').calculate_commentstring()
          or get_option(filetype, option)
    end
  end,
}
