<!---
    @title         Redis Nginx 模块
    @description   redis-nginx-module 是让 Nginx 非阻塞访问 Redis 2.x 的 upstream 模块，接口类似标准 memcached 模块，支持 GET 与 SELECT 命令并返回解码结果。
    @creator       Yichun Zhang
    @created       2013-09-30 07:00 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

This is an [Nginx](nginx.html) upstream module that makes nginx talk to a redis 2.x
server in a non-blocking way. It has a similar interface with the standard [ngx_memcached module](https://wiki.nginx.org/HttpMemcachedModule),
but only Redis `GET` and `SELECT` commands are supported.

This module returns the decoded result from the Redis server.

This module is written by Sergey A. Osokin.

This module is enabled by default and can be disabled by passing the `--without-http_redis_module` option
to the `./configure` script for [OpenResty](openresty.html).

Documentation wiki page: https://wiki.nginx.org/HttpRedisModule

When used in conjunction with [LuaNginxModule](lua-nginx-module.html), it is
recommended to use [LuaRestyRedisLibrary](lua-resty-redis-library.html) instead
of this one, since it is more flexible and more memory-efficient.
