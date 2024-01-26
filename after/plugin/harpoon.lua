local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>o", ui.toggle_quick_menu)

vim.keymap.set("n", "<D-j>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-L>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<D-l>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<D-;>", function() ui.nav_file(4) end)
