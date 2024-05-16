return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  -- opts = {},
  config = function()
    require('barbar').setup {
      auto_hide = 1,
      tabpages = true,
      exclude_ft = { 'term://*' },
    }
  end,
  version = '^1.0.0',
}
