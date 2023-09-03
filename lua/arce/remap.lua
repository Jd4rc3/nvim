local function delete_other_buffers()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
            vim.cmd('bd ' .. buf)
        end
    end
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

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "<leader>vwm", function()
-- 	require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
-- 	require("vim-with-me").StopVimWithMe()
-- end)

-- -- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- -- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- -- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

-- vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- -- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/appdata/local/nvim/lua/arce/packer.lua<CR>");
-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- -- alpha2
vim.keymap.set("i", "jk", "<ESC>", default_opts)
vim.keymap.set("t", "jk", "<C-\\><C-n>", default_opts)
vim.keymap.set("v", "p", '"_dP', default_opts)
vim.keymap.set("n", "<S-h>", ":tprevious<CR>", default_opts)
vim.keymap.set("n", "<S-l>", ":tnext<CR>", default_opts)

vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", default_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", default_opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", default_opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", default_opts)

-- remap ctrl w h j k to move between windows for ctrl h j k l
vim.keymap.set("n", "<C-h>", "<C-w>h", default_opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", default_opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", default_opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", default_opts)

vim.keymap.set("n", "<Tab>", ":tabnext<CR>", default_opts)
vim.keymap.set("n", "<S-Tab>", ":tabnext<CR>", default_opts)
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tN", "<cmd>tabmove +1<cr>", { desc = "Move tab to right" })
vim.keymap.set("n", "<leader>tP", "<cmd>tabmove -1<cr>", { desc = "Move tab to left" })
vim.keymap.set("n", "<leader>tda", "<cmd>tabonly<cr>", { desc = "Delete all tabs but current" })
vim.keymap.set("n", "<leader>tdl", delete_left_tabs, { desc = "Delete all left tabs" })
vim.keymap.set("n", "<leader>tdr", delete_right_tabs, { desc = "Delete all right tabs" })

vim.keymap.set("n", "<leader>bda", delete_other_buffers, { desc = "Delete all buffers but current" })
