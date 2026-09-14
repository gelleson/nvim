-- Run: nvim --headless -u NONE -l tests/aerial_symbols.lua
vim.opt.rtp:prepend(vim.fn.stdpath "data" .. "/lazy/aerial.nvim")
require("aerial").setup(dofile("lua/plugins/aerial.lua").opts)
require("aerial").sync_load()

local line = 0
local function symbol(kind, name, children)
  local start = line
  line = line + 1
  return {
    kind = vim.lsp.protocol.SymbolKind[kind],
    name = name,
    range = { start = { line = start, character = 0 }, ["end"] = { line = start, character = 1 } },
    children = children,
  }
end

local symbols = {
  symbol("Constant", "GLOBAL"),
  symbol("Variable", "global_variable"),
  symbol("Property", "loose_property"),
  symbol("Namespace", "app", {
    symbol("Constant", "SCOPED"),
    symbol("Class", "Example", {
      symbol("Field", "field"),
      symbol("Variable", "class_variable"),
      symbol("Constant", "STATIC"),
      symbol("Property", "options", { symbol("Property", "nested_property") }),
      symbol("Object", "object", { symbol("Property", "object_property") }),
      symbol("Constructor", "new"),
      symbol("Method", "run", {
        symbol("Variable", "local_variable"),
        symbol("Constant", "LOCAL"),
        symbol("Property", "local_property"),
      }),
    }),
  }),
  symbol("Function", "main", { symbol("Constant", "LOCAL_MAIN") }),
}
vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn["repeat"]({ " " }, line))
require("aerial.backends.lsp.callbacks").handle_symbols(symbols, vim.api.nvim_get_current_buf(), "test")
local names = {}
for _, item in require("aerial.data").get_or_create(0):iter() do
  names[item.name] = true
end
local expected = {
  "GLOBAL", "app", "SCOPED", "Example", "field", "class_variable", "STATIC", "options", "new", "run", "main",
}
assert(vim.tbl_count(names) == #expected, vim.inspect(names))
for _, name in ipairs(expected) do
  assert(names[name], "missing symbol: " .. name)
end
print "aerial symbol checks passed"
