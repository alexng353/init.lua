local dap, dapui = require("dap"), require("dapui")

vim.keymap.set("n", "<Leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<Leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>dc", function() dap.continue() end, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<Leader>ds", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<Leader>di", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<Leader>do", function() dap.step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end, { desc = "Open REPL" })
vim.keymap.set("n", "<Leader>dl", function() dap.run_last() end, { desc = "Run Last Debug Session" })

vim.keymap.set('n', '<F5>', dap.continue, { desc = "Start/Continue Debugging" })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Step Over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Step Into" })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Step Out" })

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

-- Function to find Cargo.toml and extract project name
local function find_cargo_toml_and_get_bin_name()
  local path = vim.fn.getcwd() -- Start from the current working directory

  while path ~= "/" do
    local cargo_toml = path .. "/Cargo.toml"
    local file = io.open(cargo_toml, "r")

    if file then
      for line in file:lines() do
        local name = line:match('^name%s*=%s*"(.-)"') -- Extract project name
        if name then
          file:close()
          return name
        end
      end
      file:close()
    end

    -- Move to the parent directory
    path = path:match("(.*)/[^/]+")
    if not path then break end
  end

  return nil -- Return nil if Cargo.toml is not found
end

dap.adapters.lldb = {
  type = 'executable',
  command = 'codelldb', -- Install with `rustup component add lldb`
  name = "lldb"
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      local bin_name = find_cargo_toml_and_get_bin_name()
      if bin_name then
        return vim.fn.getcwd() .. "/target/debug/" .. bin_name
      else
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
