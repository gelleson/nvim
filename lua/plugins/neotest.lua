return {
  {
    "nvim-neotest/neotest",
    dependencies = { "arthur944/neotest-bun" },
    opts = function(_, opts)
      opts.icons = vim.tbl_deep_extend("force", opts.icons or {}, {
        passed = "✓",
        failed = "✗",
        running = "●",
        skipped = "○",
        unknown = "?",
        watching = "◉",
        running_animated = { "|", "/", "-", "\\" },
      })
      -- Bun uses `bun test` (bun:test), which the jest adapter can't drive
      -- (bun doesn't emit jest's JSON reporter). Register the dedicated bun
      -- adapter so `.test.ts` / `.spec.ts` files are discovered and run.
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-bun")
      return opts
    end,
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
