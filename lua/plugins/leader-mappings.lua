return {
  "AstroNvim/astrocore",
  -- Swap after every plugin has contributed its mappings.
  config = function(_, opts)
    local astrocore = require "astrocore"
    for mode, mappings in pairs(opts.mappings) do
      local swapped = {}
      for lhs, mapping in pairs(mappings) do
        local key = vim.fn.keytrans(vim.api.nvim_replace_termcodes(lhs, true, true, true))
        local prefix, suffix = key:match "^<Space>([tT])(.*)$"
        if prefix then key = "<Space>" .. (prefix == "t" and "T" or "t") .. suffix end
        key = key:gsub("^<Space>tW", "<Space>tw")
        swapped[key] = mapping
      end
      opts.mappings[mode] = swapped
    end
    astrocore.setup(opts)
  end,
}
