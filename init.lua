-- ============================================================
-- Neovim 0.12 Config — p1k4
-- Uses native vim.pack plugin manager
-- ============================================================

-- Set leader keys FIRST (must happen before any plugin loading)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- GitHub URL helper
local gh = function(x) return "https://github.com/" .. x end

-- ============================================================
-- PLUGIN DECLARATIONS (vim.pack.add)
-- ============================================================
vim.pack.add({
  -- ── Dependencies ──────────────────────────────────────────
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-tree/nvim-web-devicons"),

  -- ── Completion ────────────────────────────────────────────
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.0") },
  gh("saghen/blink.nvim"),
  gh("rafamadriz/friendly-snippets"),
  gh("xzbdmw/colorful-menu.nvim"),

  -- ── Treesitter ────────────────────────────────────────────
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-context"),

  -- ── LSP / Diagnostics ────────────────────────────────────
  gh("folke/trouble.nvim"),

  -- ── UI ────────────────────────────────────────────────────
  gh("folke/noice.nvim"),
  gh("rcarriga/nvim-notify"),
  gh("nvim-lualine/lualine.nvim"),
  gh("b0o/incline.nvim"),
  gh("xiyaowong/transparent.nvim"),
  gh("folke/which-key.nvim"),
  gh("petertriho/nvim-scrollbar"),

  -- ── Editor ────────────────────────────────────────────────
  gh("stevearc/conform.nvim"),
  gh("windwp/nvim-autopairs"),
  gh("kylechui/nvim-surround"),
  gh("folke/todo-comments.nvim"),
  gh("folke/flash.nvim"),
  gh("catgoose/nvim-colorizer.lua"),

  -- ── Git ───────────────────────────────────────────────────
  gh("lewis6991/gitsigns.nvim"),
  gh("kdheepak/lazygit.nvim"),
  gh("tpope/vim-fugitive"),

  -- ── Snacks (dashboard, explorer, picker, etc.) ────────────
  gh("folke/snacks.nvim"),

  -- ── Markdown ──────────────────────────────────────────────
  gh("OXY2DEV/markview.nvim"),

  -- ── Competitive Programming ───────────────────────────────
  gh("searleser97/cpbooster.vim"),

  -- ── Colorschemes ──────────────────────────────────────────
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  gh("folke/tokyonight.nvim"),
  gh("sainnhe/everforest"),
  gh("sainnhe/gruvbox-material"),
  gh("ellisonleao/gruvbox.nvim"),
  gh("rebelot/kanagawa.nvim"),
  gh("EdenEast/nightfox.nvim"),
  { src = gh("rose-pine/neovim"), name = "rose-pine" },
  -- NEW popular colorschemes
  gh("scottmckendry/cyberdream.nvim"),
  gh("Mofiqul/dracula.nvim"),
  gh("navarasu/onedark.nvim"),
  gh("projekt0n/github-nvim-theme"),
})

-- ============================================================
-- BUILD HOOKS (post-install/update actions)
-- ============================================================
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    -- Rebuild treesitter parsers after install/update
    if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
      vim.cmd("TSUpdate")
    end
  end,
})

-- ============================================================
-- CONVENIENCE COMMANDS
-- ============================================================
vim.api.nvim_create_user_command("Pack", function(opts)
  local subcmd = opts.fargs[1]
  if subcmd == "update" then
    vim.pack.update()
  elseif subcmd == "status" then
    print(vim.inspect(vim.pack.get()))
  elseif subcmd == "install" then
    print("vim.pack auto-installs on startup. Run :restart to install new plugins.")
  else
    print("Usage: :Pack [install|update|status]")
  end
end, {
  nargs = 1,
  complete = function() return { "install", "update", "status" } end,
})


-- ============================================================
-- LOAD CONFIG
-- ============================================================
require("p1k4.core")    -- options, keymaps, autocmds, lsp
require("p1k4.plugins") -- all plugin setup() calls
