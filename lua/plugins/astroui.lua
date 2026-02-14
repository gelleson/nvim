-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "astrodark",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = {
        -- Cursor = { fg = "#000000", bg = "#ffff00" },
        -- CursorLine = { bg = "#1c3a5e" },
        -- CursorColumn = { bg = "#1c3a5e" },
        -- Normal = { bg = "NONE" },
        -- NormalFloat = { bg = "NONE" },
        -- FloatBorder = { bg = "NONE" },
        -- WinSeparator = { bg = "NONE" },
        -- SignColumn = { bg = "NONE" },
        -- StatusLine = { bg = "NONE" },
        -- CursorLine = { bg = "NONE" },
        -- TelescopeNormal = { bg = "NONE" },
        -- TelescopeBorder = { bg = "NONE" },
        -- TelescopePromptNormal = { bg = "NONE" },
        -- TelescopePromptBorder = { bg = "NONE" },
        -- TelescopePreviewNormal = { bg = "NONE" },
        -- TelescopePreviewBorder = { bg = "NONE" },
        -- NeoTreeNormal = { bg = "NONE" },
        -- NeoTreeNormalNC = { bg = "NONE" },
        -- NeoTreeFloatBorder = { bg = "NONE" },
        -- NeoTreeWinSeparator = { bg = "NONE" },
        -- NoiceCmdlinePopup = { bg = "NONE" },
        -- NoiceCmdlinePopupBorder = { bg = "NONE" },
        -- NotifyBackground = { bg = "NONE" },
        -- NotifyERRORBody = { bg = "NONE" },
        -- NotifyINFOBody = { bg = "NONE" },
        -- NotifyWARNBody = { bg = "NONE" },
        -- NotifyDEBUGBody = { bg = "NONE" },
        -- NotifyTRACEBody = { bg = "NONE" },
      },
      astrodark = {},
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
