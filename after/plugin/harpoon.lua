local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = 'Add file to harpoon' })
vim.keymap.set('n', '<leader>hp', ui.toggle_quick_menu, { desc = 'Preview harpoon' })
vim.keymap.set('n', '<leader>hq', function() ui.nav_file(1) end, { desc = 'Navigate to file 1' })
vim.keymap.set('n', '<leader>hw', function() ui.nav_file(2) end, { desc = 'Navigate to file 2' })
vim.keymap.set('n', '<leader>he', function() ui.nav_file(3) end, { desc = 'Navigate to file 3' })
vim.keymap.set('n', '<leader>hu', function() ui.nav_file(4) end, { desc = 'Navigate to file 4' })
