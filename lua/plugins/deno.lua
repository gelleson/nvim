-- Fix: `sigmasd/deno-nvim` still uses the deprecated `require("lspconfig").denols.setup()`
-- framework, which errors / warns under nvim-lspconfig on Neovim 0.11+
-- (see `:help lspconfig-nvim-0.11`).
--
-- AstroNvim v6 configures language servers natively via `vim.lsp.config` /
-- `vim.lsp.enable`, and nvim-lspconfig ships a native `lsp/denols.lua`, so the
-- `denols` server works without `deno-nvim` at all.
--
-- The `typescript-deno` community pack pulls in `deno-nvim` and, as part of that,
-- sets `handlers = { denols = false }` in AstroLSP (delegating denols setup to
-- deno-nvim). Here we:
--   1. Disable the broken `deno-nvim` plugin.
--   2. Re-enable AstroLSP's native `denols` handler so Deno LSP still attaches.

---@type LazySpec
return {
  -- 1. Disable the broken plugin
  { "sigmasd/deno-nvim", enabled = false },

  -- 2. Restore native denols handling. The pack set `handlers.denols = false`
  --    (delegating to deno-nvim), which AstroLSP reads as "do not set up".
  --    A `nil` override can't clear a `false` through opts merging, so we
  --    explicitly point the handler at the native `vim.lsp.enable`.
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = {
        denols = function(server) vim.lsp.enable(server) end,
      },
    },
  },
}
