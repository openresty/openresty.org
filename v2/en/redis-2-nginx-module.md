<!---
    @title         Redis2 Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 08:47 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-10-17 23:36 GMT
    @changes       12
--->

This is an [Nginx](nginx.html) upstream module that makes nginx talk to a redis 2.x
server in a non-blocking way. The full Redis 2.0 unified protocol has been implemented
including the redis pipelining support.

This module returns the raw TCP response from the Redis server.

This module is enabled by default and can be disabled by passing the `--without-http_redis2_module` option
to the `./configure` script for [OpenResty](openresty.html).

Documentation wiki page: https://github.com/agentzh/redis2-nginx-module#readme

Project page: https://github.com/agentzh/redis2-nginx-module

When used in conjunction with [LuaNginxModule](lua-nginx-module.html), it is
recommended to use [LuaRestyRedisLibrary](lua-resty-redis-library.html) module
instead of this one, since it is more flexible and more memory-efficient.
