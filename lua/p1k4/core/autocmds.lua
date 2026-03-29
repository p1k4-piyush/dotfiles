vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.cpp",
	callback = function()
		local file_path = vim.fn.expand("%:p") -- Get full file path
		if not string.match(file_path, "^" .. vim.fn.expand("~/Documents/Contests/")) then
			return -- Exit if the file is not inside ~/Contests/
		end

		local lines = vim.fn.getline(1, "$")
		if #lines > 0 and string.match(lines[1], "^%s*//") then
			return -- Exit if the first line is a comment
		end

		local lyrics = Select_Lyric()
		if lyrics ~= "" then
			local lyric_lines = vim.fn.split(lyrics, "\n")
			for i, line in ipairs(lyric_lines) do
				vim.fn.append(i - 1, "//  " .. line)
			end
			vim.fn.append(#lyric_lines, "")
		end
	end,
})

function Select_Lyric()
	local file = vim.fn.expand("/Users/piyushkeshan/Documents/lyrics.txt")
	if not vim.fn.filereadable(file) then
		print("Lyrics file not found")
		return ""
	end

	local content = vim.fn.readfile(file)
	local full_content = vim.fn.join(content, "\n")
	local lyrics = vim.fn.split(full_content, "\n\n")

	-- Debugging
	-- print("Content: " .. full_content)
	-- print("Lyrics List: " .. vim.fn.string(lyrics))

	if #lyrics == 0 then
		print("No valid lyrics found")
		return ""
	end

	math.randomseed(os.time())
	local idx = math.random(#lyrics)
	return lyrics[idx]
end
