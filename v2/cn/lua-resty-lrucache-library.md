<!---
    @title         Lua Resty Lrucache 库
    @description   lua-resty-lrucache 实现纯 Lua 的 LRU（最近最少使用）缓存，为 OpenResty® 应用提供进程级的内存缓存能力。
    @creator       Yichun Zhang
    @created       2014-06-07 22:54 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Implements a Lua-land LRU cache for [OpenResty](openresty.html).

Project homepage: https://github.com/openresty/lua-resty-lrucache

This library is enabled by default. You can specify the `--without-lua_resty_lrucache` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
