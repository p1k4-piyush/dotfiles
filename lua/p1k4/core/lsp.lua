vim.lsp.config.clangd = {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	root_markers = { "compile_commands.json", "compile_flags.txt" },
	filetypes = { "c", "cpp" },
}

vim.lsp.enable({ "clangd" })
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
