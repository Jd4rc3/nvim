local M = {}

--- Get current buffer size
---@return {width: number, height: number}
M.get_buf_size = function()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

--- Get the dynamic terminal size in cells
---@param direction number
---@param size number
---@return integer
M.get_dynamic_terminal_size = function(direction, size)
  if direction ~= 'float' and tostring(size):find('.', 1, true) then
    size = math.min(size, 1.0)
    local buf_sizes = M.get_buf_size()
    local buf_size = direction == 'horizontal' and buf_sizes.height or buf_sizes.width
    return buf_size * size
  else
    return size
  end
end

M.set_terminal_keymaps = function()
  local opts = { buffer = 0 }
  local horizontal = '<Cmd>ToggleTerm size=' .. M.get_dynamic_terminal_size('horizontal', 0.3) .. ' direction=horizontal<CR>'
  local vertical = '<Cmd>ToggleTerm size=' .. M.get_dynamic_terminal_size('vertical', 0.4) .. ' direction=vertical<CR>'
  local float = '<Cmd>ToggleTerm direction=float<CR>'

  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('n', '<M-1>', horizontal)
  vim.keymap.set('n', '<M-2>', vertical)
  vim.keymap.set('n', '<M-3>', float)
end

M.lazygit = function()
  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new {
    cmd = 'lazygit',
    dir = 'git_dir',
    direction = 'float',
    float_opts = {
      border = 'double',
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd 'startinsert!'
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function(term)
      vim.cmd 'startinsert!'
    end,
  }

  local function _lazygit_toggle()
    lazygit:toggle()
  end

  vim.keymap.set('n', '<M-g>', _lazygit_toggle, { noremap = true, silent = true })
end

M.windows_shell_config = function()
  -- "-Nologo -Noprofile -Executionpolicy remotesigned -Command [console]::inputencoding=[console]::outputencoding=[system.text.encoding]::utf8;"
  if vim.loop.os_uname().sysname == 'Windows_NT' then
    -- local pwsh = 'pwsh -NoLogo -NoProfile'

    -- vim.opt.shell = vim.fn.executable 'pwsh' and pwsh or 'powershell'
    -- vim.opt.shellcmdflag =
    --   '-NoLogo -NoProfile -ExecutionPolicy remotesigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    -- vim.opt.vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
    -- vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    -- vim.opt.shellquote = ''
    -- vim.opt.shellxquote = ''

    vim.opt.shell = "C:\\Users\\arce\\scoop\\apps\\git\\current\\bin\\bash.exe"
    vim.opt.shellcmdflag = "-s"
  end
end

M.setup = function()
  M.windows_shell_config()

  require('toggleterm').setup {
    start_in_insert = true,
    shell = vim.opt.shell._value,
    float_opts = {
      border = 'curved',
      width = math.ceil(vim.o.columns * 0.8),
      height = math.ceil(vim.o.columns * 0.2),
    },
  }

  M.lazygit()
  M.set_terminal_keymaps()
end

return {
  'akinsho/toggleterm.nvim',
  branch = 'main',
  commit = '12cba0a1967b4f3f31903484dec72a6100dcf515',
  config = function()
    require('toggleterm').setup()
    M.setup()
  end,
}
