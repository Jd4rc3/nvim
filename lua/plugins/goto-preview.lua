local nmap = function(keys, func, desc)
  if desc then
    desc = desc
  end

  vim.keymap.set('n', keys, func, { noremap = true, desc = desc })
end

local function configs()
  require('goto-preview').setup {
    width = 120, -- Width of the floating window
    height = 15, -- Height of the floating window
    border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
    default_mappings = false, -- Bind default mappings
    debug = false, -- Print debug information
    opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
    resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
    post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
    post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
    references = { -- Configure the telescope UI for slowing the references cycling window.
      telescope = require('telescope.themes').get_dropdown { hide_preview = false },
    },
    -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
    focus_on_open = true,                                        -- Focus the floating window when opening it.
    dismiss_on_move = false,                                     -- Dismiss the floating window when moving the cursor.
    force_close = true,                                          -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
    bufhidden = 'wipe',                                          -- the bufhidden option to set on the floating window. See :h bufhidden
    stack_floating_preview_windows = true,                       -- Whether to nest floating windows
    preview_window_title = { enable = true, position = 'left' }, -- Whether to set the preview window title as the filename
  }
end

local function keymaps()
  local goto_preview = require 'goto-preview'
  nmap('gpd', goto_preview.goto_preview_definition, 'goto_preview_definition')
  nmap('gpt', goto_preview.goto_preview_type_definition, 'goto_preview_type_definition')
  nmap('gpi', goto_preview.goto_preview_implementation, 'goto_preview_implementation')
  nmap('gpD', goto_preview.goto_preview_declaration, 'goto_preview_declaration')
  nmap('gP', goto_preview.close_all_win, 'close all windows')
  nmap('gpr', goto_preview.goto_preview_references, 'goto_preview_references')
end

return {
  'rmagatti/goto-preview',
  commit = '1519ea3',
  config = function()
    configs()
    keymaps()
  end,
}
