vim.lsp.config.clangd = {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	root_markers = { "compile_commands.json", "compile_flags.txt" },
	filetypes = { "c", "cpp" },
}
vim.lsp.config.pylsp = {
	cmd = { "pylsp" }, -- or full path: "/path/to/.venv/bin/pylsp"
	root_markers = { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git" },
	filetypes = { "python" },
	settings = {
		-- pylsp plugin settings (enable/disable plugins as you prefer)
		pylsp = {
			plugins = {
				pyflakes = { enabled = true },
				pycodestyle = { enabled = false }, -- disable if you use ruff/black
				pyls_mypy = { enabled = false },
				yapf = { enabled = false },
				black = { enabled = true }, -- enable black if installed
				pylsp_rope = { enabled = false }, -- example: disable rope if not used
			},
		},
	},
}

vim.lsp.enable({ "clangd" })
vim.lsp.enable({ "pylsp" })

vim.diagnostic.config({
	-- Use the default configuration
	virtual_lines = true,

	-- Alternatively, customize specific options
	-- virtual_lines = {
	--  -- Only show virtual line diagnostics for the current cursor line
	--  current_line = true,
	-- },
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
