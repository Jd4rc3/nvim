return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  branch = 'main',
  commit = '6efc446',
  opts = {
    position = 'bottom', -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = '', -- icon used for open folds
    fold_closed = '', -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    action_keys = { -- key mappings for actions in the trouble list
      -- map to {} to remove a mapping, for example:
      -- close = {},
      close = 'q',                                                                        -- close the list
      cancel = '<esc>',                                                                   -- cancel the preview and get back to your last window / buffer / cursor
      refresh = 'r',                                                                      -- manually refresh
      jump = { '<cr>', '<tab>', '<2-leftmouse>' },                                        -- jump to the diagnostic or open / close folds
      open_split = { '<c-x>' },                                                           -- open buffer in new split
      open_vsplit = { '<c-v>' },                                                          -- open buffer in new vsplit
      open_tab = { '<c-t>' },                                                             -- open buffer in new tab
      jump_close = { 'o' },                                                               -- jump to the diagnostic and close the list
      toggle_mode = 'm',                                                                  -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = 's',                                                              -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
      toggle_preview = 'P',                                                               -- toggle auto_preview
      hover = 'K',                                                                        -- opens a small popup with the full multiline message
      preview = 'p',                                                                      -- preview the diagnostic location
      open_code_href = 'c',                                                               -- if present, open a URI with more information about the diagnostic error
      close_folds = { 'zM', 'zm' },                                                       -- close all folds
      open_folds = { 'zR', 'zr' },                                                        -- open all folds
      toggle_fold = { 'zA', 'za' },                                                       -- toggle fold of current file
      previous = 'k',                                                                     -- previous item
      next = 'j',                                                                         -- next item
      help = '?',                                                                         -- help menu
    },
    multiline = true,                                                                     -- render multi-line messages
    indent_lines = true,                                                                  -- add an indent guide below the fold icons
    win_config = { border = 'single' },                                                   -- window configuration for floating windows. See |nvim_open_win()|.
    auto_open = false,                                                                    -- automatically open the list when you have diagnostics
    auto_close = false,                                                                   -- automatically close the list when you have no diagnostics
    auto_preview = true,                                                                  -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false,                                                                    -- automatically fold a file trouble list at creation
    auto_jump = { 'lsp_definitions' },                                                    -- for the given modes, automatically jump if there is only a single result
    include_declaration = { 'lsp_references', 'lsp_implementations', 'lsp_definitions' }, -- for the given modes, include the declaration of the current symbol in the results
    signs = {
      -- icons / text used for a diagnostic
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '',
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
  },
  config = function()
    -- Lua
    local trouble = require 'trouble'

    vim.keymap.set('n', '<leader>xx', function()
      trouble.toggle()
    end, { desc = 'toggle trouble list' })

    vim.keymap.set('n', '<leader>xw', function()
      trouble.toggle 'workspace_diagnostics'
    end, { desc = ' toggle workspace diagnostics' })

    vim.keymap.set('n', '<leader>xd', function()
      trouble.toggle 'document_diagnostics'
    end, { desc = 'toggle document diagnostics' })

    vim.keymap.set('n', '[d', function()
      if not trouble.is_open() then
        trouble.toggle()
      end
      trouble.next { skip_groups = true, jump = true }
    end, { desc = 'Go to previous diagnostic message' })

    vim.keymap.set('n', ']d', function()
      if not trouble.is_open() then
        trouble.toggle()
      end
      trouble.previous { skip_groups = true, jump = true }
    end, { desc = 'Go to next diagnostic message' })

    vim.keymap.set('n', '<leader>xq', function()
      trouble.toggle 'quickfix'
    end, { desc = 'toggle quickfix' })
    vim.keymap.set('n', '<leader>xl', function()
      trouble.toggle 'loclist'
    end, { desc = 'toggle loclist' })
    vim.keymap.set('n', 'gR', function()
      trouble.toggle 'lsp_references'
    end, { desc = 'toggle lsp references' })
  end,
}
