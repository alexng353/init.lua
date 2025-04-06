return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*toggleterm#*",
        callback = function()
          local opts = { noremap = true }
          vim.api.nvim_buf_set_keymap(0, 't', '<C-Space>', [[<C-\><C-n>]], opts)
          vim.api.nvim_buf_set_keymap(0, 'n', '<esc>', [[<C-w>q]], opts)
        end,
      })

      require('toggleterm').setup({
        -- size can be a number or function which is passed the current terminal
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          else
            return vim.o.columns * 0.8
          end
        end,
        open_mapping = [[<F12>]],
        ---@diagnostic disable-next-line: unused-local
        on_open = function(term)
        end,
        ---@diagnostic disable-next-line: unused-local
        on_close = function(term)
        end,
        highlights = {
          -- highlights which map to a highlight group name and a table of it's values
          -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
          Normal = {
            link = 'Normal'
          },
          NormalFloat = {
            link = 'Normal'
          },
          FloatBorder = {
            -- guifg = <VALUE-HERE>,
            -- guibg = <VALUE-HERE>,
            link = 'FloatBorder'
          },
        },
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = 1,       -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        persist_size = true,
        direction = 'horizontal', -- | 'horizontal' | 'window' | 'float',
        close_on_exit = true,     -- close the terminal window when the process exits
        shell = vim.o.shell,      -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_win_open'
          -- see :h nvim_win_open for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'curved', -- single/double/shadow/curved
          width = math.floor(0.7 * vim.fn.winwidth(0)),
          height = math.floor(0.8 * vim.fn.winheight(0)),
          -- winblend = 4,
        },
        winbar = {
          enabled = true,
        },
      })
    end,
    keys = {
      -- { "<F12>" },
      -- { "<F12>",      "<cmd>ToggleTerm<CR>", desc = "terminal float" },
      -- { "<Leader>to", "<cmd>ToggleTerm<CR>", desc = "terminal float" },
    }
  }
}
