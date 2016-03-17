<!---
    @title         Lua Resty Web Socket Library
    @creator       Yichun Zhang
    @created       2013-09-30 06:20 GMT
    @modifier      YichunZhang
    @modified      2013-09-30 06:24 GMT
    @changecount   3
--->

This Lua library implements both a nonblocking WebSocket server and a nonblocking WebSocket client based on [Lua Nginx Module](lua-nginx-module/)'s cosocket API.

Project homepage: https://github.com/agentzh/lua-resty-websocket

This library is enabled by default. You can specify the `--without-lua_resty_websocket` option to [OpenResty](openresty/)'s `./configure` script to explicitly disable it.
