vim.cmd [[packadd packer.nvim]]

require('packer').startup({
    function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.1',
            -- or                            , branch = '0.1.x',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use { 'theprimeagen/harpoon', commit = "21f4c47c6803d64ddb934a5b314dcb1b8e7365dc" }
        use({ 'mbbill/undotree', commit = "0e11ba7325efbbb3f3bebe06213afa3e7ec75131" })
        use({ 'tpope/vim-fugitive', commit = "b3b838d690f315a503ec4af8c634bdff3b200aaf" })

        use({ 'nvim-treesitter/nvim-treesitter', commit = "b223402ba9a69a5993e25e3e7effac5621fbb0e1" })

        --lsp
        use({ 'mfussenegger/nvim-jdtls', commit = "095dc490f362adc85be66dc14bd9665ddd94413b" })
        use({ 'onsails/lspkind.nvim', commit = "57610d5ab560c073c465d6faf0c19f200cb67e6e" })
        use({ 'nvimdev/lspsaga.nvim', commit = "5890d58e8cf174ea5c69e9ea8c41558b01f18897" })

        --comments
        use({ 'numToStr/Comment.nvim', commit = "0236521ea582747b58869cb72f70ccfa967d2e89" })

        -- json support
        use { 'Joakker/lua-json5', run = './install.sh', commit = "b2343d89a3bb5d17d14852e721be4fde31a8b4b1" }

        -- keyreminder
        use { "folke/which-key.nvim", config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end, commit = "7ccf476ebe0445a741b64e36c78a682c1c6118b7" }

        -- terminal
        use { "akinsho/toggleterm.nvim", branch = "main",
            commit = "12cba0a1967b4f3f31903484dec72a6100dcf515",
            config = function()
                require("toggleterm").setup()
            end }

        -- dev containers
        use { 'esensar/nvim-dev-container' }

        -- debugging
        use { 'mfussenegger/nvim-dap', commit = "1c63f37f95cd4fb54512898168138d9a75d1516a" }
        use { 'rcarriga/cmp-dap', commit = "d16f14a210cd28988b97ca8339d504533b7e09a4" }
        use { 'rcarriga/nvim-dap-ui',
            commit = "85b16ac2309d85c88577cd8ee1733ce52be8227e",
            requires = { 'mfussenegger/nvim-dap' }
        }
        use { 'folke/neodev.nvim', commit = "9a5c0f0de5c15fba52d4fb83d425d3f4fa7abfa1" }

        --lsp-zero
        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig',             commit = "a981d4447b92c54a4d464eb1a76b799bc3f9a771" }, -- Required
                { 'williamboman/mason.nvim',           commit = "74eac861b013786bf231b204b4ba9a7d380f4bd9" }, -- Optional
                { 'williamboman/mason-lspconfig.nvim', commit = "e86a4c84ff35240639643ffed56ee1c4d55f538e" }, -- Optional

                -- Autocompletion
                { 'hrsh7th/nvim-cmp',                  commit = "51f1e11a89ec701221877532ee1a23557d291dd5" }, -- Required
                { 'hrsh7th/cmp-nvim-lsp',              commit = "44b16d11215dce86f253ce0c30949813c0a90765" }, -- Required
                { 'hrsh7th/cmp-buffer',                commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- Optional
                { 'hrsh7th/cmp-path',                  commit = "91ff86cd9c29299a64f968ebb45846c485725f23" }, -- Optional
                { 'saadparwaiz1/cmp_luasnip',          commit = "18095520391186d634a0045dacaa346291096566" }, -- Optional
                { 'hrsh7th/cmp-nvim-lua',              commit = "f12408bdb54c39c23e67cab726264c10db33ada8" }, -- Optional

                -- Snippets
                { 'L3MON4D3/LuaSnip',                  commit = "99a94cc35ec99bf06263d0346128e908a204575c" }, -- Required
                { 'rafamadriz/friendly-snippets',      commit = "bc38057e513458cb2486b6cd82d365fa294ee398" }, -- Optional
            }
        }

        -- colorscheme
        use { "catppuccin/nvim", as = "catppuccin", commit = "490078b1593c6609e6a50ad5001e7902ea601824" }

        -- omnisharp decopile feature (not working apparently)
        use { "Hoffs/omnisharp-extended-lsp.nvim", commit = "53edfb413a54c9e55dcddc9e9fa4977a897e4425" }

        --copilot
        use { "github/copilot.vim", commit = "a24c3fd686ecf53b81d7d259994691508a69ebf6" }

        --file explorer
        use { "lmburns/lf.nvim", commit = "5c1d8569d3a221fb3bbf497de3f2834f1db289e1" }

        --ngswitcher
        use {"softoika/ngswitcher.vim", commit="75e2c47749c9b580d72c5fd48ad50162575e00f4"}
    end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})
