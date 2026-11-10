-- Rex retains underlying text when Neovim draws transparent popups.
vim.opt.winblend = 0
vim.opt.pumblend = 0

-- Thin pane dividers, like Zed's editor and dock borders.
vim.opt.fillchars:append {
  vert = "│",
  horiz = "─",
  verthoriz = "┼",
  vertleft = "┤",
  vertright = "├",
  horizup = "┴",
  horizdown = "┬",
}
