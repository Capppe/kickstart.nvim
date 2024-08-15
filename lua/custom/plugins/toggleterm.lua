return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      on_open = function()
        vim.cmd ':startinsert'
      end,
      persist_mode = false,
    }
  end,
}
