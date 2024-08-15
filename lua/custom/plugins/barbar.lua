return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require('barbar').setup {
      auto_hide = 1,
      icons = {
        visible = { separator = { left = ' ', right = '' } },
      },
    }
  end,
  version = '^1.0.0',
}
