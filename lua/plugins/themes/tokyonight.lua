---@type LazySpec
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    on_highlights = function(hl, colors)
      hl.WinSeparator = { fg = colors.border, bold = false }
      hl.FloatBorder = { fg = colors.border, bg = colors.bg_float }
      hl.NeoTreeWinSeparator = { link = "WinSeparator" }
      hl.SnacksPickerBorder = { link = "FloatBorder" }
      hl.SnacksPickerInputBorder = { link = "FloatBorder" }
      hl.SnacksInputBorder = { link = "FloatBorder" }
    end,
  },
}
