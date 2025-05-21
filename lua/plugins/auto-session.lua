return {
  'rmagatti/auto-session',
  commit = '322d82f',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- require('lualine').setup {
      --   options = {
      --     theme = 'catppuccin',
      --   },
      --   sections = { lualine_c = { require('auto-session.lib').current_session_name } },
      -- },
    }
  end,
}
