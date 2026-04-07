-- ============================================================
-- Options — p1k4 Neovim 0.12
-- ============================================================

-- Leader keys are set in init.lua (before plugins load)

-- ── Indentation ────────────────────────────────────────────
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- ── Display ────────────────────────────────────────────────
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.wrap = false
vim.opt.pumheight = 15
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- ── Search ─────────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ── Mouse ──────────────────────────────────────────────────
vim.opt.mouse = "a"

-- ── Splits ─────────────────────────────────────────────────
vim.opt.splitright = true
vim.opt.splitbelow = true

-- ── Files / Undo ───────────────────────────────────────────
vim.opt.undofile = true
vim.opt.swapfile = false

-- ── Timing ─────────────────────────────────────────────────
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- ── Completion ─────────────────────────────────────────────
vim.opt.completeopt = "menu,menuone,noinsert,popup"

-- ── Misc ───────────────────────────────────────────────────
vim.opt.belloff = "all"
vim.opt.clipboard:append("unnamedplus")
vim.opt.cino:append("L0")

-- ── 0.12 Native Features ──────────────────────────────────
vim.opt.winborder = "rounded"

-- ── Background & Colors ───────────────────────────────────
vim.o.background = "dark"

-- ── Netrw (disabled — using Snacks explorer) ──────────────
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
