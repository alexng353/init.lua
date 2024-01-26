vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.js", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.keymap.set("n", "cl", function()
      local word = vim.fn.expand "<cword>"
      local newRow = "console.log('### " .. word .. ": ', { " .. word .. " });"
      vim.cmd("norm! o" .. newRow)
    end, { silent = true, buffer = true })
  end,
})
