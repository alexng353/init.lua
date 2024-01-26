local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>o", ui.toggle_quick_menu)

function getOS()
  -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

local osname = getOS()
if (osname == "Linux")
then
  vim.keymap.set("n", "<M-j>", function() ui.nav_file(1) end)
  vim.keymap.set("n", "<M-k>", function() ui.nav_file(2) end)
  vim.keymap.set("n", "<M-l>", function() ui.nav_file(3) end)
  vim.keymap.set("n", "<M-;>", function() ui.nav_file(4) end)
else
  vim.keymap.set("n", "<D-j>", function() ui.nav_file(1) end)
  vim.keymap.set("n", "<C-L>", function() ui.nav_file(2) end)
  vim.keymap.set("n", "<D-l>", function() ui.nav_file(3) end)
  vim.keymap.set("n", "<D-;>", function() ui.nav_file(4) end)
end
