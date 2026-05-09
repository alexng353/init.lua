return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "mdx" },
    init = function()
      vim.filetype.add({ extension = { mdx = "mdx" } })
    end,
    config = true,
  },
}
