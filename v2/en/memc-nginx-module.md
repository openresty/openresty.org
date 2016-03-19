<!---
    @title         Memc Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 08:30 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-10-17 23:34 GMT
    @changes       5
--->

This module extends the standard memcached module  to support almost the whole
memcached ascii protocol.

It allows you to define a custom REST interface to your memcached servers or
access memcached in a very efficient way from within the nginx server by means
of subrequests or independent fake requests. 

Documentation: https://github.com/agentzh/memc-nginx-module#readme

Project page: http://github.com/agentzh/memc-nginx-module

When used in conjunction with [LuaNginxModule](lua-nginx-module.html), it is
recommended to use [LuaRestyMemcachedLibrary](lua-resty-memcached-library.html) instead
of this one, since it is more flexible and more memory-efficient.
