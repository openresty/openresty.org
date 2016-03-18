local _M = {}

local controller = require "openresty_org.controller"

function _M.go()
    controller.run()
end

return _M
