<!---
    @title         Lua Resty DNS Library
    @creator       Yichun Zhang
    @created       2012-11-12 02:14 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Nonblocking DNS (Domain Name System) resolver for [Lua Nginx Module](lua-nginx-module.html) based
on the cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-dns

This library is enabled by default. You can specify the `--without-lua_resty_dns` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
