-- DAP (debugging) customizations.
--
-- Problem this fixes: when you "debug test" in Go and no breakpoint is hit,
-- delve runs the whole test to completion in milliseconds. AstroNvim's default
-- listeners then call `dapui.close()` on `event_terminated`/`event_exited`, so
-- the debug UI flashes open and immediately disappears.
--
-- Fixes:
--   1. Keep the DAP UI open when a session ends (don't auto-close) so you can
--      still read scopes/console/output. Close it manually with `<Leader>du`.
--   2. Add `<Leader>dt` to debug the nearest Go test AND auto-set a breakpoint
--      on the test's first statement, so execution always pauses.

---@type LazySpec
return {
  {
    "rcarriga/nvim-dap-ui",
    -- Override AstroNvim's default config so the UI is not closed automatically
    -- when the debug session terminates/exits.
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dapui.setup(opts)
      -- Open the UI when a session initializes.
      dap.listeners.after.event_initialized.dapui_config = function() dapui.open() end
      -- NOTE: intentionally NOT closing on event_terminated / event_exited.
      -- The UI stays up after the run so results don't flash away. Use
      -- `<Leader>du` to toggle it closed, or `<Leader>dq` to close the session.
      dap.listeners.after.event_terminated.dapui_config = nil
      dap.listeners.after.event_exited.dapui_config = nil
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    specs = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>dt"] = {
            function()
              -- Auto-set a breakpoint on the first statement of the enclosing
              -- test function so the run always pauses (instead of running to
              -- completion and closing the UI). Falls back to a plain
              -- debug_test if we can't locate the function header.
              local dap = require "dap"
              local ok_ts, ts = pcall(require, "nvim-treesitter.ts_utils")
              if ok_ts then
                local node = ts.get_node_at_cursor()
                while node and node:type() ~= "function_declaration" do
                  node = node:parent()
                end
                if node then
                  -- body is the block `{ ... }`; first real line is header + 1
                  local start_row = node:start() -- 0-indexed line of `func ...`
                  local bp_line = start_row + 2 -- 1-indexed first line inside body
                  local last = vim.api.nvim_buf_line_count(0)
                  if bp_line > last then bp_line = last end
                  local cursor = vim.api.nvim_win_get_cursor(0)
                  vim.api.nvim_win_set_cursor(0, { bp_line, 0 })
                  dap.set_breakpoint()
                  vim.api.nvim_win_set_cursor(0, cursor)
                end
              end
              require("dap-go").debug_test()
            end,
            desc = "Debug nearest Go test (auto-breakpoint)",
          }
          maps.n["<Leader>dT"] = {
            function() require("dap-go").debug_test() end,
            desc = "Debug nearest Go test (no auto-breakpoint)",
          }
        end,
      },
    },
  },
}
