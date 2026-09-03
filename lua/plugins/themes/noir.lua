---@type LazySpec
return {
  "tahadx/noir.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- noir has no config API; its palette table is read at colorscheme load time
    require("noir.palette").accent = "#84a0c6" -- iceberg blue
  end,
}
