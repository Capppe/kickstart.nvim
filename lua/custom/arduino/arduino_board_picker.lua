local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local M = {}

local function trim(s)
  return s:match '^%s*(.-)%s*$'
end

local function run_command(cmd)
  local handle = io.popen(cmd)
  if handle == nil then
    return
  end

  local result = handle:read '*a'
  handle:close()
  return result
end

local function parse(json)
  local boards = {}

  for name, fqbn in json:gmatch '"name"%s*:%s*"([^"]+)"%s*,%s*"fqbn"%s*:%s*"([^"]+)"' do
    table.insert(boards, { name = trim(name), fqbn = trim(fqbn) })
  end

  return boards
end

M.select_boards = function(opts)
  local json_output = run_command 'arduino-cli board list --json | jq [".detected_ports[0].matching_boards[]"]'

  local parsed_data = parse(json_output)

  local items = {}
  for _, board in ipairs(parsed_data) do
    table.insert(items, board)
  end

  pickers
    .new(opts, {
      prompt_title = 'Select board',
      finder = finders.new_table {
        results = items,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.name .. ' (' .. entry.fqbn .. ')',
            ordinal = entry.name,
          }
        end,
        -- results = parse(json_string),
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          print(selection.value.fqbn)
        end)
        return true
      end,
    })
    :find()
end

return M
