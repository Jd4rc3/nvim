local nmap = function(keys, func, desc)
  if desc then
    desc = 'DAP: ' .. desc
  end

  vim.keymap.set('n', keys, func, { desc = desc })
end

local keymaps = function()
  local dap = require 'dap'

  nmap('<F9>', function()
    dap.continue()
  end, 'Continue')
  nmap('<F8>', function()
    dap.step_over()
  end, 'Step over')
  nmap('<F7>', function()
    dap.step_into()
  end, 'Step into')
  nmap('<S-F8>', function()
    dap.step_out()
  end, 'Step out')
  nmap('<Leader>db', function()
    dap.toggle_breakpoint()
  end, 'Toggle breakpoint')
  nmap('<Leader>dB', function()
    dap.set_breakpoint()
  end, 'Set breakpoint')

  nmap('<Leader>lp', function()
    dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
  end, 'Set breakpoint with log')

  nmap('<Leader>dr', function()
    dap.repl.open()
  end, 'Open repl')
  nmap('<Leader>dl', function()
    dap.run_last()
  end, 'Run last')

  vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
  end, { desc = '[D]ebug [h]over' })

  vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
  end, { desc = '[D]ebug [p]review' })

  nmap('<Leader>df', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.frames)
  end, 'Frames')

  nmap('<Leader>ds', function()
    local widgets = require 'dap.ui.widgets'
    widgets.centered_float(widgets.scopes)
  end, 'Scopes')
end

local setup_dapui = function()
  local dap, dapui = require 'dap', require 'dapui'
  dapui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

local setup_dap_go = function()
  require('dap-go').setup()
end

local setup_java_debug_plugins = function()
  local code_plugins_path = vim.fn.stdpath 'data' .. '/code_plugins'
  Java_debug_path = code_plugins_path .. '/java-debug'
  VScode_java_test_path = code_plugins_path .. '/vscode-java-test'

  if not vim.loop.fs_stat(Java_debug_path) then
    vim.fn.system {
      'git',
      'clone',
      'https://github.com/microsoft/java-debug',
      Java_debug_path,
    }
  end

  if not vim.loop.fs_stat(VScode_java_test_path) then
    vim.fn.system {
      'git',
      'clone',
      'https://github.com/microsoft/vscode-java-test',
      VScode_java_test_path,
    }
  end
end

local setup_java_debug = function()
  setup_java_debug_plugins()
end

return {
  'mfussenegger/nvim-dap',
  dependencies = { 'rcarriga/nvim-dap-ui', 'leoluz/nvim-dap-go' },
  config = function()
    keymaps()
    setup_dapui()
    setup_dap_go()
    setup_java_debug()
  end,
}
