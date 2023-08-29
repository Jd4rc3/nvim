function Paint(color)
    color = color or "catppuccin-macchiato"

    --	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    --vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        show_end_of_buffer = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = true,
            mini = true,
            harpoon = true,
            lsp_saga = true,
            mason = true,
            dap = {
                enabled = true,
                enable_ui = true,
            },
            ----------------------
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            ----------------------
            treesitter_context = true,
            telescope = {
                enabled = true,
            },
            which_key = true
        },
    })

    vim.cmd.colorscheme(color)
end

Paint()
