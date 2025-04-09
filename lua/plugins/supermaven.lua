local pwd = vim.fn.getcwd()

-- /Users/alex/Documents/college/College/2024 Fall/CMPT 125/Assignments

if (string.match(pwd, "cmpt125") or string.match(pwd, "Assignments")) then
  print("Supermaven disabled")
  return {}
end

-- if string.match(pwd, "college") then
--   print("Supermaven disabled")
--   return {}
-- end

local os = require("alexng353.helpers").getOS()

local accept = os == "Linux" and "<M-;>" or "<D-;>"
local open = os == "Linux" and "<M-CR>" or "<D-CR>"
local cw = os == "Linux" and "<C-j>" or "<D-'>"

return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = accept,
        clear_suggestion = "<C-]>",
        accept_word = cw,
      },
      ignore_filetypes = {},
      color = {
        suggestion_color = "#ffffff",
        cterm = 244,
      },
      log_level = "info",                -- set to "off" to disable logging completely
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false            -- disables built in keymaps for more manual control
    })
  end
}
