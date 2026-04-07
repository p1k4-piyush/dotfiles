-- Blink.nvim — chartoggle module
require("blink").setup({
	chartoggle = { enabled = true },
	tree = { enabled = false },
})

-- Chartoggle keymaps
local map = vim.keymap.set
map({ "n", "v" }, "<C-;>", function()
	require("blink.chartoggle").toggle_char_eol(";")
end, { desc = "Toggle ; at EOL" })

map({ "n", "v" }, ",", function()
	require("blink.chartoggle").toggle_char_eol(",")
end, { desc = "Toggle , at EOL" })
