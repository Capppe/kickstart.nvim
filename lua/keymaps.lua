local M = {}

local map = function(key, cmd, desc)
  vim.keymap.set('n', key, cmd, { desc = desc or '', noremap = true, silent = true })
end

map('<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
map(']d', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
map('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

---- Other keybinds ----
-- Enter cmd mode with ';'
map(';', ':', 'Enter command line mode')

-- Move visually selected block of text up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Resize buffers with <C-left,right,up,down -arrows>
map('<C-left>', ':vertical res -2<CR>', 'Resize left')
map('<C-right>', ':vertical res +2<CR>', 'Resize right')
map('<C-up>', ':horizontal res -2<CR>', 'Resize up')
map('<C-down>', ':horizontal res +2<CR>', 'Resize down')

-- Allow moving cursor through wrapped lines with h,j,k,l
vim.keymap.set('n', 'j', 'v:count ? "j" : "gj"', { noremap = true, silent = true, expr = true })
vim.keymap.set('n', 'k', 'v:count ? "k" : "gk"', { noremap = true, silent = true, expr = true })

-- Exit terminal focus by switching buffers
vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<CR>', { noremap = true, silent = true })

-- Telescope {{{
M.telescope = function()
  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
  map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
  map('<leader>sf', builtin.find_files, '[S]earch [F]iles')
  map('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
  map('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
  map('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
  map('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
  map('<leader>sr', builtin.resume, '[S]earch [R]esume')
  map('<leader>s.', builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
  map('<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
  map('<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, '[/] Fuzzily search in current buffer')
  map('<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, '[S]earch [/] in Open Files')

  -- Shortcut for searching your Neovim configuration files
  map('<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, '[S]earch [N]eovim files')
end
--}}}

-- Barbar, tab manager
map('<Tab>', ':BufferNext<CR>', '[TAB]: Next')
map('<S-Tab>', ':BufferPrevious<CR>', '[TAB]: Previous')
map('<Space>x', ':BufferClose<CR>', '[TAB]: Close')

-- Toggleterm, better terminal management
local function toggle_term(direction, name)
  return ':ToggleTerm direction=' .. direction .. ' name=' .. name .. '<CR>'
end
map('<Space>th', toggle_term('horizontal', 'HTerm'), '[Term]: Toggle horizontal')

map('<Space>tv', toggle_term('vertical', 'HTerm'), '[Term]: Toggle vertical')

return M
