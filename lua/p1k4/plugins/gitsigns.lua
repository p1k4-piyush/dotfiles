-- Gitsigns.nvim — git signs in the gutter
require("gitsigns").setup()

-- Integrate with scrollbar (if available)
local ok, scrollbar_gitsigns = pcall(require, "scrollbar.handlers.gitsigns")
if ok then
	scrollbar_gitsigns.setup()
end
