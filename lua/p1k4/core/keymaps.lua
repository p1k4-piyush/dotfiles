-- ============================================================
-- Keymaps — p1k4 Neovim 0.12
-- Leader is set in init.lua
-- ============================================================

local map = vim.keymap.set

-- ── Clipboard ──────────────────────────────────────────────
map("n", "y", '"+y', { desc = "Yank to clipboard" })
map("n", "p", '"+p', { desc = "Paste from clipboard" })
map("v", "y", '"+y', { desc = "Yank to clipboard" })
map("v", "p", '"+p', { desc = "Paste from clipboard" })

-- ── Black-hole delete (don't clobber clipboard) ────────────
map("n", "d", '"_d', { desc = "Delete (black-hole)" })
map("v", "d", '"_d', { desc = "Delete (black-hole)" })
map("n", "dd", '"_dd', { desc = "Delete line (black-hole)" })
map("v", "dd", '"_dd', { desc = "Delete line (black-hole)" })
map("n", "<Del>", '"_d', { desc = "Delete (black-hole)" })
map("v", "<Del>", '"_d', { desc = "Delete (black-hole)" })

-- ── General ────────────────────────────────────────────────
map("i", "jj", "<Esc>", { noremap = true, desc = "Exit insert mode" })
map("n", "<C-a>", "<Esc>ggVG<CR>", { noremap = true, desc = "Select all" })
map("n", "<leader>y", ":%y+<CR>", { noremap = true, desc = "Yank entire file" })

-- ── Diagnostics ────────────────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- ── LSP (supplements 0.12 defaults: grn, gra, grr, gri, gO) ──
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })

