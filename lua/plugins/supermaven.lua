local pwd = vim.fn.getcwd()

if string.match(pwd, "cmpt125") then
  print("Supermaven disabled")
  return {}
end

local os = require("alexng353.helpers").getOS()

local accept = os == "Linux" and "<M-;>" or "<D-;>"
local open = os == "Linux" and "<M-CR>" or "<D-CR>"

return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = accept,
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      ignore_filetypes = { cpp = true },
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
