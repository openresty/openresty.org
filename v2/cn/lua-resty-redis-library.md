<!---
    @title         Lua Resty Redis 库
    @description   lua-resty-redis 是基于 cosocket 的 Redis 客户端库，为 OpenResty® 应用提供高并发的 Redis 访问，支持连接池与流水线（pipelining）。
    @creator       Yichun Zhang
    @created       2012-10-17 23:03 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Lua [Redis](https://redis.io/) client driver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-redis

This library is enabled by default. You can specify the `--without-lua_resty_redis` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
