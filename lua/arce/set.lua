-- Set highlight on search
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- File Format
vim.o.fileformat = 'unix'

-- White space chars
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.guicursor = ''

-- vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'
vim.opt.colorcolumn = '80'

--vim.o.shell = "C:\\Program Files\\PowerShell\\7-preview\\pwsh.exe"

P = function(v)
  local content = vim.inspect(v)
  print(content)
  vim.fn.setreg('+', content)
  return v
end

RELOAD = function(...)
  return require('plenary.reload').reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

vim.cmd [[
let g:clipboard = {
\   'name': 'WslClipboard',
\   'copy': {
\      '+': 'win32yank.exe -i --crlf',
\      '*': 'win32yank.exe -i --crlf',
\    },
\   'paste': {
\      '+': 'win32yank.exe -O --lf',
\      '*': 'win32yank.exe -O --lf',
\   },
\   'cache_enabled': 0,
\ }
  ]]

vim.cmd [[set winbar=%=%m%B\ %f%=]]
