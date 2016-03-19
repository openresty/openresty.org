<!---
    @title         Redis Nginx Module
    @creator       Yichun Zhang
    @created       2012-05-13 04:16 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-09-13 17:55 GMT
    @changes       8
--->

This is an [Nginx](nginx.html) upstream module that makes nginx talk to a redis 2.x
server in a non-blocking way. It has a similar interface with the standard [ngx_memcached module](http://wiki.nginx.org/HttpMemcachedModule),
but only Redis `GET` and `SELECT` commands are supported.

This module returns the decoded result from the Redis server.

This module is written by Sergey A. Osokin.

This module is enabled by default and can be disabled by passing the `--without-http_redis_module` option
to the `./configure` script for [OpenResty](openresty.html).

Documentation wiki page: http://wiki.nginx.org/HttpRedisModule

When used in conjunction with [LuaNginxModule](lua-nginx-module.html), it is
recommended to use [LuaRestyRedisLibrary](lua-resty-redis-library.html) instead
of this one, since it is more flexible and more memory-efficient.
