return {
  "NickvanDyke/opencode.nvim",
  opts = {
    provider = {
      enabled = "snacks",
      cmd = "opencode",
      snacks = {
        win = {
          position = "right",
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.opencode_opts = vim.tbl_deep_extend("force", vim.g.opencode_opts or {}, opts)
    vim.o.autoread = true

    vim.keymap.set(
      { "n", "x" },
      "<C-a>",
      function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask opencode" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<C-x>",
      function() require("opencode").select() end,
      { desc = "Execute opencode action" }
    )
    vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt "@this" end, { desc = "Add to opencode" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
    vim.keymap.set(
      "n",
      "<S-C-u>",
      function() require("opencode").command "session.half.page.up" end,
      { desc = "opencode half page up" }
    )
    vim.keymap.set(
      "n",
      "<S-C-d>",
      function() require("opencode").command "session.half.page.down" end,
      { desc = "opencode half page down" }
    )
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
  end,
}
