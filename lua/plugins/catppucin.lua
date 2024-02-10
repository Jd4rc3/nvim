return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = true,     -- shows the '~' characters after the end of buffers
      term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,             -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15,           -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,             -- Force no italic
      no_bold = false,               -- Force no bold
      no_underline = false,          -- Force no underline
      styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { 'italic' },     -- Change the style of comments
        conditionals = { 'italic' },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        fidget = true,
        treesitter = true,
        harpoon = true,
        noice = true,
        dap = true,
        dap_ui = true,
        mason = true,
        notify = false,
        which_key = true,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        sandwich = true,
      },
    }

    -- setup must be called before loading
    local sign = vim.fn.sign_define
    sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', { text = '●', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    vim.cmd.colorscheme 'catppuccin'
  end,
}
