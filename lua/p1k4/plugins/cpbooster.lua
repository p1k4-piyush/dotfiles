-- cpbooster.vim — competitive programming
-- No setup() needed — plugin provides commands directly

local map = vim.keymap.set

map("n", "<leader>q", function()
	vim.cmd("Test")
	vim.cmd("vertical resize 150")
end, { silent = true, desc = "CP Test" })

map("n", "<leader>x", function()
	vim.cmd("Debug -t 1")
	vim.cmd("vertical resize 150")
end, { silent = true, desc = "CP Debug (timeout)" })

map("n", "<leader>z", function()
	vim.cmd("Debug")
	vim.cmd("vertical resize 100")
end, { silent = true, desc = "CP Debug" })
