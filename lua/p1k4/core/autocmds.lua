-- ============================================================
-- Autocommands — p1k4 Neovim 0.12
-- ============================================================

-- ── Highlight on yank ──────────────────────────────────────
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Briefly highlight yanked text",
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- ── Competitive programming lyrics ─────────────────────────
local function select_lyric()
	local file = vim.fn.expand("/Users/heron/Documents/lyrics.txt")
	if not vim.fn.filereadable(file) then
		print("Lyrics file not found")
		return ""
	end

	local content = vim.fn.readfile(file)
	local full_content = vim.fn.join(content, "\n")
	local lyrics = vim.fn.split(full_content, "\n\n")

	if #lyrics == 0 then
		print("No valid lyrics found")
		return ""
	end

	math.randomseed(os.time())
	local idx = math.random(#lyrics)
	return lyrics[idx]
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.cpp",
	callback = function()
		local file_path = vim.fn.expand("%:p")
		if not string.match(file_path, "^" .. vim.fn.expand("~/Documents/Contests/")) then
			return
		end

		local lines = vim.fn.getline(1, "$")
		if #lines > 0 and string.match(lines[1], "^%s*//") then
			return
		end

		local lyrics = select_lyric()
		if lyrics ~= "" then
			local lyric_lines = vim.fn.split(lyrics, "\n")
			for i, line in ipairs(lyric_lines) do
				vim.fn.append(i - 1, "//  " .. line)
			end
			vim.fn.append(#lyric_lines, "")
		end
	end,
})
