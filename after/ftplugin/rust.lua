local map = function(key, cmd, desc)
  vim.keymap.set('n', key, cmd, { desc = desc or '', noremap = true, silent = true })
end

local test = function(func_name)
  if func_name == nil then
    return
  end

  local term = require('toggleterm.terminal').Terminal
  local cmd = 'cargo test ' .. func_name .. ' -- --nocapture && bash'
  term
    :new({
      cmd = cmd,
      direction = 'float',
    })
    :open()
end

map('<leader>ct', function()
  local func_name = vim.fn.expand '<cword>'
  test(func_name)
end, '[T]est function')
