-- ============================================================
-- LSP — p1k4 Neovim 0.12
-- ============================================================

-- ── clangd (C/C++) ─────────────────────────────────────────
vim.lsp.config.clangd = {
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	root_markers = { "compile_commands.json", "compile_flags.txt" },
	filetypes = { "c", "cpp" },
}

-- ── pylsp (Python) ─────────────────────────────────────────
vim.lsp.config.pylsp = {
	cmd = { "pylsp" },
	root_markers = { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				pyflakes = { enabled = true },
				pycodestyle = { enabled = false },
				pyls_mypy = { enabled = false },
				yapf = { enabled = false },
				black = { enabled = true },
				pylsp_rope = { enabled = false },
			},
		},
	},
}

-- ── lua_ls (Lua / Neovim config) ───────────────────────────
vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
}

-- ── Enable servers ─────────────────────────────────────────
vim.lsp.enable({ "clangd", "pylsp", "lua_ls" })

-- ── Diagnostics config ────────────────────────────────────
vim.diagnostic.config({
	virtual_lines = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	severity_sort = true,
})
