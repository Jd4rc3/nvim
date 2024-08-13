-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  version='^3.13.2',
  dependencies = {
    {
      'echasnovski/mini.nvim',
      config = function()
        local MiniIcons = require 'mini.icons'
        MiniIcons.setup()
      end,
    },
  },
  opts = {},
  config = function()
    local wk = require 'which-key'
    wk.setup()
    wk.add {
      { '<leader>g', group = '[G]it' }, -- group
      { '<leader>h', group = '[H]unk' }, -- group
      { '<leader>r', group = '[R]ename' }, -- group
      { '<leader>s', group = '[S]earch' }, -- group
      { '<leader>t', group = '[T]oggle' }, -- group
      { '<leader>w', group = '[W]orkspace' }, -- group
      { '<leader>d', group = '[D]ocument' }, -- group
      { '<leader>c', group = '[C]ode' }, -- group
      {
        '<leader>b',
        group = 'buffers',
        expand = function()
          return require('which-key.extras').expand.buf()
        end,
      },
    }
  end,
}
