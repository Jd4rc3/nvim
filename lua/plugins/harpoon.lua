return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  commit = '0378a6c',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    ---@diagnostic disable-next-line: missing-parameter
    harpoon.setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Append to harpoon list' })

    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle quick menu' })

    vim.keymap.set('n', '<M-q>', function()
      harpoon:list():select(1)
    end, { desc = 'Select harpoon item 1' })
    vim.keymap.set('n', '<M-w>', function()
      harpoon:list():select(2)
    end, { desc = 'Select harpoon item 2' })
    vim.keymap.set('n', '<M-e>', function()
      harpoon:list():select(3)
    end, { desc = 'Select harpoon item 3' })
    vim.keymap.set('n', '<M-r>', function()
      harpoon:list():select(4)
    end, { desc = 'Select harpoon item 4' })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<M-p>', function()
      harpoon:list():prev()
    end, { desc = 'Toggle previous stored buffer within Harpoon list' })

    vim.keymap.set('n', '<M-n>', function()
      harpoon:list():next()
    end, { desc = 'Toggle next stored buffer within Harpoon list' })
  end,
}
