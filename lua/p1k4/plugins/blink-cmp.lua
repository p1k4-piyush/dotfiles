-- Blink.cmp — completion engine
require("blink.cmp").setup({
	keymap = {
		preset = "super-tab", -- Tab=accept, S-Tab=prev, C-n/C-p nav
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		menu = {
			auto_show = true,
			draw = {
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
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
