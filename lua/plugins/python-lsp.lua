-- Fix: three Python type checkers attach to every Python buffer at once
-- (basedpyright, pyrefly, ty), which triggers a Neovim core bug:
--
--   Error in decoration provider "win" (ns=nvim.lsp.inlayhint):
--   .../lua/vim/lsp/inlay_hint.lua:349: Invalid 'col': out of range
--
-- Root cause (nvim 0.11.4 runtime/lua/vim/lsp/inlay_hint.lua): inlay hints are
-- stored per client (`client_hints[client_id]`) but the document version is
-- tracked in a single shared `bufstate.version`. When any one client answers for
-- the current version -- even with an empty result -- it bumps that shared
-- version, re-validating every *other* client's stale hints from an older
-- version. The render guard then passes and a stale `position.character`,
-- computed against a line that has since been shortened, overflows the line ->
-- `nvim_buf_set_extmark` raises "Invalid 'col': out of range".
--
-- A single inlay-hint provider is correctly guarded, so the bug needs 2+ racing
-- clients. Upstream fixed it by giving each client its own version
-- (neovim/neovim#40569, master only -- NOT in 0.11.4 and NOT in 0.12.4).
--
-- Why all three attach: `lua/community.lua` imports `astrocommunity.pack.python`,
-- whose `init.lua` only lists basedpyright. But lazy.nvim's `lsmod` walks every
-- subdirectory containing an `init.lua`, so the `pyrefly` and `ty` subpacks get
-- imported too. Three checkers also means every hint renders three times, plus
-- triplicated diagnostics and CPU.
--
-- Keep pyrefly as the single type checker. Same `handlers.<server> = false`
-- mechanism AstroLSP uses elsewhere (see `deno.lua`): it means "do not set up".

---@type LazySpec
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      handlers = {
        basedpyright = false,
        ty = false,
      },
    },
  },
}
