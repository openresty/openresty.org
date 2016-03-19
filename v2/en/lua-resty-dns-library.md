<!---
    @title         Lua Resty DNS Library
    @creator       Yichun Zhang
    @created       2012-08-06 06:54 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-08-06 06:55 GMT
    @changes       2
--->

Nonblocking DNS (Domain Name System) resolver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-dns

This library is enabled by default. You can specify the `--without-lua_resty_dns` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
