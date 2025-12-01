return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "OXY2DEV/markview.nvim" },
	lazy = false,
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html" },
			sync_install = false,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			fold = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					node_decremental = "grm",
				},
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
			},
		})
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "nvim_treesitter#foldexpr()"
		vim.o.foldlevel = 99 -- Start with all folds open
	end,
}
