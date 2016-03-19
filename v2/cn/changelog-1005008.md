<!---
    @title         ChangeLog 1.5.8
    @creator       Yichun Zhang
    @created       2014-01-11 04:27 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->


#  Mainline Version 1.5.8.1 - 10 January 2014
* change: now we default to [LuaJIT](luajit.html) instead of the standard Lua 5.1
interpreter. the `--with-luajit` option for `./configure` is now the default.
To use the standard Lua 5.1 interpreter, specify the `--with-lua51` option explicitly.
* bugfix: [Nginx](nginx.html)'s built-in resolver did not accept fully qualified
domain names (with a trailing dot).
* optimize: shortened the `Server` response header string "ngx_openresty" to
"openresty".
* upgraded the [Nginx](nginx.html) core to 1.5.8.
    * see the changes here: http://nginx.org/en/CHANGES
* upgraded [LuaJIT](luajit.html) to v2.1-20140109.
    * bugfix: fixed ABC (Array Bounds Check) elimination. (Mike Pall)
    * bugfix: fixed MinGW build. (Mike Pall)
    * bugfix: x86: fixed stack slot counting for IR_CALLA (affects table.new). (Mike Pall) this could lead to random table field missing issues in [Lua Resty MySQL Library](lua-resty-mysql-library.html) on i386. thanks lhmwzy for the report.
    * bugfix: fixed compilation of `string.byte(s, nil, n)`. (Mike Pall)
    * bugfix: MIPS: Cosmetic fix for interpreter. (Mike Pall)
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.4.
    * feature: allow use of [ngx.exit()](https://github.com/chaoslawful/lua-nginx-module#ngxexit) in the context of [header_filter_by_lua*](https://github.com/chaoslawful/lua-nginx-module#header_filter_by_lua) to perform a "filter finalization". but in this context [ngx.exit()](https://github.com/chaoslawful/lua-nginx-module#ngxexit) is an asynchronous operation and returns immediately.
    * feature: added the optional 5th argument, "res_table", to [ngx.re.match()](https://github.com/chaoslawful/lua-nginx-module#ngxrematch) which is the user-supplied result table for the resulting captures. This feature can give 12%+ speedup for simple [ngx.re.match()](https://github.com/chaoslawful/lua-nginx-module#ngxrematch) calls with 4 submatch captures.
    * feature: [ngx.escape_uri()](https://github.com/chaoslawful/lua-nginx-module#ngxescape_uri) and [ngx.unescape_uri()](https://github.com/chaoslawful/lua-nginx-module#ngxunescape_uri) now accept a `nil` argument, which is equivalent to an empty string.
    * feature: added new pure C API, `ngx_http_lua_ffi_max_regex_cache_size`, for FFI-based implementations like [Lua Resty Core Library](lua-resty-core-library.html).
    * change: [ngx.decode_base64()](https://github.com/chaoslawful/lua-nginx-module#ngxdecode_base64) now only accepts string arguments.
    * bugfix: coroutines might incorrectly enter the "dead" state even right after creation with [coroutine.create()](https://github.com/chaoslawful/lua-nginx-module#coroutinecreate). thanks James Hurst for the report.
    * bugfix: segmentation fault might happen when aborting a "light thread" pending on downstream cosocket writes. thanks Aviram Cohen for the report.
    * bugfix: we might try sending the response header again in [ngx.exit()](https://github.com/chaoslawful/lua-nginx-module#ngxexit) when the header was already sent.
    * bugfix: subrequests initiated by [ngx.location.capture()](https://github.com/chaoslawful/lua-nginx-module#ngxlocationcapture) might send their own response headers more than once. this issue might also lead to the alert message "header already sent" and request aborts when nginx 1.5.4+ was used.
    * bugfix: fixed incompatibilities in [Nginx](nginx.html) 1.5.8 which breaks the resolver API in the [Nginx](nginx.html) core.
    * bugfix: fixed a compilation warning when PCRE is disabled in the build. thanks Jay for the patch.
    * bugfix: we did not set the shortcut fields in `r->headers_in` for request headers in our subrequests created by [ngx.location.capture*()](https://github.com/chaoslawful/lua-nginx-module#ngxlocationcapture), which might cause inter-operative issues with other [Nginx](nginx.html) modules. thanks Aviram Cohen for the original patch.
    * optimize: we no longer clear the `lua_State` pointers for dead "light threads" such that their coroutine context structs could be reused by other "light threads" and user coroutines. this can lead to smaller memory footprint.
    * doc: documented that the [coroutine.*](https://github.com/chaoslawful/lua-nginx-module#coroutinecreate) API can be used in [init_by_lua](https://github.com/chaoslawful/lua-nginx-module#init_by_lua)* since 0.9.2. thanks Ruoshan Huang for the reminder.
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.13.
    * optimize: saved one cosocket [receive()](https://github.com/chaoslawful/lua-nginx-module#tcpsockreceive) call in the [get()](https://github.com/agentzh/lua-resty-memcached#get) and [gets()](https://github.com/agentzh/lua-resty-memcached#gets) methods.
    * bugfix: the Memcached connection might enter a bad state when read timeout happens because [Lua Nginx Module](lua-nginx-module.html)'s cosocket reading calls no longer automatically close the connection in this case. thanks Dane Knecht for the report.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.18.
    * optimize: eliminated one (potentially expensive) `string.sub()` call in the Redis reply parser.
    * bugfix: the Redis connection might enter a bad state when read timeout happens because [Lua Nginx Module](lua-nginx-module.html)'s cosocket reading calls no longer automatically close the connection in this case.
* upgraded [Lua Resty Lock Library](lua-resty-lock-library.html) to 0.02.
    * bugfix: the [lock()](https://github.com/agentzh/lua-resty-lock#lock) method accepted nil keys silently.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.11.
    * bugfix: avoided use of the module() built-in to define the Lua module.
    * bugfix: we did not reject bad domain names with a leading dot. thanks Dane Knecht for the report.
    * bugfix: error handling fixes in the [query](https://github.com/agentzh/lua-resty-dns#query) and [tcp_query](https://github.com/agentzh/lua-resty-dns#tcp_query) methods.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.3.
    * feature: updated to comply with [Lua Nginx Module](lua-nginx-module.html) 0.9.4.
    * bugfix: [resty.core.regex](https://github.com/agentzh/lua-resty-core#restycoreregex): the [ngx.re](https://github.com/chaoslawful/lua-nginx-module#ngxrematch) API did not honour the [lua_regex_cache_max_entries](https://github.com/chaoslawful/lua-nginx-module#lua_regex_cache_max_entries) configuration directive.
    * optimize: [ngx.re.gsub](https://github.com/chaoslawful/lua-nginx-module#ngxregsub) used to use literal type string "const char *" in ffi.cast() which is expensive in interpreter mode. now we use the ctype object directly, which leads to 11% in interpreter mode.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.51.
    * bugfix: for [Nginx](nginx.html) 1.2.6+ and 1.3.9+, the main request reference count might go out of sync when [Nginx](nginx.html)'s request body reader returned status code 300+. thanks Hungpu DU for the report.
    * bugfix: [echo_request_body](https://github.com/agentzh/echo-nginx-module#echo_request_body) truncated the response body prematurely when the request body was in memory (because the request reader sets "last_buf" in this case). thanks Hungpu DU for the original patch.
    * bugfix: using [$echo_timer_elapsed](https://github.com/agentzh/echo-nginx-module#echo_timer_elapsed) variable alone in the configuration caused segmentation faults. thanks Hungpu DU for the report.
    * doc: typo fix in the [echo_foreach_split](https://github.com/agentzh/echo-nginx-module#echo_foreach_split) sample code. thanks Hungpu DU for the report.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.7.
    * bugfix: fixed most of warnings and errors from the Microsoft Visual C++ compiler, reported by Edwin Cleton.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.25.
    * bugfix: fixed a warning from the Microsoft C compiler. thanks Edwin Cleton for the report.
    * doc: documented the limitation that we cannot remove the "Connection" response header with this module. thanks Michael Orlando for bringing this up.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.24.
    * bugfix: fixed the warnings from the Microsoft C compiler. thanks Edwin Cleton for the report.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.25.
    * feature: now the value specified in [srcache_store_skip](https://github.com/agentzh/srcache-nginx-module#srcache_store_skip) is evaluated and tested again right after the end of the response body data stream is seen. thanks Eldar Zaitov for the patch.
See [ChangeLog 1.4.3](changelog-1004003.html) for change log for [OpenResty](openresty.html) 1.4.3.x.
