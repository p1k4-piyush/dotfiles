-- nvim-notify — notification backend
local notify = require("notify")
notify.setup({
	background_colour = "#000000",
	timeout = 3000,
	stages = "fade",
	render = "default",
	max_width = 50,
})
vim.notify = notify
