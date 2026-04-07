-- Which-key.nvim — keybinding hints
require("which-key").setup()

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
