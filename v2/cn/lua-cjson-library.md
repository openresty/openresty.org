<!---
    @title         Lua Cjson 库
    @description   lua-cjson 是 C 语言实现的 Lua JSON 库，为 Lua 提供快速的 JSON 解析与编码支持，是 OpenResty® 中常用的 JSON 处理组件。
    @creator       Yichun Zhang
    @created       2011-08-11 02:08 GMT
--->

Lua CJSON is a Lua C module that provides fast JSON parsing and encoding support
for Lua.

Project homepage: https://www.kyne.com.au/~mark/software/lua-cjson.php

OpenResty includes its own fork of this library, however. The repository of OpenResty's
fork is on GitHub:

https://github.com/openresty/lua-cjson/

This library is enabled by default. You can specify the `--without-lua_cjson` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
