return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("gitsigns").setup()
		require("scrollbar.handlers.gitsigns").setup()
	end,
}
