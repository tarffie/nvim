function GetOS()
  local osname
  osname = jit.os
  if not osname then
    -- Unix, Linux variants
    local fh = io.popen("uname -o 2>/dev/null", "r")
    osname = fh:read()
  end

  return osname or "Windows"
end
