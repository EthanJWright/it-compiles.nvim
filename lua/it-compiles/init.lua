local M = {}

local compile = require("it-compiles.check")

M.setup = function(opts)
	if opts == nil then
		opts = {}
	end

	if opts.command ~= nil then
		compile.command = opts.command
	end
end
M.check = compile.check

return M
