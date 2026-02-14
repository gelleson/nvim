return {
  {
    "folke/twilight.nvim",
    event = "BufReadPost",
    opts = {},
    config = function(_, opts)
      require("twilight").setup(opts)
      require("twilight").enable()
    end,
  },
}
