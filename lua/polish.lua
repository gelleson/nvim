-- Rex retains underlying text when Neovim draws transparent popups.
vim.opt.winblend = 0
vim.opt.pumblend = 0

vim.keymap.set({ "n", "x", "o" }, "t", "T")
vim.keymap.set({ "n", "x", "o" }, "T", "t")
