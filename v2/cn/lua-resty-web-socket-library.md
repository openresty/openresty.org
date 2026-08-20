<!---
    @title         Lua Resty Web Socket 库
    @description   lua-resty-websocket 基于 cosocket 实现了非阻塞的 WebSocket 服务端与客户端，为 OpenResty® 应用提供 WebSocket 支持。
    @creator       Yichun Zhang
    @created       2013-09-30 06:58 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->

This Lua library implements both a nonblocking WebSocket server and a nonblocking
WebSocket client based on [Lua Nginx Module](lua-nginx-module.html)'s cosocket
API.

Project homepage: https://github.com/agentzh/lua-resty-websocket

This library is enabled by default. You can specify the `--without-lua_resty_websocket` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
