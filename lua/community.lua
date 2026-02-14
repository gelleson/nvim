-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.gleam" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.zig" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.helm" },
  { import = "astrocommunity.pack.angular" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.just" },
  { import = "astrocommunity.pack.dart" },

  { import = "astrocommunity.test.neotest" },

  { import = "astrocommunity.ai.opencode-nvim" },
}
