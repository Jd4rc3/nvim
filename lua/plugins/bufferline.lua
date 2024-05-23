---@diagnostic disable: redundant-value, undefined-global
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  enabled = false,
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'tabs',
        indicator = {
          style = 'none',
        },
      },
    }
  end,
}
