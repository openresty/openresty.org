<!---
    @title         Lua Resty Upstream Healthcheck 库
    @description   lua-resty-upstream-healthcheck 是纯 Lua 实现的 Nginx upstream 服务器健康检查器，可主动探测后端状态并按结果调整负载均衡。
    @creator       Yichun Zhang
    @created       2014-03-31 05:13 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Health Checker for [Nginx](nginx.html) Upstream Servers in Pure Lua.

Project homepage: https://github.com/agentzh/lua-resty-upstream-healthcheck

This library is enabled by default. You can specify the `--without-lua_resty_upstream_healthcheck` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
