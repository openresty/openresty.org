local luasocket
do
  local __flatten
  __flatten = function(t, buffer)
    local _exp_0 = type(t)
    if "string" == _exp_0 then
      buffer[#buffer + 1] = t
    elseif "table" == _exp_0 then
      for _index_0 = 1, #t do
        local thing = t[_index_0]
        __flatten(thing, buffer)
      end
    end
  end
  local _flatten
  _flatten = function(t)
    local buffer = { }
    __flatten(t, buffer)
    return table.concat(buffer)
  end
  local proxy_mt = {
    __index = function(self, key)
      local sock = self.sock
      local original = sock[key]
      if type(original) == "function" then
        local fn
        fn = function(_, ...)
          return original(sock, ...)
        end
        self[key] = fn
        return fn
      else
        return original
      end
    end
  }
  luasocket = {
    tcp = function(...)
      local socket = require("socket")
      local sock = socket.tcp(...)
      local proxy = setmetatable({
        sock = sock,
        send = function(self, ...)
          return self.sock:send(_flatten(...))
        end,
        getreusedtimes = function(self)
          return 0
        end
      }, proxy_mt)
      return proxy
    end
  }
end
return {
  new = function()
    if ngx and ngx.get_phase() ~= "init" then
      return ngx.socket.tcp()
    else
      return luasocket.tcp()
    end
  end
}
