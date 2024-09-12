local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("all", {
  s("ternary", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  })
})

-- sk -> \$$0\$
ls.add_snippets("tex", {
  s("sk", {
    t("$"), i(1, "input"), t("$")
  }),
  s({ trig = "eq", dscr = "A LaTeX equation environment" },
    fmta(
      [[
      \\begin{<1>}
      <2>
      \\end{<1>}

      ]],
      {
        i(1, "env"),
        d(2, function(_, snip)
          return sn(nil, snip.env.i(1))
        end)
      },
      {
        delimiters = "<>"
      }
    )
  ),
})

-- Autocommand to insert "\\" when pressing Enter inside a pmatrix
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*.tex",
--   callback = function()
--     -- Function to check if the cursor is inside a pmatrix
--     local function inside_pmatrix()
--       local ts_utils = require 'nvim-treesitter.ts_utils'
--       local node = ts_utils.get_node_at_cursor()
--
--       while node do
--         if node:type() == "environment" then
--           local env_name = vim.treesitter.query.get_node_text(node:child(1), 0)
--           if env_name == "pmatrix" then
--             return true
--           end
--         end
--         node = node:parent()
--       end
--       return false
--     end
--
--     -- Map the Enter key to insert "\\" if inside a pmatrix
--     vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "v:lua.require'myplugin'.check_pmatrix() ? '\\\\<CR>' : '<CR>'", { expr = true, noremap = true, silent = true })
--     
--     -- Define the check_pmatrix function globally
--     _G.myplugin = {}
--     _G.myplugin.check_pmatrix = function()
--       return inside_pmatrix()
--     end
--   end
-- })
