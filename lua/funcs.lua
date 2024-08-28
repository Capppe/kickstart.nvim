local M = {}

M.current_lsp = function()
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return ''
  else
    local current_client = clients[1]
    if current_client then
      return 'LSP: ' .. current_client.name
    else
      return 'LSP: Null'
    end
  end
end

M.current_git_branch = function()
  local branch = vim.g.gitsigns_head
  if branch == 'master' then
    return 'main'
  else
    return branch
  end
end

M.git_changes = function()
  local gitsigns_status = require 'gitsigns.status'
  return gitsigns_status
end

return M
