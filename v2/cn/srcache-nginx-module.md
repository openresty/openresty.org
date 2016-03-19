<!---
    @title         Srcache Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 09:07 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-26 01:11 GMT
    @changes       5
--->

This module provides a transparent caching layer for arbitrary nginx locations
(like those use an upstream or even serve static disk files).

Usually, the [Memc Nginx Module](memc-nginx-module.html) is used together with
this module to provide a concrete caching storage backend. But technically,
any modules that provide a REST interface can be used as the fetching and storage
subrequests used by this module.

Documentation page: http://wiki.nginx.org/HttpSRCacheModule

Project page: http://github.com/agentzh/srcache-nginx-module
