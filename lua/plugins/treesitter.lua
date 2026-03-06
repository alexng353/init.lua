return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    build = ":TSUpdate",
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp early
      require("lazy.core.loader").add_to_rtp(plugin)
    end,
    config = function()
      require("nvim-treesitter").setup {
        ensure_installed = {
          "bash", "c", "lua", "markdown", "markdown_inline", "python", "query",
          "vim", "vimdoc", "typescript", "tsx", "css", "html", "javascript",
          "json", "rust", "cpp",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      require("nvim-treesitter-textobjects").setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      -- Select keymaps
      local select_maps = {
        ["ak"] = { "@block.outer", "around block" },
        ["ik"] = { "@block.inner", "inside block" },
        ["ac"] = { "@class.outer", "around class" },
        ["ic"] = { "@class.inner", "inside class" },
        ["a?"] = { "@conditional.outer", "around conditional" },
        ["i?"] = { "@conditional.inner", "inside conditional" },
        ["af"] = { "@function.outer", "around function" },
        ["if"] = { "@function.inner", "inside function" },
        ["al"] = { "@loop.outer", "around loop" },
        ["il"] = { "@loop.inner", "inside loop" },
        ["aa"] = { "@parameter.outer", "around argument" },
        ["ia"] = { "@parameter.inner", "inside argument" },
      }
      for key, val in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(val[1], "textobjects")
        end, { desc = val[2] })
      end

      -- Move keymaps
      local move_maps = {
        { "]k", "goto_next_start", "@block.outer", "Next block start" },
        { "]f", "goto_next_start", "@function.outer", "Next function start" },
        { "]a", "goto_next_start", "@parameter.inner", "Next argument start" },
        { "]K", "goto_next_end", "@block.outer", "Next block end" },
        { "]F", "goto_next_end", "@function.outer", "Next function end" },
        { "]A", "goto_next_end", "@parameter.inner", "Next argument end" },
        { "[k", "goto_previous_start", "@block.outer", "Previous block start" },
        { "[f", "goto_previous_start", "@function.outer", "Previous function start" },
        { "[a", "goto_previous_start", "@parameter.inner", "Previous argument start" },
        { "[K", "goto_previous_end", "@block.outer", "Previous block end" },
        { "[F", "goto_previous_end", "@function.outer", "Previous function end" },
        { "[A", "goto_previous_end", "@parameter.inner", "Previous argument end" },
      }
      for _, m in ipairs(move_maps) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
          move[m[2]](m[3], "textobjects")
        end, { desc = m[4] })
      end

      -- Swap keymaps
      local swap_maps = {
        { ">K", "swap_next", "@block.outer", "Swap next block" },
        { ">F", "swap_next", "@function.outer", "Swap next function" },
        { ">A", "swap_next", "@parameter.inner", "Swap next argument" },
        { "<K", "swap_previous", "@block.outer", "Swap previous block" },
        { "<F", "swap_previous", "@function.outer", "Swap previous function" },
        { "<A", "swap_previous", "@parameter.inner", "Swap previous argument" },
      }
      for _, s in ipairs(swap_maps) do
        vim.keymap.set("n", s[1], function()
          swap[s[2]](s[3])
        end, { desc = s[4] })
      end
    end,
  },
}
