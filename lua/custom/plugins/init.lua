-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

vim.cmd [[set relativenumber]]

vim.keymap.set('n', '<silent> <C-g>', '')
vim.keymap.set('n', ';', ':', { desc = 'Enter command mode' })
vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true, desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<C-g>', '<cmd>Telescope oldfiles<CR>', { silent = true, desc = 'List buffers' })
vim.keymap.set('n', '<C-e>', function()
  vim.diagnostic.open_float { scope = 'line' }
end, { desc = 'Show line diagnostics' })
vim.keymap.set('n', '<leader>/', ':RG<cr>', { silent = true, desc = 'Live grep' })
vim.keymap.set('n', '<C-o>', '<cmd>Telescope lsp_document_symbols<CR>', {
  silent = true,
  desc = 'Search document symbols',
})
vim.keymap.set('n', '<leader><C-o>', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', {
  silent = true,
  desc = 'Search workspace symbols',
})

-- noremap <silent>  <C-S>  :update<CR>
-- vnoremap <silent> <C-S> <C-C>:update<CR>
-- inoremap <silent> <C-S> <C-O>:update<CR>
vim.keymap.set('n', '<C-s>', ':update<CR>')
vim.keymap.set('v', '<C-s>', '<C-C>:update<CR>')
vim.keymap.set('i', '<C-s>', '<C-O>:update<CR>')

vim.opt.colorcolumn = '80,120'

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function()
    vim.cmd [[ Neotree filesystem reveal ]]
  end,
})

local is_revealing = false
vim.api.nvim_create_autocmd({ 'TabNewEntered' }, {
  callback = function()
    if is_revealing then
      return
    end

    if vim.bo.filetype ~= 'neo-tree' and vim.bo.buftype == '' and vim.fn.filereadable(vim.fn.expand '%:p') == 1 then
      is_revealing = true
      vim.defer_fn(function()
        vim.cmd [[ Neotree filesystem reveal ]]
        vim.cmd.wincmd 'p'
        vim.defer_fn(function()
          is_revealing = false
        end, 10)
      end, 10)
    end
  end,
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    if is_revealing then
      return
    end

    -- Check if neo-tree buffer exists in any window
    local has_neotree = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == 'neo-tree' then
        has_neotree = true
        break
      end
    end

    if not has_neotree then
      return
    end

    if vim.bo.filetype ~= 'neo-tree' and vim.bo.buftype == '' and vim.fn.filereadable(vim.fn.expand '%:p') == 1 then
      is_revealing = true
      vim.defer_fn(function()
        vim.cmd [[ Neotree filesystem reveal ]]
        vim.cmd.wincmd 'p'
        vim.defer_fn(function()
          is_revealing = false
        end, 10)
      end, 10)
    end
  end,
})

return {
  {
    'nanotech/jellybeans.vim',
    config = function()
      vim.cmd.colorscheme 'jellybeans'
    end,
  },
  {
    'tpope/vim-surround',
  },
  {
    'tpope/vim-repeat',
  },
  {
    'tikhomirov/vim-glsl',
    config = function()
      vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
        pattern = { '*.vs', '*.fs' },
        callback = function()
          vim.bo.filetype = 'glsl'
        end,
      })
    end,
  },
  {
    'tpope/vim-fugitive',
  },
  {
    'luochen1990/rainbow',
  },
  {
    'folke/todo-comments.nvim',
    enabled = false,
  },
  {
    'echasnovski/mini.nvim',
    enabled = false,
  },
  {
    'folke/tokyonight.nvim',
    enabled = false,
  },
  {
    'junegunn/fzf',
    build = ':call fzf#install()',
  },
  {
    'junegunn/fzf.vim',
  },
}
