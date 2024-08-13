return {
  'github/copilot.vim',
  enabled = false,
  config = function()
    vim.cmd [[let g:copilot_no_tab_map = v:true]]
    vim.cmd [[imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")]]
    vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]
    vim.cmd [[let g:copilot_filetypes = { '.env': v:false, }
    ]]
  end,
}
