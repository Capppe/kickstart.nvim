return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    local stats = require('lazy').stats()
    local ms = stats.startuptime
    require('dashboard').setup {
      theme = 'doom',
      hide = {
        statusline = true,
      },
      config = {
        header = {
          '                                   ',
          '                                   ',
          '                                   ',
          '                                   ',
          '  ██████╗ ██╗   ██╗ ██╗ ███╗   ███╗ ',
          ' ██╔════╝ ██║   ██║ ██║ ████╗ ████║ ',
          ' ██║      ██║   ██║ ██║ ██╔████╔██║ ',
          ' ██║      ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║ ',
          ' ╚██████╗  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ',
          '  ╚═════╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ',
          '                                    ',
          ' ------  Cappes Vi Improved  ------ ',
          '                                    ',
          '                                    ',
        },
        center = {
          { action = 'Telescope find_files', desc = ' Find file', icon = ' ', key = 'f' },
          { action = 'lua require("persistence").load()', desc = ' Restore Session', icon = ' ', key = 's' },
          { action = 'qa', desc = ' Quit', icon = ' ', key = 'q' },
        },
        footer = {
          '',
          '',
          '',
          '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms',
        },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
