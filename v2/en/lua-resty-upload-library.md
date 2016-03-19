<!---
    @title         Lua Resty Upload Library
    @creator       Yichun Zhang
    @created       2012-02-29 07:39 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

Streaming reader and parser for HTTP file uploading based on [Lua Nginx Module](lua-nginx-module.html)'s
cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-upload

This library is enabled by default. You can specify the `--without-lua_resty_upload` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
