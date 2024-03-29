return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        require 'none-ls.diagnostics.eslint_d',
        require 'none-ls.code_actions.eslint_d',
        null_ls.builtins.formatting.prettierd,
        -- HTML & XML
        null_ls.builtins.formatting.tidy,
        -- MISCELLANEOUS
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.refactoring,
        --  golang
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt,
        --  docker
        null_ls.builtins.diagnostics.hadolint,
      },
    }
  end,
}
