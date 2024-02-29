---@diagnostic disable: redundant-value, undefined-global
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'tabs',
        indicator = {
          style = 'underline',
        },
      },
    }
  end,
}
