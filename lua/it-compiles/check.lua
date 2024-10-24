local M = {}

function M.check()
	vim.notify("TypeScript compilation started...", vim.log.levels.INFO, { title = "Build" })

	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local output = ""

	local handle
	-- spawn absolutely does not need every field passed
	---@diagnostic disable-next-line: missing-fields
	handle = vim.loop.spawn("npm", {
		args = { "run", "tsc" },
		stdio = { nil, stdout, stderr },
		detached = true,
		hide = true,
	}, function()
		if stdout then
			stdout:read_stop()
			stdout:close()
		end
		if stderr then
			stderr:read_stop()
			stderr:close()
		end
		handle:close()

		vim.schedule(function()
			local lines = vim.split(output, "\n")
			local qf_entries = {}

			for _, line in ipairs(lines) do
				-- Match TypeScript error format: file(line,col): error TS1234: message
				local file, lnum, col, msg = line:match("([^%(]+)%((%d+),(%d+)%): (.+)")
				if file then
					table.insert(qf_entries, {
						filename = file,
						lnum = tonumber(lnum),
						col = tonumber(col),
						text = msg,
						type = "E",
					})
				end
			end

			vim.fn.setqflist(qf_entries)
			local quickFixCount = #qf_entries

			if quickFixCount > 0 then
				vim.notify("TypeScript errors found.", vim.log.levels.WARN, { title = "Build" })
				vim.cmd("copen")
			else
				vim.notify("No errors found", vim.log.levels.INFO, { title = "Build" })
			end
		end)
	end)

	if stdout then
		stdout:read_start(function(err, data)
			if err then
				vim.notify("Error reading stdout: " .. err, vim.log.levels.ERROR, { title = "Build" })
				return
			end
			if data then
				output = output .. data
			end
		end)
	end

	if stderr then
		stderr:read_start(function(err, data)
			if err then
				vim.notify("Error reading stderr: " .. err, vim.log.levels.ERROR, { title = "Build" })
				return
			end
			if data then
				output = output .. data
			end
		end)
	end
end

return M
