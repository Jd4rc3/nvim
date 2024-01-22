return { -- This plugin
    'Zeioth/compiler.nvim',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    dependencies = { 'stevearc/overseer.nvim' },
    opts = {},
    config = function()
        -- Open compiler
        vim.keymap.set('n', '<F6>', '<cmd>CompilerOpen<cr>',
            { noremap = true, silent = true, desc = 'Open compiler menu' })

        -- Redo last selected option
        vim.keymap.set(
            'n',
            '<S-F6>',
            '<cmd>CompilerStop<cr>' -- (Optional, to dispose all tasks before redo)
            .. '<cmd>CompilerRedo<cr>',
            { noremap = true, desc = 'Redo last selected compiler option', silent = true }
        )

        -- Toggle compiler results
        vim.keymap.set('n', '<S-F7>', '<cmd>CompilerToggleResults<cr>',
            { desc = 'Toggle compiler results', noremap = true, silent = true })
    end,
}, { -- The task runner we use
    'stevearc/overseer.nvim',
    commit = '400e762648b70397d0d315e5acaf0ff3597f2d8b',
    cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
    opts = {
        task_list = {
            direction = 'bottom',
            min_height = 25,
            max_height = 25,
            default_detail = 1,
        },
    },
}
