-- Run: nvim --headless -u NONE -l tests/lazy_docs.lua
vim.opt.rtp:prepend(vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim")
local docs = require("lazy.manage.task.plugin").docs
local root = vim.fn.tempname()
vim.fn.mkdir(root .. "/doc/nested", "p")
vim.fn.writefile({ "# Development" }, root .. "/doc/DEVELOPMENT.md")
local task = { plugin = { dir = root }, log = function() end }
local ok, err = pcall(docs.run, task)
assert(not ok and tostring(err):find("E151", 1, true), "expected original Markdown-only failure")

-- Load the configuration guard without starting or installing plugins.
package.loaded.lazy = { setup = function() end }
dofile "lua/lazy_setup.lua"
docs.run(task)
assert(vim.fn.filereadable(root .. "/doc/tags") == 0)

vim.fn.writefile({ "*example* English help" }, root .. "/doc/nested/example.txt")
docs.run(task)
assert(vim.fn.filereadable(root .. "/doc/tags") == 1, "English help tags missing")
vim.fn.delete(root .. "/doc/nested/example.txt")
vim.fn.writefile({ "*example* French help" }, root .. "/doc/nested/example.frx")
docs.run(task)
assert(vim.fn.filereadable(root .. "/doc/tags-fr") == 1, "translated help tags missing")

vim.fn.writefile({ "*duplicate*", "*duplicate*" }, root .. "/doc/broken.txt")
ok, err = pcall(docs.run, task)
assert(not ok and tostring(err):find("E154", 1, true), "real helptags errors must remain visible")
vim.fn.delete(root, "rf")
docs.run(task) -- A missing doc directory is also harmless.
print "lazy docs checks passed"
