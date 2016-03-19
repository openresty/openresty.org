<!---
    @title         ChangeLog 1.9.3
    @creator       Yichun Zhang
    @created       2015-07-31 03:33 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-11-23 13:14 GMT
    @changes       32
--->


#  Version 1.9.3.2 - 23 November 2015
* feature: added support for compiling on Windows using the MinGW gcc toolchain
to the build system. See the document for more details: https://github.com/openresty/ngx_openresty/blob/master/doc/README-win32.md
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.19.
    * feature: implemented `*_by_lua_block {} ` directives for all the existing `*_by_lua` directives so that we no longer have to escape special characters while inlining Lua source inside the `nginx.conf` file.
    * feature: now we support [LuaJIT](luajit.html) 2 on Windows (in the form of `lua51.dll`).
    * feature: initial fixes when being used with the new `ngx_http_v2` module since nginx 1.9.5. thanks itpp16 for the patches.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
    * bugfix: subrequest response status codes between the range 100 .. 299 (inclusive) might get lost in the return values of [ngx.location.capture*()](https://github.com/openresty/lua-nginx-module#ngxlocationcapture) calls. thanks Igor Clark for the report.
    * bugfix: we might return the wrong shm zone in the public C API function `ngx_http_lua_find_zone()`. thanks qlee001 for the report.
    * bugfix: the user specified `./configure`'s `--with-cc-opt` and `--with-ld-opt` might override the `LUAJIT_INC`/`LUAJIT_LIB` and `LUA_INC`/`LUA_LIB` environment settings. thanks Julian Gonggrijp for the report.
    * bugfix: setting builtin request header `Upgrade` via [ngx.req.set_header](https://github.com/openresty/lua-nginx-module#ngxreqset_header) and etc might not take effect with some builtin nginx modules.
    * bugfix: setting builtin request headers `Depth`, `Destination`, `Overwrite`, and `Date` via [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header) and etc might not take effect at least with [ngx_http_dav_module](http://nginx.org/en/docs/http/ngx_http_dav_module.html). thanks Igor Clark for the report.
    * bugfix: fixed typos due to copy&paste mistakes in some error messages.
    * bugfix: fixed one `-Wmaybe-uninitialized` warning when compiling with `gcc -Os`.
    * bugfix: use of shared dicts resulted in (unwanted) registrations of shared dict metatables on *all* the lightuserdata in the Lua space. thanks helloyi for the report and patch.
    * bugfix: if a 3rd-party module calls `ngx_http_conf_get_module_srv_conf` to fetch its current `srv_conf` construct in its `merge_srv_conf` callback, then use of [init_worker_by_lua](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) might lead to segmentation faults (the same also applied to merge_loc_conf). thanks chiyouhen for the report and patch.
    * bugfix: the `if_unmodified_since` "shortcut" field in `ngx_http_headers_in_t` was first added in nginx 0.9.2.
    * bugfix: [ngx.req.clear_header](https://github.com/openresty/lua-nginx-module#ngxreqclear_header)/[ngx.req.set_header](https://github.com/openresty/lua-nginx-module#ngxreqset_header): we did not update the shortcut fields in `ngx_http_headers_in_t` added since nginx 1.3.3 which may confuse other nginx modules accessing them.
    * bugfix: setting `Content-Type` response values including "; charset=xxx" via the [ngx.header](https://github.com/openresty/lua-nginx-module#ngxheaderheader) API might bypass the MIME type checks in other nginx modules like [ngx_gzip](http://nginx.org/en/docs/http/ngx_http_gzip_module.html). thanks Andreas Fischer for the report.
    * bugfix: typo fixes in some debug logging messages. thanks doujiang for the patch.
    * optimize: fixed the hash-table initial sizes of the cosocket metatables. thanks ops-dev-cn for the patch.
    * tests: removed the useless "use lib" directives from the Perl test files. thanks Markus Linnala for the report.
    * doc: various typo fixes from Lance Li.
    * doc: [ngx.exit](https://github.com/openresty/lua-nginx-module#ngxexit) was not disabled within the [header_filter_by_lua*](https://github.com/openresty/lua-nginx-module#header_filter_by_lua) context.
    * doc: a code example misses a "return". thanks YuanSheng Wang for the patch.
    * doc: [ngx.var](https://github.com/openresty/lua-nginx-module#ngxvarvariable): documented the values for undefined and uninitialized nginx variables. thanks Sean Johnson for asking.
    * doc: typo fix from Tatsuya Hoshino.
* upgraded [Lua Upstream Nginx Module](lua-upstream-nginx-module.html) to 0.04.
    * feature: `upstream.get_servers(server_name)` now returns the server name (if any) as well, which can be the domain name if the user puts it in `nginx.conf`. thanks Hung Nguyen for the request.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.28.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
    * bugfix: setting (builtin) request headers `Upgrade`, `Depth`, `Destination`, `Overwrite`, and `Date` might not take effect in standard nginx modules like [ngx_http_proxy](http://nginx.org/en/docs/http/ngx_http_proxy_module.html) and [ngx_http_dav](http://nginx.org/en/docs/http/ngx_http_dav_module.html).
    * bugfix: when the response header `Content-Type` contains parameters like "; charset=utf-8", the `-t MIME-List` options did not work as expected at all. thanks Joseph Bartels for the report.
    * bugfix: clearing input headers `If-Unmodified-Since`, `If-Match`, and `If-None-Match` did not clear the builtin "shortcut" fields in `ngx_http_headers_in_t` which might confuse other nginx modules like `ngx_http_not_modified_filter_module`. The first header gets "shortcuts" fields since nginx 0.9.2 while the latter two since nginx 1.3.3.
* upgraded [Iconv Nginx Module](iconv-nginx-module.html) to 0.13.
    * bugfix: HTTP 0.9 requests would turn `iconv_filter` into a bad unrecoverable state leading to "iconv body filter skiped" error upon every subsequent request. thanks numberlife for the report. also introduced some coding style fixes.
    * bugfix: lowered the error log level for HTTP 0.9 requests from "error" to "warn" to prevent malicious clients from flooding the error logs.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.21.
    * bugfix: the "attempt to call local new_tab (a table value)" error might happen when [LuaJIT](luajit.html) 2.0 was used and a local Lua module named "table.new" was visible. thanks Michael Pirogov for the report.
    * doc: fixed code examples to check redis pipelined requests' return values more strictly. some commands (like hkeys and smembers) may return empty tables, which may result in `nil res[1]` values. thanks Dejiang Zhu for the patch.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.1.2.
    * change: updated the implementation to reflect recent changes in shared dictionary zones of [Lua Nginx Module](lua-nginx-module.html). now we require [Lua Nginx Module](lua-nginx-module.html) 0.9.17+.
* upgraded [Lua Cjson Library](lua-cjson-library.html) to 2.1.0.3.
    * feature: now we allow up to 16 decimal places in JSON number encoding via `cjson.encode_number_precision()`. thanks lordnynex for the patch.
    * bugfix: fixed the warning "inline function ‘fpconv_init’ declared but never defined" from gcc.
    * bugfix: Makefile: removed the slash (`/`) after `$(DESTDIR)` so as to support relative path values in make variable `LUA_LIB_DIR`.
* upgraded [Resty CLI](resty-cli.html) to 0.04.
    * feature: now the `resty` command-line utility looks for an nginx under the directory of itself as well (for Win32 [OpenResty](openresty.html)).
    * bugfix: worked around a bug regarding temp directory cleanup in msys perl 5.8.8 (and possibly other versions of msys perl as well).
    * bugfix: ensure we append an appropriate executable file extension when testing the existence of executables on exotic systems like Win32.
* upgraded [Lua Rds Parser Library](lua-rds-parser-library.html) to 0.06.
    * bugfix: fixed the `u_char` C data type for MinGW gcc which lacks it.
    * bugfix: Makefile: added an explicit `.c -> .o` rule to help MinGW make.
    * bugfix: Makefile: removed the slash (`/`) after `$(DESTDIR)` so as to support relative path values in make variable `LUA_LIB_DIR`.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to 0.12.
    * bugfix: Makefile: added an explicit `.c -> .o` rule to help MinGW make.
    * bugfix: Makefile: removed the slash (`/`) after `$(DESTDIR)` so as to support relative path values in make variable `LUA_LIB_DIR`.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.07.
    * bugfix: fixed compilation errors with MinGW gcc on Win32.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded [LuaJIT](luajit.html) to v2.1-20151028: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * limit number of arguments given to `io.lines()` and `fp:lines()`.
        * ARM64: fix `__call` metamethod handling for tail calls.
        * FFI: Do not propagate qualifiers into subtypes of complex.
        * feature: parse binary number literals (`0bxxx`).
        * fix NYICF error message.
        * properly handle OOM in `trace_save()`.
        * ARM64: add support for saving bytecode as object files.
        * ARM64: fix ELF bytecode saving.
        * feature: parse Unicode string escape `\u{XX...} `.
        * FFI: add `ssize_t` declaration.
        * fix unsinking check.
        * feature: add `collectgarbage("isrunning")`.
        * flush symbol tables in `jit.dump` on trace flush.

#  Version 1.9.3.1 - 12 August 2015
* upgraded the [Nginx](nginx.html) core to 1.9.3.
    * see the changes here: http://nginx.org/en/CHANGES
* bugfix: `./configure --help`: fixed the usage text for the `--with-debug` option.
thanks Kipras Mancevičius for the report.
* bugfix: link failures with OpenSSL might happen on 64-bit Mac OS X when the
`./configure` option `--with-openssl=PATH` was used and the OpenSSL source was
recent enough. thanks grasses for the report.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc7.
    * feature: fixed compilation errors with nginx 1.9.1+. thanks Vadim A. Misbakh-Soloviov for the original patch.
See [ChangeLog 1.7.10](changelog-1007010.html) for change log for [OpenResty](openresty.html) 1.7.10.x.
