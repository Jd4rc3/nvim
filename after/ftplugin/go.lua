vim.keymap.set('n', '<F9>', function() require('dap-go').debug_test() end,
    { noremap = true, silent = true, desc = 'Debug test' })


vim.keymap.set('n', '<S-F9>', function() require('dap-go').debug_last() end,
    { noremap = true, silent = true, desc = 'Debug test' })
