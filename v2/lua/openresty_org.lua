local _M = {}

local controller = require "openresty_org.controller"

function _M.go()
    controller.run()
end

function _M.security_txt()
    controller.security_txt()
end

return _M
