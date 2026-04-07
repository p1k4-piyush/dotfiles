-- Treesitter — syntax highlighting, indentation, folding
-- New nvim-treesitter (main branch) API for Neovim 0.12

-- Install parsers
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Ensure required parsers are installed
require("nvim-treesitter").install({
	"cpp", "c", "python", "lua", "vim", "vimdoc", "query",
	"elixir", "heex", "javascript", "html",
})

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- Folding via treesitter (0.12 native function)
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
