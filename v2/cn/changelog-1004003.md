<!---
    @title         ChangeLog 1.4.3
    @creator       Yichun Zhang
    @created       2013-10-29 20:41 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-12-15 02:50 GMT
    @changes       7
--->


#  Mainline Version 1.4.3.9 - 14 December 2013
* bugfix: the include path for [LuaJIT](luajit.html) C headers was still pointing
to `luajit-2.0`, which should have been `luajit-2.1` instead. thanks Tor Hveem
for the report.

#  Mainline Version 1.4.3.7 - 14 December 2013
* upgraded [LuaJIT](luajit.html) to v2.1-20131211.
    * see changes here: https://github.com/agentzh/luajit2/commits/v2.1-agentzh
* bundled [Lua Resty Core Library](lua-resty-core-library.html) 0.0.2.
    * this library reimplements [Lua Nginx Module](lua-nginx-module.html)'s Lua API with [LuaJIT](luajit.html) FFI. see https://github.com/agentzh/lua-resty-core for more details.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.3.
    * feature: added a lot of pure C API (without using any Lua VM's C API) for FFI-based Lua API implementations like [Lua Resty Core Library](lua-resty-core-library.html).
    * feature: allow creating 0-delay timers upon worker process existing.
    * feature: added new API function [ngx.worker.exiting()](https://github.com/chaoslawful/lua-nginx-module#ngxworkerexiting) for testing if the current worker process has started exiting.
    * feature: [ngx.re.find()](https://github.com/chaoslawful/lua-nginx-module#ngxrefind) now accepts the optional 5th argument "nth" to control which submatch capture's indexes are returned. thanks Lance Li for the feature request.
    * feature: added new API for version numbers of both [Nginx](nginx.html) and [Lua Nginx Module](lua-nginx-module.html) itself: [ngx.config.nginx_version](https://github.com/chaoslawful/lua-nginx-module#ngxconfignginx_version) and [ngx.config.ngx_lua_version](https://github.com/chaoslawful/lua-nginx-module#ngxconfigngx_lua_version). thanks smallfish for the patch.
    * feature: added support for loading [LuaJIT](luajit.html) 2.1 bytecode files directly in `*_by_lua_file` configuration directives.
    * bugfix: [ngx.req.set_header()](https://github.com/chaoslawful/lua-nginx-module#ngxreqset_header) did not completely override the existing request header with multiple values. thanks Aviram Cohen for the report.
    * bugfix: modifying request headers in a subrequest could lead to assertion failures and crashes. thanks leaf corcoran for the report.
    * bugfix: turning off [lua_code_cache](https://github.com/chaoslawful/lua-nginx-module#lua_code_cache) could lead to memory issues (segfaults and [LuaJIT](luajit.html) assertion failures) when Lua libraries using [LuaJIT](luajit.html) FFI were used. now we always create a clean separate Lua VM instance for every [Nginx](nginx.html) request served by us when the Lua code cache is disabled. thanks Ron Gomes for the report.
    * bugfix: the linker option `-E` is not support in Cygwin's linker; we should test `--export-all-symbols` at the same time. thanks Heero Zhang for the report.
    * bugfix: fixed the warnings from the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report.
    * optimize: optimized the implementation of [ngx.headers_sent](https://github.com/chaoslawful/lua-nginx-module#ngxheaders_sent) a bit.
    * doc: added new section "Statically Linking Pure Lua Modules": https://github.com/chaoslawful/lua-nginx-module#statically-linking-pure-lua-modules
    * doc: typo fixes from Zheng Ping.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.24.
    * bugfix: [more_set_input_headers](https://github.com/agentzh/headers-more-nginx-module#more_set_input_headers) did not completely override the existing request header with multiple values. thanks Aviram Cohen for the report.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.23.
    * feature: added new configuration directives [set_formatted_gmt_time](https://github.com/agentzh/set-misc-nginx-module#set_formatted_gmt_time) and [set_formatted_local_time](https://github.com/agentzh/set-misc-nginx-module#set_formatted_local_time). thanks Trurl McByte for the patch.
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.14.
    * feature: added new configuration directive [memc_ignore_client_abort](https://github.com/agentzh/memc-nginx-module#memc_ignore_client_abort). thanks Eldar Zaitov for the patch.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.13.
    * bugfix: fixed the warnings from the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.50.
    * bugfix: fixed the warnings from the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report.
* upgraded [Array Var Nginx Module](array-var-nginx-module.html) to 0.03.
    * bugfix: fixed the warnings from the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report.
* upgraded [Redis Nginx Module](redis-nginx-module.html) module to 0.3.7.
    * see changes here: http://mailman.nginx.org/pipermail/nginx/2013-December/041297.html
* feature: applied the [larger_max_error_str patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-larger_max_error_str.patch) to
the nginx core to allow error log messages up to 4096 bytes and to allow the
C macro `NGX_MAX_ERROR_STR` to be overridden from the outside.
* feature: added new configure option `--with-pcre-conf-opt=OPTIONS` to the
nginx core to allow custom PCRE ./configure build options. thanks Lance Li for
the original patch.

#  Stable Version 1.4.3.6 - 20 November 2013
* bugfix: applied the official patch [patch.2013.space.txt](http://nginx.org/download/patch.2013.space.txt) for
the [Nginx](nginx.html) core to fix the security issue CVE-2013-4547.

#  Stable Version 1.4.3.4 - 12 November 2013
This release is essentially the same as the last mainline release, 1.4.3.3.

The following components are bundled in this release:
* LuaJIT-2.0.2
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.6
* echo-nginx-module-0.49
* encrypted-session-nginx-module-0.03
* form-input-nginx-module-0.07
* headers-more-nginx-module-0.23
* iconv-nginx-module-0.10
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.10
* lua-resty-dns-0.10
* lua-resty-lock-0.01
* lua-resty-memcached-0.12
* lua-resty-mysql-0.14
* lua-resty-redis-0.17
* lua-resty-string-0.08
* lua-resty-upload-0.09
* lua-resty-websocket-0.02
* memc-nginx-module-0.13
* nginx-1.4.3
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.19
* ngx_lua-0.9.2
* ngx_postgres-1.0rc3
* rds-csv-nginx-module-0.05
* rds-json-nginx-module-0.12
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.10
* set-misc-nginx-module-0.22
* srcache-nginx-module-0.24
* xss-nginx-module-0.04

#  Mainline Version 1.4.3.3 - 6 November 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.2.
    * feature: added new API function [ngx.re.find()](https://github.com/chaoslawful/lua-nginx-module#ngxrefind), which is similar to [ngx.re.match](https://github.com/chaoslawful/lua-nginx-module#ngxrematch), but only returns the beginning index and end index (1-based) of the whole match, which is 30% ~ 40% faster than `ngx.re.match` for simplest regexes.
    * feature: added new API function [ngx.config.prefix()](https://github.com/chaoslawful/lua-nginx-module#ngxconfigprefix) to return the [Nginx](nginx.html) server "prefix" path.
    * bugfix: reading [ngx.header.HEADER](https://github.com/chaoslawful/lua-nginx-module#ngxheaderheader) could result in Lua string storage corruptions. thanks Dane Knecht for the report.
    * bugfix: [ngx.re.match](https://github.com/chaoslawful/lua-nginx-module#ngxrematch): the "ctx" parameter table's "pos" field should start from 1 instead of 0.
    * bugfix: fixed compilation errors with [Nginx](nginx.html) older than 1.0.0.
    * bugfix: localizing the [coroutine.*](https://github.com/chaoslawful/lua-nginx-module#coroutinecreate) API functions in [init_by_lua*](https://github.com/chaoslawful/lua-nginx-module#init_by_lua) for future use in contexts like [content_by_lua*](https://github.com/chaoslawful/lua-nginx-module#content_by_lua) might hang the request. thanks James Hurst for the report.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.24.
    * bugfix: fixed compilation errors with [Nginx](nginx.html) older than 0.9.2.
* bugfix: applied the [cache_manager_exit patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-cache_manager_exit.patch) to
the [Nginx](nginx.html) core to fix an issue when the cache manager process
is shutting down.

#  Mainline Version 1.4.3.1 - 29 October 2013
* upgraded the [Nginx](nginx.html) core to 1.4.3.
    * see the changes here: http://nginx.org/en/CHANGES-1.4
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.1.
    * feature: added the new configuration directive [lua_use_default_type](https://github.com/chaoslawful/lua-nginx-module#lua_use_default_type) for controlling whether to send out a default `Content-Type` response header (as defined by the [default_type](http://nginx.org/en/docs/http/ngx_http_core_module.html#default_type) directive). default on. thanks aviramc for the patch.
    * feature: now the raw request cosocket returned by [ngx.req.socket(true)](https://github.com/chaoslawful/lua-nginx-module#ngxreqsocket) no longer requires the request body to be read already, which means that one can use this cosocket to read the raw request body data as well. thanks aviramc for the original patch.
    * bugfix: when there were no existing `Cache-Control` response headers, `ngx.header.cache_control = nil` would (incorrectly) create a new `Cache-Control` header with an empty value. thanks jinglong for the patch.
    * bugfix: the original letter-case of the header name was lost when creating the `Cache-Control` response header via the [ngx.header.HEADER](https://github.com/chaoslawful/lua-nginx-module#ngxheaderheader) API.
    * bugfix: [ngx.req.set_header("Host", value)](https://github.com/chaoslawful/lua-nginx-module#ngxreqset_header) would overwrite the value of [$host](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_host) with bad values. thanks aviramc for the patch.
    * bugfix: use of [ngx.exit()](https://github.com/chaoslawful/lua-nginx-module#ngxexit) to abort pending subrequests in other "light threads" might lead to segfault or request hang when HTTP 1.0 full buffering is in effect.
    * bugfix: removing a request header might lead to memory corruptions. thanks Bjørnar Ness for the report.
    * bugfix: reading [ngx.status](https://github.com/chaoslawful/lua-nginx-module#ngxstatus) might get different values than [$status](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_status). thanks Kevin Burke for the report.
    * bugfix: downstream write events might interfere with upstream cosockets that are slow to write to. thanks Aviram Cohen for the report.
    * bugfix: the bookkeeping state for already-freed user threads might be incorrectly used by newly-created threads that were completely different, which could lead to bad results. thanks Sam Lawrence for the report.
    * bugfix: calling [ngx.thread.wait()](https://github.com/chaoslawful/lua-nginx-module#ngxthreadwait) on a user thread object that is already waited (i.e., already dead) would hang forever. thanks Sam Lawrence for the report.
    * bugfix: the alert "zero size buf" could be logged when assigning an empty Lua string ("") to `ngx.arg[1]` in [body_filter_by_lua](https://github.com/chaoslawful/lua-nginx-module#body_filter_by_lua)*.
    * bugfix: subrequests initiated by [ngx.location.capture](https://github.com/chaoslawful/lua-nginx-module#ngxlocationcapture)* could trigger unnecessary response header sending actions in the subrequest because our capturing output header filter did not set `r->header_sent`.
    * bugfix: the Lua error message for the case that [ngx.sleep()](https://github.com/chaoslawful/lua-nginx-module#ngxsleep) was used in [log_by_lua](https://github.com/chaoslawful/lua-nginx-module#log_by_lua)* was not friendly. thanks Jiale Zhi for the report.
    * bugfix: now [ngx.req.socket(true)](https://github.com/chaoslawful/lua-nginx-module#ngxreqsocket) returns proper error when there is some other "light thread" reading the request body.
    * bugfix: [header_filter_by_lua](https://github.com/chaoslawful/lua-nginx-module#header_filter_by_lua)*, [body_filter_by_lua](https://github.com/chaoslawful/lua-nginx-module#body_filter_by_lua)*, and [ngx.location.capture](https://github.com/chaoslawful/lua-nginx-module#ngxlocationcapture)* might not work properly with multiple "http {}" blocks in `nginx.conf`. thanks flygoast for the report.
    * optimize: made [ngx.re.match](https://github.com/chaoslawful/lua-nginx-module#ngxrematch) and [ngx.re.gmatch](https://github.com/chaoslawful/lua-nginx-module#ngxregmatch) faster for [LuaJIT](luajit.html) 2.x when there is no submatch captures.
    * optimize: pre-allocate space for the Lua tables in various places.
    * doc: fixed the context for the [lua_package_path](https://github.com/chaoslawful/lua-nginx-module#lua_package_path) and [lua_package_cpath](https://github.com/chaoslawful/lua-nginx-module#lua_package_cpath) directives. thanks duhoobo for the report.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.23.
    * bugfix: removing request headers via [more_clear_input_headers](https://github.com/agentzh/headers-more-nginx-module#more_clear_input_headers) might lead to memory corruptions.
    * bugfix: [more_set_input_headers](https://github.com/agentzh/headers-more-nginx-module#more_set_input_headers) might overwrite the value of the [$host](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_host) variable with bad values.
    * bugfix: [more_set_headers](https://github.com/agentzh/headers-more-nginx-module#more_set_headers) and [more_clear_headers](https://github.com/agentzh/headers-more-nginx-module#more_clear_headers) might not work when multiple "http {}" blocks were used in `nginx.conf`.
    * bugfix: eliminated use of C global variables during configuration phase because it might lead to issues when HUP reload failed.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.23.
    * bugfix: this module might not work properly with multiple "http {}" blocks in `nginx.conf`.
    * bugfix: we might (incorrectly) return 500 in our output filters.
    * bugfix: we did not set `r->header_sent` when we want to discard the header in our header filter.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.12.
    * bugfix: in case of multiple "http {}" blocks in `nginx.conf`, our output filters might be disabled even when this module is configured properly.
    * bugix: we did not check the `NULL` pointer returned by an [Nginx](nginx.html) array element allocation.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.05.
    * optimize: we now only register our output filters when this module is indeed used (the only exception is when multiple "http {}" blocks are used).
* upgraded [Xss Nginx Module](xss-nginx-module.html) to 0.04.
    * optimize: we now only register our output filters when this module is indeed used (the only exception is when multiple "http {}" blocks are used).
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.49.
    * bugfix: [echo_before_body](https://github.com/agentzh/echo-nginx-module#echo_before_body) and [echo_after_body](https://github.com/agentzh/echo-nginx-module#echo_after_body) might now work properly when multiple "http {}" blocks were used in `nginx.conf`.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.17.
    * optimize: added an optional argument "n" to [init_pipeline()](https://github.com/agentzh/lua-resty-redis#init_pipeline) as a hint for the number of pipelined commands.
    * optimize: use [LuaJIT](luajit.html) 2.1's new [table.new() primitive](http://repo.or.cz/w/luajit-2.0.git/commit/c8cfca055) to pre-allocate space for Lua tables.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.09.
    * bugfix: removed use of the [module()](http://www.lua.org/manual/5.1/manual.html#pdf-module) function to prevent bad side-effects.
    * optimize: Removed use of lua tables and [table.concat()](http://www.lua.org/manual/5.1/manual.html#pdf-table.concat) for simple one-line Lua string concatenations.
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.14.
    * bugfix: avoided using Lua 5.1's [module()](http://www.lua.org/manual/5.1/manual.html#pdf-module) function for defining our Lua modules because it has bad side effects.
    * optimize: added an optional new argument "nrows" to the [query()](https://github.com/agentzh/lua-resty-mysql#query) and [read_result()](https://github.com/agentzh/lua-resty-mysql#read_result) methods, which can speed up things a bit.
    * optimize: use [LuaJIT](luajit.html) v2.1's new [table.new()](http://repo.or.cz/w/luajit-2.0.git/commit/c8cfca055) API to optimize Lua table allocations. when table.new is missing, just fall back to the good old "{}" constructor. this gives 12% overall speed-up for a typical result set with 500 rows when [LuaJIT](luajit.html) 2.1 is used.
    * optimize: eliminated use of [table.insert()](http://www.lua.org/manual/5.1/manual.html#pdf-table.insert) because it is slower than "tb[#tb + 1] = val".
    * optimize: switched over to the multi-argument form of [string.char()](http://www.lua.org/manual/5.1/manual.html#pdf-string.char).
    * optimize: no longer use Lua tables and [table.concat()](http://www.lua.org/manual/5.1/manual.html#pdf-table.concat) to construct simple query strings.
* upgraded [Lua Resty Web Socket Library](lua-resty-web-socket-library.html) to 0.02.
    * optimize: use [LuaJIT](luajit.html) 2.1's [table.new()](http://repo.or.cz/w/luajit-2.0.git/commit/c8cfca055) to preallocate space for Lua tables, eliminating the overhead of Lua table rehash.
* feature: applied the [proxy_host_port_vars patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-proxy_host_port_vars.patch) to
the [Nginx](nginx.html) core to make `$proxy_host` and `$proxy_port` accessible
for dynamic languages like Lua and Perl.
* bugfix: applied the [gzip_flush_bug patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-gzip_flush_bug.patch) to
the [Nginx](nginx.html) core to fix request hang caused by the [ngx_gzip](http://nginx.org/en/docs/http/ngx_http_gzip_module.html) and
[ngx_gunzip](http://nginx.org/en/docs/http/ngx_http_gzip_module.html) modules
when using [ngx.flush(true)](https://github.com/chaoslawful/lua-nginx-module#ngxflush),
for example. Thanks Maxim Dounin for the review.
* bugfix: applied the [cache_lock_hang_in_subreq patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-cache_lock_hang_in_subreq.patch) to
the [Nginx](nginx.html) core to fix the request hang when using [proxy_cache_lock](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache_lock) in
subrequests and the cache lock timeout happens.
* bugfix: backported Maxim Dounin's [patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.3-gzip_buffered_bug.patch) to
fix an issue in the [ngx_gzip module](http://nginx.org/en/docs/http/ngx_http_gzip_module.html):
it did not clear `r->connection->buffered` when the pending data was already
flushed out. this could hang [Lua Nginx Module](lua-nginx-module.html)'s [ngx.flush(true)](https://github.com/chaoslawful/lua-nginx-module#ngxflush) call,
for example.
See [ChangeLog 1.4.2](changelog-1004002.html) for change log for [OpenResty](openresty.html) 1.4.2.x.
