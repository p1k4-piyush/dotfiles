-- Telescope.nvim — template file picker
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function yank_and_paste_file_content(prompt_bufnr)
	local entry = action_state.get_selected_entry()
	if not entry then
		return
	end

	local filepath = entry.path or entry[1]
	actions.close(prompt_bufnr)

	local content = vim.fn.readfile(filepath)
	local text = table.concat(content, "\n")

	vim.fn.setreg("+", text)
	vim.fn.setreg('"', text)
	vim.api.nvim_put(content, "l", false, true)
end

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "dist", "*.o", "*.out" },
		mappings = {
			i = {
				["<CR>"] = yank_and_paste_file_content,
			},
			n = {
				["<CR>"] = yank_and_paste_file_content,
			},
		},
	},
})

vim.keymap.set("n", "<leader>i", ":Telescope find_files cwd=~/Documents/templates<CR>", { desc = "CP Templates" })
