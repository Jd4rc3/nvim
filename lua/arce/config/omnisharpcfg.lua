local M = {}
local pid = vim.fn.getpid()

local function find_omnisharp_bin()
    local system = vim.loop.os_uname().sysname
    local BASE = vim.fn.stdpath('data')
    if system == "Linux" or system == "Darwin" then
        return BASE .. "/mason/packages/omnisharp/omnisharp"
    end

    return BASE .. "/mason/packages/omnisharp/omnisharp.cmd"
end

M.find_sln = function(_, bufnr)
    local lspconfig = require 'lspconfig'
    local util = lspconfig.util
    local path = util.path
    local cwd = vim.fn.getcwd(bufnr)
    local sln = util.search_ancestors(cwd, function(dir)
        local sln_file = path.join(dir, '*.sln')
        return vim.fn.glob(sln_file) ~= ''
    end)

    if sln then
        return sln
    end
end

M.setup = function()
    local omnisharp_bin = find_omnisharp_bin()

    local lspconfig = require 'lspconfig'

    lspconfig.omnisharp.setup {
        --        root_dir = function(_, bufnr)
        --            return M.find_sln(_, bufnr)
        --        end,

        --  handlers = {
        --      ["textDocument/definition"] = require('omnisharp_extended').handler,
        --  },

        cmd = { omnisharp_bin, '-z', '--languageserver', '--hostPID', tostring(pid),
            "DotNet:enablePackageRestore=false",
            "--encoding", "utf-8", "--languageserver", "FormattingOptions:OrganizeImports=true" },

        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        enable_editorconfig_support = false,

        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        enable_ms_build_load_projects_on_demand = false,

        -- Enables support for roslyn analyzers, code fixes and rulesets.
        enable_roslyn_analyzers = false,

        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        organize_imports_on_format = true,

        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        enable_import_completion = true,

        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        sdk_include_prereleases = true,

        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        analyze_open_documents_only = false,
    }

    -- lspconfig.util.default_config = vim.tbl_extend(
    --     "force",
    --     lspconfig.util.default_config,
    --     {
    --         handlers = {
    --             ["window/logMessage"] = function(err, method, params, client_id)
    --                 if params and params.type <= vim.lsp.protocol.MessageType.Log then
    --                     vim.lsp.handlers["window/logMessage"](err, method, params, client_id)
    --                 end
    --             end,
    --             ["window/showMessage"] = function(err, method, params, client_id)
    --                 if params and params.type <= vim.lsp.protocol.MessageType.Warning.Error then
    --                     vim.lsp.handlers["window/showMessage"](err, method, params, client_id)
    --                 end
    --             end,
    --         }
    --     }
    -- )
end

return M
