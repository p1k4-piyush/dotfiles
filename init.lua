require("config.lazy")

-- Basic settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ruler = true
vim.opt.mouse = 'a'
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.shellslash = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cino:append('L0')
vim.opt.syntax = 'on'
vim.opt.filetype = 'indent'  
vim.opt.belloff = 'all'

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--background-index' },
  root_markers = { 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp' },
}

vim.lsp.enable({'clangd'})
vim.diagnostic.config({
  -- Use the default configuration
  virtual_lines = true

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


-- Key mappings for clipboard copy/paste
vim.keymap.set('n', 'y', '"+y')
vim.keymap.set('n', 'p', '"+p')
vim.keymap.set('v', 'y', '"+y')
vim.keymap.set('v', 'p', '"+p')
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('v', 'dd', '"_dd')
vim.keymap.set("n", "<Del>", '"_x')
vim.keymap.set("v", "<Del>", '"_d')

vim.opt.clipboard:append("unnamedplus")
vim.g.mapleader = " "

-- require'lspconfig'.clangd.setup{}

vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<Esc>ggVG<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', ':%y+<CR>', { noremap = true })

vim.api.nvim_create_user_command('I', function(opts)
  local path = vim.fn.expand("$HOME") .. "/cpp_template_library/" .. opts.args .. ".txt"
  vim.cmd("r " .. path)
end, { nargs = 1 })

vim.keymap.set("n", "<leader>[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

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

vim.api.nvim_set_keymap('n', '<leader>f', ':lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>i', ':Telescope find_files cwd=~/cpp_template_library<CR>', { desc = 'templates'})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


vim.api.nvim_set_keymap('n', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>\\', ':Commentary<CR>', { noremap = true, silent = true })


-- vim.o.background = "dark" 
vim.cmd[[colorscheme everforest]]


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
  ["rvim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})

vim.opt.termguicolors = true
require("bufferline").setup{}

vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.cpp',
  callback = function()
    local file_path = vim.fn.expand('%:p')  -- Get full file path
    if not string.match(file_path, '^' .. vim.fn.expand('~/Contests/')) then
      return  -- Exit if the file is not inside ~/Contests/
    end

    local lines = vim.fn.getline(1, '$')
    if #lines > 0 and string.match(lines[1], '^%s*//') then
      return  -- Exit if the first line is a comment
    end

    local lyrics = Select_Lyric()
    if lyrics ~= '' then
      local lyric_lines = vim.fn.split(lyrics, '\n')
      for i, line in ipairs(lyric_lines) do
        vim.fn.append(i - 1, '//  ' .. line)
      end
      vim.fn.append(#lyric_lines, '')
    end
  end
})

function Select_Lyric()
    local file = vim.fn.expand("/Users/piyushkeshan/lyrics.txt")
    if not vim.fn.filereadable(file) then
        print("Lyrics file not found")
        return ''
    end

    local content = vim.fn.readfile(file)
    local full_content = vim.fn.join(content, "\n")
    local lyrics = vim.fn.split(full_content, "\n\n")

    -- Debugging
    -- print("Content: " .. full_content)
    -- print("Lyrics List: " .. vim.fn.string(lyrics))

    if #lyrics == 0 then
        print("No valid lyrics found")
        return ''
    end

    math.randomseed(os.time())
    local idx = math.random(#lyrics)
    return lyrics[idx]
end



local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function yank_and_paste_file_content(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry then return end

    local filepath = entry.path or entry[1] -- Get the file path
    actions.close(prompt_bufnr) -- Close Telescope

    -- Read the file content
    local content = vim.fn.readfile(filepath)
    local text = table.concat(content, "\n")

    -- Yank the content into the default register
    vim.fn.setreg("+", text)  -- For system clipboard
    vim.fn.setreg('"', text)  -- Default unnamed register

    -- Paste the content at the cursor position
    vim.api.nvim_put(content, "l", false, true)
end

-- Telescope keymap
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<CR>"] = yank_and_paste_file_content, -- Ctrl+y in insert mode
            },
            n = {
                ["<CR>"] = yank_and_paste_file_content, -- 'y' in normal mode
            },
        },
    },
})


require('transparent').clear_prefix('lualine_c')
require('transparent').clear_prefix('incline')


vim.api.nvim_create_user_command("MakeTransparent", function()
  vim.cmd([[
    hi Normal guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi EndOfBuffer guibg=NONE ctermbg=NONE
    hi VertSplit guibg=NONE ctermbg=NONE
    hi SignColumn guibg=NONE ctermbg=NONE
    hi LineNr guibg=NONE ctermbg=NONE
    hi CursorLineNR guibg=NONE ctermbg=NONE
    hi TabLine guibg=NONE ctermbg=NONE
    hi TabLineFill guibg=NONE ctermbg=NONE
    hi TabLineSel guibg=NONE ctermbg=NONE
    hi WinBar guibg=NONE ctermbg=NONE
    hi WinBarNC guibg=NONE ctermbg=NONE
    hi Pmenu guibg=NONE ctermbg=NONE
    hi PmenuSel guibg=NONE ctermbg=NONE
    hi FloatBorder guibg=NONE ctermbg=NONE
    hi NormalFloat guibg=NONE ctermbg=NONE
  ]])
end, {})

vim.cmd("MakeTransparent")
