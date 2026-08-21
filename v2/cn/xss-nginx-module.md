<!---
    @title         Xss Nginx 模块
    @description   xss-nginx-module 为 Nginx 增加跨站 AJAX 支持，目前以 JSONP 方式实现跨站 GET 请求。
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
See https://en.wikipedia.org/wiki/JSON#JSONP for more details.

Project page: https://github.com/agentzh/xss-nginx-module
