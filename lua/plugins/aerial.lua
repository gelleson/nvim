---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = {
    -- Keep the original scopes until filtering, so object members cannot become class fields.
    filter_kind = false,
    post_add_all_symbols = function(_, items)
      local types = { Class = true, Struct = true, Interface = true, Enum = true }
      local scopes = { File = true, Module = true, Namespace = true }
      local functions = { Function = true, Method = true, Constructor = true }
      local function filter(symbols)
        return vim.tbl_filter(function(item)
          local parent_kind = item.parent and item.parent.kind
          local class_member = types[parent_kind] == true
          local keep = types[item.kind] or scopes[item.kind] or functions[item.kind]
          if item.kind == "Property" or item.kind == "Field" or item.kind == "Variable" then
            keep = class_member
          elseif item.kind == "Constant" then
            keep = class_member or not parent_kind or scopes[parent_kind]
          end
          if not keep then return false end
          if item.children then item.children = filter(item.children) end
          return true
        end, symbols)
      end
      return filter(items)
    end,
  },
}
