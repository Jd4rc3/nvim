local function get_debugger_path()
    local system = vim.loop.os_uname().sysname

    if system == "Linux" or system == "Darwin" then
        return os.getenv("HOME") ..
        "/.local/share/nvim/mason/packages/java-debug/java-debug/com.microsoft.java.debug.plugin/target/"
    end

    return os.getenv("UserProfile") .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/"
end

local wk = require("which-key")

wk.register({
    ["<leader>j"] = {
        name = "+jdtls",
        a = { "<Cmd>lua require('jdtls').organize_imports()<CR>", "Organize Imports" },
        i = { "<Cmd>lua require('jdtls').import_on_completion()<CR>", "Import on Completion" },
        c = { "<Cmd>lua require('jdtls').code_action()<CR>", "Code Action" },
        r = { "<Cmd>lua require('jdtls').rename()<CR>", "Rename" },
        f = { "<Cmd>lua require('jdtls').format()<CR>", "Format" },
        t = { "<Cmd>lua require('jdtls').test_class()<CR>", "Test Class" },
        d = {
            name = "+document",
            i = { "<Cmd>lua require('jdtls').document_symbol()<CR>", "Document Symbol" },
            s = { "<Cmd>lua require('jdtls').implementation()<CR>", "Implementation" },
            t = { "<Cmd>lua require('jdtls').type_hierarchy()<CR>", "Type Hierarchy" },
        },
        g = {
            name = "+goto",
            g = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
            r = { "<Cmd>lua vim.lsp.buf.references()<CR>", "References" },
        },
    },
})


-- require('jdtls').start_or_attach(config)

local dap = require 'dap'
vim.keymap.set('n', '<F10>', dap.continue)
vim.keymap.set('n', '<F8>', dap.step_over)
vim.keymap.set('n', '<F7>', dap.step_into)
vim.keymap.set('n', '<S-F8>', dap.step_out)
vim.keymap.set('n', '<S-F10>', dap.stop)

--settings up new
--
local M = {}

function M.setup()
    local on_attach = function(client, bufnr)
        require 'jdtls.setup'.add_commands()
        require 'jdtls'.setup_dap({ hotcodereplace = 'auto' })
        require 'lsp-status'.register_progress()
        require 'compe'.setup {
            enabled = true,
            autocomplete = true,
            debug = false,
            min_length = 1,
            preselect = 'enable',
            throttle_time = 80,
            source_timeout = 200,
            incomplete_delay = 400,
            max_abbr_width = 100,
            max_kind_width = 100,
            max_menu_width = 100,
            documentation = true,

            source = {
                path = true,
                buffer = true,
                calc = true,
                vsnip = false,
                nvim_lsp = true,
                nvim_lua = true,
                spell = true,
                tags = true,
                snippets_nvim = false,
                treesitter = true,
            },
        }

        require 'lspkind'.init()
        require 'lspsaga'.init_lsp_saga()

        -- Kommentary
        vim.api.nvim_set_keymap("n", "<leader>/", require('kommentary').toggle_comment(), {})
        vim.api.nvim_set_keymap("v", "<leader>/", require('kommentary').toggle_comment(), {})

        require 'formatter'.setup {
            filetype = {
                java = {
                    function()
                        return {
                            exe = 'java',
                            args = { '-jar',
                                vim.fn.stdpath "config" .. "/lang-servers/google-java-format-1.17.0-all-deps.jar",
                                vim.api.nvim_buf_get_name(0) },
                            stdin = true
                        }
                    end
                }
            }
        }

        vim.api.nvim_exec([[
        augroup FormatAutogroup
          autocmd!
          autocmd BufWritePost *.java FormatWrite
        augroup end
      ]], true)

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references() && vim.cmd("copen")<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- Java specific
        buf_set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
        buf_set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
        buf_set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
        buf_set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
        buf_set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
        buf_set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

        buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

        vim.api.nvim_exec([[
          hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
          hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
      ]], false)
    end

    local root_markers = { 'gradlew', 'pom.xml' }
    local root_dir = require('jdtls.setup').find_root(root_markers)
    local home = os.getenv('HOME')

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
    local config = {
        flags = {
            allow_incremental_sync = true,
        },
        capabilities = capabilities,
        on_attach = on_attach,
    }

    config.settings = {
        ['java.format.settings.url'] = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
        ['java.format.settings.profile'] = "GoogleStyle",
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = home .. "/.sdkman/candidates/java/11.0.10-open/",
                    },
                    {
                        name = "JavaSE-14",
                        path = home .. "/.sdkman/candidates/java/14.0.2-open/",
                    },
                    {
                        name = "JavaSE-15",
                        path = home .. "/.sdkman/candidates/java/15.0.1-open/",
                    },
                    {
                        name = "JavaSE-20",
                        path = home .. "/.sdkman/candidates/java/20.0.2.fx-librca/",
                    },
                    {
                        name = "JavaSE-17",
                        path = home .. "/.sdkman/candidates/java/17.0.8-librca/",
                    },
                }
            },
        },
    }
    config.cmd = { 'java-lsp', workspace_folder }
    config.on_attach = on_attach
    config.on_init = function(client, _)
        client.notify('workspace/didChangeConfiguration', { settings = config.settings })
    end

    -- local jar_patterns = {
    --     '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    --     '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
    --     '/dev/microsoft/vscode-java-test/server/*.jar',
    -- }

    -- local bundles = {}
    -- for _, jar_pattern in ipairs(jar_patterns) do
    --   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
    --     if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
    --       table.insert(bundles, bundle)
    --     end
    --   end
    -- end

    local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
        -- bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities,
    }

    -- UI
    local finders = require 'telescope.finders'
    local sorters = require 'telescope.sorters'
    local actions = require 'telescope.actions'
    local pickers = require 'telescope.pickers'
    require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
        local opts = {}
        pickers.new(opts, {
            prompt_title    = prompt,
            finder          = finders.new_table {
                results = items,
                entry_maker = function(entry)
                    return {
                        value = entry,
                        display = label_fn(entry),
                        ordinal = label_fn(entry),
                    }
                end,
            },
            sorter          = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.goto_file_selection_edit:replace(function()
                    local selection = actions.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)

                    cb(selection.value)
                end)

                return true
            end,
        }):find()
    end
    -- Server
    require('jdtls').start_or_attach(config)
end

return M
