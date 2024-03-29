---@diagnostic disable: undefined-global

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  vim.keymap.set('n', '<C-A-o>', function()
    require('jdtls').organize_imports()
  end, { buffer = bufnr, desc = 'LSP: Organize imports', noremap = true })

  vim.keymap.set('n', 'crv', function()
    require('jdtls').extract_variable()
  end, { buffer = bufnr, desc = 'LSP: Extract variable', noremap = true })

  vim.keymap.set('v', 'crv', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>', { buffer = bufnr, desc = 'LSP: Extract variable', noremap = true })

  vim.keymap.set('n', 'crc', function()
    require('jdtls').extract_constant()
  end, { buffer = bufnr, desc = 'LSP: Extract constant', noremap = true })

  vim.keymap.set('v', 'crc', '<Esc><Cmd>lua require("jdtls").extract_constant(true)<CR>', { buffer = bufnr, desc = 'LSP: Extract constant', noremap = true })

  vim.keymap.set('v', 'crm', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>', { buffer = bufnr, desc = 'LSP: Extract method', noremap = true })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local lombok_agent_arg = '--jvm-arg=-javaagent:' .. vim.fn.stdpath 'data' .. '/mason/packages/jdtls/lombok.jar'

local jdtls_bin = vim.fn.stdpath 'data' .. '/mason/bin/jdtls'

if vim.loop.os_uname().sysname == 'Windows_NT' then
  jdtls_bin = jdtls_bin .. '.cmd'
end

local config = {
  cmd = {
    jdtls_bin,
    lombok_agent_arg,
    '-configuration',
    os.getenv 'HOME' .. '/.cache/jdtls/config',
    '-data',
    os.getenv 'HOME' .. '/.cache/jdtls/workspace',
  },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  on_attach = on_attach,
}

config['init_options'] = {
  bundles = {
    vim.fn.glob(Java_debug_path .. '/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', 1),
  },
}
require('jdtls').start_or_attach(config)
