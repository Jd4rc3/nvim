return {
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
        },
        sections = { lualine_c = { require('auto-session.lib').current_session_name } },
      },
    }
  end,
}
