return {
  {
    "nvim-neotest/neotest",
    opts = {
      icons = {
        passed = "✓",
        failed = "✗",
        running = "●",
        skipped = "○",
        unknown = "?",
        watching = "◉",
        running_animated = { "|", "/", "-", "\\" },
      },
    },
  },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>Ts"] = { function() require("neotest").summary.toggle() end, desc = "Test summary" },
        },
      },
    },
  },
}
