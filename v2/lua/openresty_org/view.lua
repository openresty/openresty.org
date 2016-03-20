local _M = {}

local templates = require "openresty_org.templates"
local i18n = require "openresty_org.i18n"

local c = {}

function _M.process(key, stash, i18n)
    stash.c = c
    c.l = i18n.translate
    return templates.process(key, stash)
end

return _M
