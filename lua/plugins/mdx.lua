return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "mdx" },
    -- Registered eagerly so `ft = "mdx"` can fire; the plugin's own
    -- after/plugin script repeats this once it loads.
    init = function()
      vim.filetype.add({ extension = { mdx = "mdx" } })
    end,
  },
}
