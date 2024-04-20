local M = {}

M.setup = function()
  require('lf').setup {
    default_action = 'drop',
    default_actions = {
      ['<C-t>'] = 'tabedit',
      ['<C-x>'] = 'split',
      ['<C-v>'] = 'vsplit',
      ['<C-o>'] = 'tab drop',
    },
    escape_quit = false,
    winblend = 10,
    dir = '',
    direction = 'float',
    border = 'rounded',
    height = 30,
    width = 100,
    focus_on_open = true,
    mappings = true,
    tmux = true,
    default_file_manager = true, -- make lf default file manager
    disable_netrw_warning = true, -- don't display a message when opening a directory with `default_file_manager` as true
    highlights = { -- highlights passed to toggleterm
      Normal = { link = 'Normal' },
      NormalFloat = { link = 'Normal' },
      FloatBorder = { guifg = '#ffffff', guibg = '#ffffff' },
    },
    -- Layout configurations
    layout_mapping = '<M-u>', -- resize window with this key
    views = { -- window dimensions to rotate through
      { width = 0.800, height = 0.800 },
      { width = 0.600, height = 0.600 },
      { width = 0.950, height = 0.950 },
      { width = 0.500, height = 0.500, col = 0, row = 0 },
      { width = 0.500, height = 0.500, col = 0, row = 0.5 },
      { width = 0.500, height = 0.500, col = 0.5, row = 0 },
      { width = 0.500, height = 0.500, col = 0.5, row = 0.5 },
    },
  }

  vim.g.lf_netrw = 1

  vim.keymap.set('n', '<M-o>', '<Cmd>Lf<CR>')

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LfTermEnter',
    callback = function(a)
      vim.api.nvim_buf_set_keymap(a.buf, 't', 'q', 'q', { nowait = true })
    end,
  })
end

return {
  'lmburns/lf.nvim',
  enabled = false,
  config = function()
    M.setup()
  end,
}
