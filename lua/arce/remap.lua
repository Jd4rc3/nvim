local function delete_other_buffers()
  vim.cmd '%bd'
  vim.cmd 'e#'
end

-- help me to write delete all left tabs and buffers
local function delete_left_tabs()
  local current_tab = vim.api.nvim_get_current_tabpage()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    if tab < current_tab then
      vim.cmd('tabclose ' .. tab)
    end
  end
end

local function delete_right_tabs()
  local current_tab = vim.api.nvim_get_current_tabpage()
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    if tab > current_tab then
      vim.cmd('tabclose ' .. tab)
    end
  end
end

local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- -- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])

-- -- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- -- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format buffer' })

vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>zz', { desc = 'Next in QuickFix' })
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>zz', { desc = 'Previous in QuickFix' })
vim.keymap.set('n', '<leader>j', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lprev<CR>zz')

vim.keymap.set('n', '<M-s>', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace current word (Using substituve)' })
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('i', 'jk', '<ESC>', default_opts)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', default_opts)
vim.keymap.set('v', 'p', '"_dP', default_opts)
vim.keymap.set('n', '<S-h>', ':tprevious<CR>', default_opts)
vim.keymap.set('n', '<S-l>', ':tnext<CR>', default_opts)

vim.keymap.set('n', '<Left>', ':vertical resize +1<CR>', default_opts)
vim.keymap.set('n', '<Right>', ':vertical resize -1<CR>', default_opts)
vim.keymap.set('n', '<Up>', ':resize -1<CR>', default_opts)
vim.keymap.set('n', '<Down>', ':resize +1<CR>', default_opts)

-- remap ctrl w h j k to move between windows for ctrl h j k l
vim.keymap.set('n', '<C-h>', '<C-w>h', default_opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', default_opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', default_opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', default_opts)

--Terminal remaps
vim.keymap.set('n','<leader>tv',':vs | wincmd l | term<CR>',default_opts)
vim.keymap.set('n','<leader>th',':sp | wincmd j | term<CR>',default_opts)

-- Tabs remaps
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', default_opts)
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', default_opts)
vim.keymap.set('n', '<F4>', '<cmd>tabclose<cr>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tN', '<cmd>tabmove +1<cr>', { desc = 'Move tab to right' })
vim.keymap.set('n', '<leader>tP', '<cmd>tabmove -1<cr>', { desc = 'Move tab to left' })
vim.keymap.set('n', '<leader>tda', '<cmd>tabonly<cr>', { desc = 'Delete all tabs but current' })
vim.keymap.set('n', '<leader>tdl', delete_left_tabs, { desc = 'Delete all left tabs' })
vim.keymap.set('n', '<leader>tdr', delete_right_tabs, { desc = 'Delete all right tabs' })

-- buffers rempas
vim.keymap.set('n', '<leader>bda', delete_other_buffers, { desc = 'Delete all buffers but current' })
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bc', '<cmd>bd<cr>', { desc = 'Delete buffer' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
