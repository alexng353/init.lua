return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>tt',
      function()
        require('trouble').toggle()
      end,
      mode = 'n',
      desc = 'Toggle Trouble',
    },
  },
  opts = {},
}
