return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        -- JS
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettierd,
        --
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.refactoring,
        --  golang
        null_ls.builtins.code_actions.gomodifytags,
        null_ls.builtins.code_actions.impl,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.formatting.gofmt
      },
    }
  end,
}
