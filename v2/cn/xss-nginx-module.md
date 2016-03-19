<!---
    @title         Xss Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 09:05 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-21 09:07 GMT
    @changes       2
--->

This module adds cross-site AJAX support to nginx. Currently only cross-site
GET is supported.

The cross-site GET is currently implemented as JSONP (or "JSON with padding").
See http://en.wikipedia.org/wiki/JSON#JSONP for more details.

Project page: http://github.com/agentzh/xss-nginx-module
