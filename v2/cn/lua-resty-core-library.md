<!---
    @title         Lua Resty Core Library
    @creator       Yichun Zhang
    @created       2013-12-15 00:17 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Reimplements the Lua API provided by [Lua Nginx Module](lua-nginx-module.html) with
[LuaJIT](luajit.html) FFI.

Project homepage: https://github.com/agentzh/lua-resty-core

This library is enabled by default. You can specify the `--without-lua_resty_core` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
