<!---
    @title         Lua Rds Parser 库
    @description   lua-rds-parser 用于将 Drizzle/Postgres 模块生成的 Resty-DBD-Stream（RDS）数据解析为 Lua 数据结构，纯 C 实现，速度快且内存占用低。
    @creator       Yichun Zhang
    @created       2011-08-31 07:38 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-31 07:40 GMT
    @changes       5
--->

This Lua library can be used to parse the Resty-DBD-Stream formatted data generated
by [Drizzle Nginx Module](drizzle-nginx-module.html) and [Postgres Nginx Module](postgres-nginx-module.html) into
Lua data structures. In the past, we have to use JSON as the intermediate data
format which is quite inefficient in terms of both memory and CPU time.

To maximize speed and minimize memory footprint, this library is implemented
in pure C.

This library is enabled by default; use the `--without-lua_rds_parser` option
to disable it when running `./configure` to build [OpenResty](openresty.html).

Project homepage: https://github.com/agentzh/lua-rds-parser
