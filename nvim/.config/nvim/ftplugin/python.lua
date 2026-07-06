-- Set a soft guide column at 88 characters
vim.opt_local.colorcolumn = "88"

-- 1. Fix opening paren split: Indent 4 spaces instead of 8
vim.g.pyindent_open_paren = 'shiftwidth()'

-- 2. Fix nested paren behavior
vim.g.pyindent_nested_paren = 'shiftwidth()'

-- 3. Fix closing paren split: Dedent by 4 spaces to align with the 'p' in print
vim.g.pyindent_close_paren = '-shiftwidth()'

-- Modern Neovim equivalent (covers all bases)
vim.g.python_indent = {
  closed_paren_align_last_line = false, -- Align with the opening line, not the text above
  open_paren = 'shiftwidth()',
  nested_paren = 'shiftwidth()',
}
