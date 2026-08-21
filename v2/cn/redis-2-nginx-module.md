<!---
    @title         Redis2 Nginx 模块
    @description   redis2-nginx-module 是让 Nginx 以非阻塞方式与 Redis 2.x 通信的 upstream 模块，实现完整 Redis 统一协议与流水线，并返回原始 TCP 响应。
    @creator       Yichun Zhang
    @created       2011-06-21 08:47 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-09-06 08:34 GMT
    @changes       7
--->

This is an [Nginx](nginx.html) upstream module that makes nginx talk to a redis 2.x
server in a non-blocking way. The full Redis 2.0 unified protocol has been implemented
including the redis pipelining support.

This module returns the raw TCP response from the redis server.

Documentation wiki page: https://wiki.nginx.org/HttpRedis2Module

Project page: https://github.com/agentzh/redis2-nginx-module
