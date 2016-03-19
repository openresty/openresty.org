<!---
    @title         Lua Resty Redis Library
    @creator       Yichun Zhang
    @created       2012-02-29 07:35 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-08-06 06:55 GMT
    @changes       4
--->

Lua [Redis](http://redis.io/) client driver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-redis

This library is enabled by default. You can specify the `--without-lua_resty_redis` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
