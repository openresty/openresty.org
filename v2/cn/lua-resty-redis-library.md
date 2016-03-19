<!---
    @title         Lua Resty Redis Library
    @creator       Yichun Zhang
    @created       2012-10-17 23:03 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Lua [Redis](http://redis.io/) client driver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-redis

This library is enabled by default. You can specify the `--without-lua_resty_redis` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
