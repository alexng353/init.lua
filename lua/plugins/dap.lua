return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",              -- UI for DAP
      "theHamsta/nvim-dap-virtual-text",   -- Show virtual text for variables
      "jay-babu/mason-nvim-dap.nvim",      -- Mason integration for DAP
      "williamboman/mason.nvim",           -- Mason for managing DAP debuggers
      "nvim-telescope/telescope-dap.nvim", -- Telescope integration for DAP
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto open/close DAP UI
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mason.nvim", "nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "python", -- Python debugging
          "cppdbg", -- C/C++ debugging
          "node2",  -- JavaScript debugging
          "go",     -- Go debugging
          "codelldb", -- Rust debugging
        },
        automatic_installation = true,
      })
    end
  }
}
