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
    },
    {
        "catppuccin/nvim", 
        name = "catppuccin",
    },
    {
        "rebelot/kanagawa.nvim",
    },
    {
        "EdenEast/nightfox.nvim",
    },
    {
        "sainnhe/everforest",
    },
    {
        "rose-pine/neovim", 
        name = "rose-pine",
    },
    {
        "xiyaowong/transparent.nvim",
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
    },
    {
        'saghen/blink.nvim',
        build = 'cargo build --release', -- for delimiters
        keys = {
        	-- chartoggle
    	    {
                '<C-;>',
                function()
                  	require('blink.chartoggle').toggle_char_eol(';')
                    end,
                mode = { 'n', 'v' },
                desc = 'Toggle ; at eol',
        	},
        	{
	            ',',
                function()
            	  	require('blink.chartoggle').toggle_char_eol(',')
                    end,
                mode = { 'n', 'v' },
                desc = 'Toggle , at eol',
        	},

        	-- tree
        	{ '<C-e>', '<cmd>BlinkTree reveal<cr>', desc = 'Reveal current file in tree' },
        	{ '<leader>E', '<cmd>BlinkTree toggle<cr>', desc = 'Reveal current file in tree' },
        	{ '<leader>e', '<cmd>BlinkTree toggle-focus<cr>', desc = 'Toggle file tree focus' },
        },
        -- all modules handle lazy loading internally
        lazy = false,
        opts = {
            chartoggle = { enabled = true },
            indent = { enabled = true },
            tree = { enabled = false }
        },
    },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { 
                -- preset = 'default'
                ['<C-a>'] = { 'select_and_accept' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'Iosevka'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { 
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
                menu = {
                    auto_show = true,
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { "kind_icon" }, { "label", gap = 0 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
                ghost_text = {
                    enabled = true,
                    show_with_menu = true,
                },
    
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
    {
        "xzbdmw/colorful-menu.nvim",
        config = function()
            -- You don't need to set these options.
            require("colorful-menu").setup({
                ls = {
                    lua_ls = {
                        -- Maybe you want to dim arguments a bit.
                        arguments_hl = "@comment",
                    },
                    gopls = {
                        -- By default, we render variable/function's type in the right most side,
                        -- to make them not to crowd together with the original label.
    
                        -- when true:
                        -- foo             *Foo
                        -- ast         "go/ast"

                        -- when false:
                        -- foo *Foo
                        -- ast "go/ast"
                        align_type_to_right = true,
                        -- When true, label for field and variable will format like "foo: Foo"
                        -- instead of go's original syntax "foo Foo". If align_type_to_right is
                        -- true, this option has no effect.
                        add_colon_before_type = false,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/37
                        preserve_type_when_truncate = true,
                    },
                    -- for lsp_config or typescript-tools
                    ts_ls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/43
                        extra_info_hl = "@comment",
                    },
                    vtsls = {
                        -- false means do not include any extra info,
                        -- see https://github.com/xzbdmw/colorful-menu.nvim/issues/43
                        extra_info_hl = "@comment",
                    },
                    ["rust-analyzer"] = {
                        -- Such as (as Iterator), (use std::io).
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/37
                        preserve_type_when_truncate = true,
                    },
                    clangd = {
                        -- Such as "From <stdio.h>".
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                        -- the hl group of leading dot of "•std::filesystem::permissions(..)"
                        import_dot_hl = "@comment",
                        -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/37
                        preserve_type_when_truncate = true,
                    },
                    zls = {
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                    },
                    roslyn = {
                        extra_info_hl = "@comment",
                    },
                    dartls = {
                        extra_info_hl = "@comment",
                    },
                    -- The same applies to pyright/pylance
                    basedpyright = {
                        -- It is usually import path such as "os"
                        extra_info_hl = "@comment",
                    },
                    -- If true, try to highlight "not supported" languages.
                    fallback = true,
                    -- this will be applied to label description for unsupport languages
                    fallback_extra_info_hl = "@comment",
                },
                -- If the built-in logic fails to find a suitable highlight group for a label,
                -- this highlight is applied to the label.
                fallback_highlight = "@variable",
                -- If provided, the plugin truncates the final displayed text to
                -- this width (measured in display cells). Any highlights that extend
                -- beyond the truncation point are ignored. When set to a float
                -- between 1 and 1, it'll be treated as percentage of the width of
                -- the window: math.floor(max_width * vim.api.nvim_win_get_width(1))
                -- Default 60.
                max_width = 60,
            })
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        lazy = false,

        -- For blink.cmp's completion
        -- source
        dependencies = {
            "saghen/blink.cmp"
        },
    },
    {
        "ellisonleao/gruvbox.nvim",
    },
    {
        "sainnhe/gruvbox-material",
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
    -- {
    --     "smjonas/inc-rename.nvim",
    --     config = function()
    --         require("inc_rename").setup()
    --         vim.keymap.set("n", "<leader>r", function()
    --             return ":IncRename " .. vim.fn.expand("<cword>")
    --             end, { expr = true, silent = true })
    --         end,    
    -- },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
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
            -- vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
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
            image = { enabled = true},
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
    -- {
    --     "neovim/nvim-lspconfig",
    --     config = function()
    --         local lspconfig = require("lspconfig")
    --         lspconfig.clangd.setup({})
    --     end
    -- },
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
    -- {
    --     "3rd/image.nvim",
    --     dependencies = { "luarocks.nvim" },
    --     opts = {}
    -- }
}, {
    checker = { enabled = true }, -- Automatically check for plugin updates
})
