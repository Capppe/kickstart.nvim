-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'pysan3/neo-tree.nvim',
  branch = 'restore-session-experimental',
  version = false,
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
          },
          bo = {
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            buftype = { 'terminal', 'quickfix' },
          },
        }
      end,
    },
  },
  cmd = 'Neotree',
  config = function()
    require('neo-tree').setup {
      auto_clean_after_session_restore = false,
      auto_restore_session_experimental = true,
      close_if_last_window = true,

      default_components_configs = {
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = '|',
        },
      },

      filesystem = {
        filtered_items = {
          visible = false,
        },
      },
    }
  end,
  event_handlers = {
    event = 'neo_tree_buffer_leave',
    handler = function()
      local shown_buffers = {}
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        shown_buffers[vim.api.nvim_win_get_buf(win)] = true
      end
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
          not shown_buffers[buf]
          and vim.api.nvim_buf_get_option(buf, 'buftype') == 'nofile'
          and vim.api.nvim_buf_get_option(buf, 'filetype') == 'neo-tree'
        then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end,
  },
}
