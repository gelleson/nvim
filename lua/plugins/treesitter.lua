-- Pin nvim-treesitter (and its textobjects companion) to the `master` branch.
--
-- Why this matters: upstream's default branch is now `main`, a ground-up rewrite
-- with a different API. AstroNvim v5 targets the legacy `master` branch
-- (`main = "nvim-treesitter.configs"`). Mixing the two produces startup popup
-- errors (missing `nvim-treesitter.configs` module). AstroNvim pins the core
-- plugin to `master` but leaves textobjects unpinned, so we lock it here to keep
-- `:Lazy update` from drifting onto the incompatible rewrite.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "master",
  },
}
