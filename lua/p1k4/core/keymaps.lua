-- Key mappings for clipboard copy/paste
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('v', 'y', '"+y')
vim.keymap.set('v', 'p', '"+p')
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('v', 'dd', '"_dd')
vim.keymap.set("n", "<Del>", '"_d')
vim.keymap.set("v", "<Del>", '"_d')

vim.g.mapleader = " "

vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<Esc>ggVG<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', ':%y+<CR>', { noremap = true })

-- vim.keymap.set("n", "<leader>tc", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = true })

vim.api.nvim_set_keymap('n', '<leader>q', ':Test<CR>:vertical resize 100<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':Debug -t 1<CR>:vertical resize 100<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>z', ':Debug <CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>p', ':lua Snacks.picker.files()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua Snacks.picker.buffers()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':lua Snacks.picker.command_history()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':lua Snacks.notifier.show_history()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':lua Snacks.explorer()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':lua Snacks.terminal.toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rg', ':lua Snacks.picker.registers()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>u', ':lua Snacks.picker.undo()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':lua Snacks.picker.colorschemes()<CR>', { noremap = true, silent = true })

-- vim.api.nvim_set_keymap('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>i', ':Telescope find_files cwd=~/cpp_template_library<CR>', { desc = 'templates'})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.api.nvim_set_keymap('n', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true })


