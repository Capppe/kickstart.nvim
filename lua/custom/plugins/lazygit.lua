return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  keys = {
    { '<leader>gg', ':LazyGit<cr>', desc = 'LazyGit' },
  },
}
