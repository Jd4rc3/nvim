-- local lfs = require 'lfs'
--
-- local function resolver_glob(ruta, extension)
--   for archivo in lfs.dir(ruta) do
--         if archivo:match(extension..'$') then
--             print('Archivo encontrado:', archivo)
--         end
--   end
-- end

return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup {
          library = {
            enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
            -- these settings will be used for your Neovim config directory
            runtime = true, -- runtime path
            types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
            plugins = true, -- installed opt or start plugins in packpath
            -- you can also specify the list of plugins to make available as a workspace library
            -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
          },
          setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
          -- for your Neovim config directory, the config.library settings will be used as is
          -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
          -- for any other directory, config.library.enabled will be set to false
          override = function(root_dir, options) end,
          -- With lspconfig, Neodev will automatically setup your lua-language-server
          -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
          -- in your lsp start options
          lspconfig = true,
          -- much faster, but needs a recent built of lua-language-server
          -- needs lua-language-server >= 3.6.0
          pathStrict = true,
        }
      end,
    },
  },
  config = function()
    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- NOTE: Remember that lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don"t have to repeat yourself
      -- many times.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
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

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require('mason').setup()

    local servers = {
      clangd = {},
      gopls = {},
      pyright = {},
      rust_analyzer = {},
      tsserver = {},
      omnisharp = {},
      html = { filetypes = { 'html', 'twig', 'hbs' } },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS"s noisy `missing-fields` warnings
          -- diagnostics = { disable = { "missing-fields" } },
        },
      },
    }

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,

      ['clangd'] = function()
        require('lspconfig')['clangd'].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--completion-style=bundled',
            '--header-insertion=iwyu',
            '--cross-file-rename',
          },
        }
      end,
      ['omnisharp'] = function()
        require('lspconfig')['omnisharp'].setup {
          enable_editorconfig_support = true,
          enable_ms_build_load_projects_on_demand = false,
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
          sdk_include_prereleases = false,
          analyze_open_documents_only = false,
          capabilities = capabilities,
          on_attach = on_attach,
          filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props' },
          root_dir = require('lspconfig/util').root_pattern('*.sln', '*.csproj', 'project.json', 'global.json', 'packages.config'),
        }
      end,

      --   ['csharp_ls'] = function()
      --     require('lspconfig')['csharp_ls'].setup {
      --       capabilities = capabilities,
      --       on_attach = on_attach,
      --       cmd = {
      --         vim.fn.stdpath 'data' .. '/mason/bin/csharp-ls.CMD',
      --         '--solution',
      --         vim.fn.glob(vim.fn.getcwd() .. '/*.sln'),
      --       },
      --     }
      --   end,
    }
  end,
}
