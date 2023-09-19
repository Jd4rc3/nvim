local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
    log_level = "debug",
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "astro" },

            extra_args = function(params)
                local filetype = require("plenary.filetype").detect_from_extension(params.bufname)

                if filetype ~= "astro" then
                    return {}
                end

                return {
                    "--stdin-filepath",
                    params.bufname,
                    "--plugin=prettier-plugin-astro",
                }
            end,
            --
            -- prefer_local = "node_modules/.bin/",
            --
            -- condition = function()
            --     return utils.root_has_file({ ".prettierrc" })
            -- end,
        }),
        null_ls.builtins.formatting.stylua,
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })

            vim.api.nvim_create_user_command("Prettier", function()
                vim.cmd([[%! npx prettier %]])
            end, { desc = "Organize Imports" })

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
