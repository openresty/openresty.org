<!---
    @title         Lua Resty MySQL 库
    @description   lua-resty-mysql 是基于 cosocket 的 MySQL 客户端驱动，为 OpenResty® 应用提供非阻塞的 MySQL 访问。
    @creator       Yichun Zhang
    @created       2012-10-17 23:04 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Lua [MySQL](https://en.wikipedia.org/wiki/MySQL) client driver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-mysql

This library is enabled by default. You can specify the `--without-lua_resty_mysql` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
