local M = {}

local compile = require("it-compiles.check")

M.setup = function() end
M.check = compile.check

return M
