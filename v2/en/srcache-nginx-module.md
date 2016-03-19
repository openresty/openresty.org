<!---
    @title         Srcache Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 09:07 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-10-17 23:36 GMT
    @changes       6
--->

This module provides a transparent caching layer for arbitrary nginx locations
(like those use an upstream or even serve static disk files).

Usually, the [Memc Nginx Module](memc-nginx-module.html) is used together with
this module to provide a concrete caching storage backend. But technically,
any modules that provide a REST interface can be used as the fetching and storage
subrequests used by this module.

Documentation page: https://github.com/agentzh/srcache-nginx-module#readme

Project page: http://github.com/agentzh/srcache-nginx-module
