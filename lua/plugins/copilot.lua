local os = require("alexng353.helpers").getOS()
local accept = os == "Linux" and "<M-l>" or "<D-l>"
local open = os == "Linux" and "<M-CR>" or "<D-CR>"
return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  opts = {
    panel = {
      enabled = true,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = open,
      },
      layout = {
        position = "right", -- bottom | top | left | right
        ratio = 0.3,
      },
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = accept,
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {},
  },
}
