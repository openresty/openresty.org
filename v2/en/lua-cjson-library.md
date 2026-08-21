<!---
    @title         Lua Cjson Library
    @description   Lua CJSON is a Lua C module providing fast JSON parsing and encoding, bundled and forked by OpenResty® for high-performance JSON handling.
    @creator       Yichun Zhang
    @created       2011-08-11 02:08 GMT
--->

Lua CJSON is a Lua C module that provides fast JSON parsing and encoding support
for Lua.

Project homepage: https://kyne.au/~mark/software/lua-cjson.php

OpenResty includes its own fork of this library, however. The repository of OpenResty's
fork is on GitHub:

https://github.com/openresty/lua-cjson/

This library is enabled by default. You can specify the `--without-lua_cjson` option
to [OpenResty](openresty.html)'s `./configure` script to explicitly disable it.
