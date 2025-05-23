local M = {}
function M.getOS() -- ask LuaJIT first
  if jit then
    return jit.os
  end

  -- Unix, Linux variants
  local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
  local osname
  if fh then
    osname = fh:read()
  end

  return osname or "Windows"
end

return M
