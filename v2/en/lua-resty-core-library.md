<!---
    @title         Lua Resty Core Library
    @creator       Yichun Zhang
    @created       2013-12-14 22:59 GMT
    @modifier      YichunZhang
    @modified      2014-06-01 05:55 GMT
    @changecount   2
--->

Reimplements the Lua API provided by [Lua Nginx Module](lua-nginx-module/) with [LuaJIT](luajit/) FFI.

Project homepage: https://github.com/openresty/lua-resty-core

This library is enabled by default. You can specify the `--without-lua_resty_core` option to [OpenResty](openresty/)'s `./configure` script to explicitly disable it.
