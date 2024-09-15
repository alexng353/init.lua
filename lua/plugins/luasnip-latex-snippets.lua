local directory = "/home/alex/code/luasnip-latex-snippets";
local macosDirectory = "/Users/alex/code/luasnip-latex-snippets.nvim";

local function does_file_exist(name)
  local f = io.open(name, "rb")
  if f then f:close() end
  return f ~= nil
end

if does_file_exist(directory) then -- Linux
  return {
    dir = directory,
    -- "alexng353/luasnip-latex-snippets.nvim",
    -- "iurimateus/luasnip-latex-snippets.nvim",
    -- vimtex isn't required if using treesitter
    -- requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      -- require 'luasnip-latex-snippets'.setup()
      -- or setup({ use_treesitter = true })
      require("luasnip").config.setup { enable_autosnippets = true }
    end,
  }
elseif does_file_exist(macosDirectory) then -- macosDirectory
  return {
    dir = macosDirectory,
    config = function()
      require("luasnip").config.setup { enable_autosnippets = true }
    end,
  }
else
  return {
    "alexng353/luasnip-latex-snippets.nvim",
    config = function()
      require("luasnip").config.setup { enable_autosnippets = true }
    end,
  }
end
