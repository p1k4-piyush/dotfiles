return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function yank_and_paste_file_content(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local entry = action_state.get_selected_entry()
			if not entry then
				return
			end

			local filepath = entry.path or entry[1] -- Get the file path
			actions.close(prompt_bufnr) -- Close Telescope

			-- Read the file content
			local content = vim.fn.readfile(filepath)
			local text = table.concat(content, "\n")

			-- Yank the content into the default register
			vim.fn.setreg("+", text) -- For system clipboard
			vim.fn.setreg('"', text) -- Default unnamed register

			-- Paste the content at the cursor position
			vim.api.nvim_put(content, "l", false, true)
		end

		-- Telescope keymap
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "node_modules", "dist", "*.o", "*.out" },
				mappings = {
					i = {
						["<CR>"] = yank_and_paste_file_content, -- Ctrl+y in insert mode
					},
					n = {
						["<CR>"] = yank_and_paste_file_content, -- 'y' in normal mode
					},
				},
			},
		})

		-- vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })

		local builtin = require("telescope.builtin")

		vim.keymap.set(
			"n",
			"<leader>i",
			":Telescope find_files cwd=~/Documents/cpp_template_library<CR>",
			{ desc = "templates" }
		)
		-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end,
}
