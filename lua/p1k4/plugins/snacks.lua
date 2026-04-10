-- Snacks.nvim — dashboard, explorer, picker, notifier, etc.
require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
			{
				section = "terminal",
				cmd = "pokemon-colorscripts -n pikachu -f belle --no-title -b",
				random = 10,
				pane = 2,
				indent = 4,
				height = 30,
			},
		},
	},
	explorer = { enabled = true },
	image = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	picker = { enabled = true },
	notifier = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

-- Snacks keymaps
local map = vim.keymap.set
map("n", "<leader>p", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>b", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>h", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>n", function() Snacks.notifier.show_history() end, { desc = "Notification History" })
map("n", "<leader>t", function() Snacks.explorer() end, { desc = "File Explorer" })
map("n", "<leader>k", function() Snacks.terminal.toggle() end, { desc = "Toggle Terminal" })
map("n", "<leader>rg", function() Snacks.picker.registers() end, { desc = "Registers" })
map("n", "<leader>u", function() Snacks.picker.undo() end, { desc = "Undo History" })
map("n", "<leader>c", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Live Grep" })
map("n", "<leader>i", function()
	Snacks.picker.files({
		cwd = vim.fn.expand("~/Documents/templates"),
		confirm = function(picker, item)
			picker:close()
			if not item then return end
			local filepath = item.file or item.path or item[1]
			if not filepath then return end
			local content = vim.fn.readfile(filepath)
			vim.api.nvim_put(content, "l", false, true)
		end,
	})
end, { desc = "CP Templates" })
