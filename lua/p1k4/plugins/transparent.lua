return {
    "xiyaowong/transparent.nvim",
    config = function()
        -- Optional, you don't have to run setup.
        require("transparent").setup({
            -- table: default groups
            groups = {
                'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
                'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
                'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
                'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
                'EndOfBuffer',
            },
            -- table: additional groups that should be cleared
            extra_groups =  {
                "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
            },
            -- table: groups you don't want to clear
            exclude_groups = {},
            -- function: code to be executed after highlight groups are cleared
            -- Also the user event "TransparentClear" will be triggered
            on_clear = function() end,
        })
        require('transparent').clear_prefix('lualine_c')
        require('transparent').clear_prefix('incline')
    end,
}   

-- return {
--     "xiyaowong/transparent.nvim",
--     config = function()
--         require('transparent').clear_prefix('lualine_c')
--         require('transparent').clear_prefix('incline')
--     end,
-- }
