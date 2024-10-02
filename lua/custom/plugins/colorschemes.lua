return {
  -- {
  --   'aliqyan-21/darkvoid.nvim',
  --   name = 'darkvoid',
  --   priority = 1000,
  --   config = function()
  --     require('darkvoid').setup {
  --       transparent = false,
  --       glow = true,
  --
  --       colors = {
  --         bg = '#1c1c1c',
  --         comment = '#585858',
  --         string = '#0b6e4f',
  --       },
  --     }
  --   end,
  -- },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        color_overrides = {
          all = {
            base = '#1c1c1c',
            mantle = '#202020',
            crust = '#303030',
          },
        },
      }
    end,
    init = function()
      vim.cmd.colorscheme 'catppuccin'

      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
