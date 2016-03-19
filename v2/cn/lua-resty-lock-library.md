<!---
    @title         Lua Resty Lock Library
    @creator       Yichun Zhang
    @created       2013-09-30 06:58 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

This Lua library implements a simple nonblocking mutex lock API based on [Lua Nginx Module](lua-nginx-module.html)'s
shared memory dictionaries. Mostly useful for eliminating "dog-pile effects".

Project homepage: https://github.com/agentzh/lua-resty-lock

This library is enabled by default. You can specify the `--without-lua_resty_lock` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
