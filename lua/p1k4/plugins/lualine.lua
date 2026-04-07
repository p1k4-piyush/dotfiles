-- Lualine — statusline
require("lualine").setup({
	options = {
		globalstatus = true,
		theme = "auto",
	},
	sections = {
		lualine_c = {
			"filename",
			{
				function()
					return vim.diagnostic.status() or ""
				end,
				cond = function()
					return vim.diagnostic.status ~= nil
				end,
			},
		},
		lualine_x = {
			{
				function()
					local status = vim.ui.progress_status and vim.ui.progress_status() or nil
					return status or ""
				end,
			},
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})
