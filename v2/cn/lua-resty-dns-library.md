<!---
    @title         Lua Resty DNS 库
    @description   lua-resty-dns 是基于 cosocket API 的非阻塞 DNS 解析器，为 OpenResty® 应用提供异步的域名解析能力。
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
