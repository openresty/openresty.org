<!---
    @title         Memc Nginx 模块
    @description   memc-nginx-module 扩展了标准 memcached 模块，支持几乎完整的 memcached ASCII 协议，可通过子请求高效访问 memcached 并定义 REST 接口。
    @creator       Yichun Zhang
    @created       2011-06-21 08:30 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-26 01:11 GMT
    @changes       3
--->

This module extends the standard memcached module  to support almost the whole
memcached ascii protocol.

It allows you to define a custom REST interface to your memcached servers or
access memcached in a very efficient way from within the nginx server by means
of subrequests or independent fake requests. 

Documentation: https://wiki.nginx.org/HttpMemcModule
Project page: https://github.com/agentzh/memc-nginx-module
