return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  src = {
    cmp = {
      enabled = true,
    },
  },
  keys = {
    {
      '<leader>ca',
      function()
        require('crates').upgrade_all_crates()
      end,
      desc = ' [C]rates upgrade [A]ll ',
    },

    {
      '<leader>cu',
      function()
        require('crates').update_crate()
      end,
      desc = ' [C]rates [U]pdate ',
    },
  },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('crates').setup()
  end,
}
