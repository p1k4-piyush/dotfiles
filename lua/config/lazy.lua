-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit...", "ErrorMsg" },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    -- Plugins go here
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
    },
    {
        'b0o/incline.nvim',
        config = function()
            local helpers = require 'incline.helpers'
            local devicons = require 'nvim-web-devicons'
            require('incline').setup {
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if filename == '' then
                        filename = '[No Name]'
                        end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                      ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
                      ' ',
                      { filename, gui = modified and 'bold,italic' or 'bold' },
                      ' ',
                      guibg = '#44406e',
                    }
                    end,
            }
            end,
            -- require('incline').setup()
            -- end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
    },
    {
        "catgoose/nvim-colorizer.lua",
        event = "BufReadPre",
        opts = { -- set to setup table
        },
        config = function()
            require("colorizer").setup()
            end,
    },
    {
        "petertriho/nvim-scrollbar",
        config = function()
            require("scrollbar").setup()
            end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",        -- Completion for buffer words
            "hrsh7th/cmp-path",          -- Completion for file paths
            "hrsh7th/cmp-nvim-lsp",      -- Completion from LSP
            "hrsh7th/cmp-nvim-lua",      -- Completion for Lua APIs
            "saadparwaiz1/cmp_luasnip",  -- Snippet completion
            "L3MON4D3/LuaSnip",          -- Snippet engine
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                snippet = {
                    expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                    end,
                },
            })    
            end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require('treesitter-context').setup()
            end,
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
            end,
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gwrite", "Gread", "Gstatus", "Gblame" },
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
            vim.keymap.set("n", "<leader>r", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
                end, { expr = true, silent = true })
            end,    
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", "dist", "*.o", "*.out" },
                },
            })
            vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
        end,
    },
    {
        "tpope/vim-commentary",
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    globalstatus = true,
                    theme = "auto",
                },
            })
        end,
    },
    {
        "searleser97/cpbooster.vim",
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                    {
                        section = "terminal",
                        cmd = "pokemon-colorscripts -n pikachu -f belle --no-title -b; sleep .1",
                        random = 10,
                        pane = 2,
                        indent = 4,
                        height = 30,
                    },
                },
            },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
              "<leader>?",
              function()
              require("which-key").show({ global = false })
              end,
              desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({})
        end
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        opts = {}
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        dependencies = { "luarocks.nvim" },
        opts = {}
    }
}, {
    checker = { enabled = true }, -- Automatically check for plugin updates
})
