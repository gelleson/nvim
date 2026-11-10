-- Run: nvim --headless '+luafile tests/leader_mappings.lua' +qa!
for _, mode in ipairs { "n", "x", "o" } do
  assert(vim.fn.maparg("t", mode) == "", "plain t must retain its native motion")
  assert(vim.fn.maparg("T", mode) == "", "plain T must retain its native motion")
end
assert(vim.g.colors_name == "tokyonight-day" and vim.o.background == "light")

local groups = {}
for _, map in ipairs(require("astrocore").which_key_queue) do
  groups[vim.api.nvim_replace_termcodes(map[1], true, true, true)] = map.group
end
assert(groups[" t"] == "Tests")
assert(groups[" T"] == "Terminal")
assert(groups[" tW"] == "Watch")

local called
package.loaded.neotest = {
  run = { run = function() called = "test" end },
  summary = { toggle = function() called = "summary" end },
}
vim.cmd.normal " tt"
assert(called == "test", "Space tt must run the nearest test")
vim.cmd.normal " ts"
assert(called == "summary", "Space ts must toggle the test summary")
vim.api.nvim_create_user_command("ToggleTerm", function(args) called = args.args end, { nargs = "*" })
vim.cmd.normal " Tf"
assert(called == "direction=float", "Space Tf must open the floating terminal")
print "Leader groups, command execution, and native t/T motions passed"
