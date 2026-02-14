return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")

    opts.statusline[#opts.statusline + 1] = status.component.builder({
      {
        provider = function()
          local ok, opencode = pcall(require, "opencode")
          if ok and opencode.statusline then
            return opencode.statusline()
          end
          return ""
        end,
      },
      hl = { fg = "fg", bold = true },
      surround = { separator = "right" },
    })

    return opts
  end,
}
