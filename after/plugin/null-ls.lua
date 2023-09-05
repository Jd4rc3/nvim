local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "astro" },
            extra_args = function(params)
                if params.filetype ~= "astro" then
                    return {}
                end

                print("FYLETYPE IS ASTRO")

                return {
                    "--stdin-filepath",
                    params.bufname,
                    "--plugin=prettier-plugin-astro",
                }
            end,
        }),
        null_ls.builtins.formatting.stylua,
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })

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
