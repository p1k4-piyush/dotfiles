-- Flash.nvim — motion plugin with labeled jump targets
require("flash").setup()

local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
map({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
map("o", "r", function() require("flash").remote() end, { desc = "Flash Remote" })
