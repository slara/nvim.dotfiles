-- OSC 52 clipboard provider for nvim in tmux
local M = {}

-- Base64 encoding function
local function base64_encode(data)
  local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
  local result = {}
  local pad = ''
  
  for i = 1, #data, 3 do
    local b1, b2, b3 = data:byte(i, i+2)
    b2 = b2 or 0
    b3 = b3 or 0
    
    local n = b1 * 65536 + b2 * 256 + b3
    
    result[#result + 1] = b64chars:sub(math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
    result[#result + 1] = b64chars:sub(math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
    result[#result + 1] = b2 and b64chars:sub(math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or '='
    result[#result + 1] = b3 and b64chars:sub(n % 64 + 1, n % 64 + 1) or '='
  end
  
  return table.concat(result)
end

-- Copy function using OSC 52
function M.copy(lines, regtype)
  local text = table.concat(lines, '\n')
  local encoded = base64_encode(text)
  local osc52 = string.format('\027]52;c;%s\007', encoded)
  
  -- Write to tmux's clipboard
  io.stderr:write(osc52)
  io.stderr:flush()
end

-- Paste function (fallback to system)
function M.paste()
  local handle = io.popen('pbpaste')
  if handle then
    local result = handle:read('*a')
    handle:close()
    return vim.split(result, '\n')
  end
  return {}
end

-- Setup clipboard provider
function M.setup()
  vim.g.clipboard = {
    name = 'osc52',
    copy = {
      ['+'] = M.copy,
      ['*'] = M.copy,
    },
    paste = {
      ['+'] = M.paste,
      ['*'] = M.paste,
    },
    cache_enabled = 0,
  }
end

return M