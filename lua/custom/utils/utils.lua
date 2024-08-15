local M = {}

local function file_exists(file)
  local f = io.open(file, 'rb')
  if f then
    f:close()
  end
  return f ~= nil
end

local function split_str(str, sep)
  if sep == nil then
    sep = '%s'
  end
  local t = {}
  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    table.insert(t, s)
  end

  return t
end

M.get_valid_filename = function()
  local filepath = vim.api.nvim_buf_get_name(0)
  local parts = split_str(filepath, '/')
  local filename = parts[#parts]
  if filename == nil then
    return ''
  end

  if filename:match '.ino$' then
    return filename
  else
    return ''
  end
end

M.get_curr_board = function()
  local file = '/home/cappe/.config/arduino/curr_board'
  if not file_exists(file) then
    return ''
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines[1]
end

M.compile_to_board = function()
  local curr_board = M.get_curr_board()
  local cmd = 'arduino-cli compile -b ' .. curr_board .. ' ' .. vim.api.nvim_buf_get_name(0)
  os.execute(cmd)
end

M.get_valid_filename()

return M
