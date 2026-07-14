local function gh(repo) return 'https://github.com/' .. repo end

vim.o.relativenumber = true
vim.o.expandtab = true
vim.opt.colorcolumn = '80,120'

vim.keymap.set('n', '<silent> <C-g>', '')
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode' })
vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true, desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<C-g>', '<cmd>Buffers<CR>', { silent = true, desc = 'List buffers' })
vim.keymap.set('n', '<C-e>', function()
  vim.diagnostic.open_float { scope = 'line' }
end, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '<leader>/', ':RG<CR>', { silent = true, desc = 'Live grep' })
vim.keymap.set('n', '<C-o>', '<cmd>Telescope lsp_document_symbols<CR>', {
  silent = true,
  desc = 'Search document symbols',
})
vim.keymap.set('n', '<leader><C-o>', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', {
  silent = true,
  desc = 'Search workspace symbols',
})

vim.keymap.set('n', '<C-s>', '<cmd>update<CR>')
vim.keymap.set('v', '<C-s>', '<C-C><cmd>update<CR>')
vim.keymap.set('i', '<C-s>', '<C-O><cmd>update<CR>')

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'html',
    'css',
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.pack.add {
  gh 'nanotech/jellybeans.vim',
  gh 'tpope/vim-surround',
  gh 'tpope/vim-repeat',
  gh 'tikhomirov/vim-glsl',
  gh 'tpope/vim-fugitive',
  gh 'tpope/vim-abolish',
  gh 'luochen1990/rainbow',
  gh 'junegunn/fzf',
  gh 'junegunn/fzf.vim',
  gh 'yochem/jq-playground.nvim',
}

vim.cmd.colorscheme 'jellybeans'

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.vs', '*.fs' },
  callback = function()
    vim.bo.filetype = 'glsl'
  end,
})
