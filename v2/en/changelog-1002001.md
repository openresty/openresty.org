<!---
    @title         ChangeLog 1.2.1
    @creator       Yichun Zhang
    @created       2012-06-22 15:03 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-08-15 04:19 GMT
    @changes       65
--->


#  Stable Release 1.2.1.14 - 14 August 2012
* bugfix: the dtrace static probes did not build on FreeBSD, Solaris, and Mac
OS X (i.e., when the `--with-dtrace-probes` configure option is specified).
* bugfix: the systemtap tapset files and the `stap-nginx` script were even installed
on non-Linux systems.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.14.
    * bugfix: the dtrace provider file did not compile on FreeBSD, Solaris, and Mac OS X.

[Components](components.html) bundled:
* LuaJIT-2.0.0-beta10
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2
* echo-nginx-module-0.41
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.18
* iconv-nginx-module-0.10rc7
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.09
* lua-resty-dns-0.05
* lua-resty-memcached-0.07
* lua-resty-mysql-0.10
* lua-resty-redis-0.11
* lua-resty-string-0.06
* lua-resty-upload-0.03
* memc-nginx-module-0.13rc3
* nginx-1.2.1
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.17
* ngx_lua-0.5.14
* ngx_postgres-1.0rc1
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.08rc4
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.14
* xss-nginx-module-0.03rc9

#  Mainline Version 1.2.1.13 - 12 August 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.13.
    * feature: added new directive [lua_socket_log_errors](http://wiki.nginx.org/HttpLuaModule#lua_socket_log_errors) that can be used to disable automatic error logging for both the TCP and UDP cosockets. thanks Brian Akins for the patch.
    * bugfix: segmentation faults might happen when 1. the nginx worker was shutting down (i.e., the Lua VM is closing),  2. [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) was used, and 3. regex cache is enabled via the `o` regex flag. this bug had appeared in [Lua Nginx Module](lua-nginx-module.html) 0.5.0rc30 (and [OpenResty](openresty.html) 1.0.15.9).
    * bugfix: segmentation faults might happen when the system is out of memory: there was one place where we did not check the pointer returned from `ngx_array_push`.
    * bugfix: we should avoid complicated Lua stack operations that might require memory allocaitons in the Lua `atpanic` handler because it would produce another exception in the handler leading to infinite loops.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.41.
    * bugfix: we incorrectly returned the `500` error code in our nginx output body filters.
    * bugfix: segmentation faults might happen when the system is out of memory: we forgot to check the returned pointer from `ngx_calloc_buf` in our nginx output body filter.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.05.
    * feature: now we use 4096 as the receive buffer size instead of the value 512 that is suggested by RFC 1035. this could avoid data truncation when the DNS server supports datagram sizes larger than 512 bytes.
    * feature: now we pick a random nameserver from the nameservers list at the first time.
    * docs: fixed a mistake in the sample code and tuned it to be more illustrative. thanks Sandesh Kotwal for reporting.

#  Mainline Version 1.2.1.11 - 5 August 2012
* bundled [Lua Resty DNS Library](lua-resty-dns-library.html) 0.04 and enabled
it by default: https://github.com/agentzh/lua-resty-dns it is a nonblocking
DNS (Domain Name System) resolver library based on [Lua Nginx Module](lua-nginx-module.html)'s
cosocket API.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.12.
    * bugfix: the [UDP cosocket object](http://wiki.nginx.org/HttpLuaModule#ngx.socket.udp) could no longer be used after an read or write error happened.
    * bugfix: [ngx.exit(status)](http://wiki.nginx.org/HttpLuaModule#ngx.exit) always resulted in `200 OK` response status when status > 200 and status < 300. thanks [Nginx](nginx.html) User for reporting this issue.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.18.
    * bugfix: fixed a `set-but-not-read` warning from the `clang` static code analyzer.
    * fixed compatibility with nginx 0.7.65. thanks Banping for reporting this.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2.
    * minor code cleanup in the built-in connection pool.

#  Mainline Version 1.2.1.9 - 30 July 2012
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.10.
    * bugfix: the MySQL `bigint` fields might overflow when converting to lua numbers. now we no longer convert such fields into Lua numbers and instead, just treat them as Lua strings. thanks Lance Li for reporting this issue.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.11.
    * feature: added new Lua API [ngx.req.init_body](http://wiki.nginx.org/HttpLuaModule#ngx.req.init_body), [ngx.req.append_body](http://wiki.nginx.org/HttpLuaModule#ngx.req.append_body), and [ngx.req.finish_body](http://wiki.nginx.org/HttpLuaModule#ngx.req.finish_body). thanks Matthieu Tourne for the patches. These new functions can be used with the existing "downstream cosocket API" (provided by [ngx.req.socket](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket)) to implement efficient [Nginx](nginx.html) "input filters" in pure Lua.
    * feature: added new Lua API [ngx.get_phase](http://wiki.nginx.org/HttpLuaModule#ngx.get_phase) for retrieving the current running phase of the Lua code being executed. thanks James Hurst for the patch.
    * feature: added the first dtrace static probe: `nginx_lua:::http-lua-register-preload-package` and `nginx_lua:::http-lua-req-socket-consume-preread`.
    * bugfix: `buffer error` would happen when the `args` option table to [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) (and [ngx.encode_args](http://wiki.nginx.org/HttpLuaModule#ngx.encode_args)) contained a multi-value argument whose key also required URI escaping. thanks Matthieu Tourne for reporting this.
    * bugfix: [ngx.re.gmatch()](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) might result in segmentation faults during nginx request cleanups if the iterator returned by [ngx.re.gmatch()](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) was collected (by Lua GC) before request cleanups. this bug had appeared in [Lua Nginx Module](lua-nginx-module.html) 0.5.0rc30 (and [OpenResty](openresty.html) 1.0.15.9). thanks Wayne for reporting this issue.
    * bugfix: 3rd-party nginx C modules that use the public C API function, `ngx_http_lua_add_package_preload`, could result in segmentation faults at nginx server startup due to uninitialized Lua VM pointer. thanks Ray Bejjani for reporting this.
    * bugfix: Proper error messages were not always thrown when the iterator returned by [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) was (incorrectly) used in the context of another nginx request.
    * bugfix: fixed several Clang compilation warnings.
* feature: applied the [dtrace patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.1-dtrace.patch) to
the nginx core that adds dtrace static probing support for both the [Nginx](nginx.html) core
and 3rd-party modules to the [Nginx](nginx.html) build system. this support
can be enabled by `./configure --with-dtrace-probes`.
* feature: added new dtrace static probes to the [Nginx](nginx.html) core
    * added 8 kinds of static probes to the subrequest mechanism: `nginx:::http-subrequest-cycle`, `nginx:::http-subrequest-start`, `nginx:::http-subrequest-finalize-writing`, `nginx:::http-subrequest-finalize-nonactive`, `nginx:::http-subrequest-wake-parent`, `nginx:::http-subrequest-done`, `nginx:::http-subrequest-post-start`, and `nginx:::http-subrequest-post-done`.
    * added 2 kinds of static probes to the standard request body reader: `nginx:::http-read-body-abort` and `nginx:::http-read-body-done`.
    * added 2 kinds of static probes to the standard main request header reader: `nginx:::http-read-req-line-done` and `nginx:::http-read-req-header-done`.
    * added 1 kind of static probes to the configuration loader: `nginx:::http-module-post-config`.
    * added the `nginx.stp` stapset script for systemtap: https://github.com/agentzh/nginx-dtrace/blob/master/src/dtrace/nginx.stp
    * added the [stap-nginx](https://github.com/agentzh/nginx-dtrace/blob/master/src/dtrace/stap-nginx) wrapper sh script for systemtap's `stap` command for nginx. this script will be installed to `$PREFIX/sbin/` when the `./configure` option `--with-dtrace-probes` is specified.
* bugfix: fixed an issue regarding subrequests in [allow_request_body_updating.patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.1-allow_request_body_updating.patch).

#  Mainline Version 1.2.1.7 - 14 July 2012
* upraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.17.
    * bugfix: [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not remove all the instances for the built-in headers or custom headers.
    * bugfix: [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) might accidentally remove request headers that were not specified at all and left the specified headers with just empty header values when removing multiple built-in headers. thanks Matthieu Tourne for reporting the issues.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.7.
    * feature: added an optional "option table" to [tcpsock:connect()](http://wiki.nginx.org/HttpLuaModule#tcpsock:connect) which accepts a `pool` option to allow the user specify a custom pool name intead of the automatically generated one based on the host-port pair or the socket file path. thanks Brian Akins for the patches.
    * feature: implemented the UDP/unix-datagram cosocket API. the entry point is [ngx.socket.udp](http://wiki.nginx.org/HttpLuaModule#ngx.socket.udp). we preserve API compatibility with the LuaSocket library but everything is non-blocking in our implementation.
    * feature: added new [Nginx](nginx.html) API for Lua: [ngx.req.set_method(method_id)](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_method) and [ngx.req.get_method](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_method). thanks Matthieu Tourne for suggesting these.
    * bugfix: the tcp/stream-unix cosocket object might hang when another concurrent request is accessing it while its operation is still in progress; now we always check for potential access conflicts and return the `socket busy` error string if it is indeed the case.
    * bugfix: the [tcpsock:connect()](http://wiki.nginx.org/HttpLuaModule#tcpsock:connect) method always returned the (vague) error strng `"connect peer error"` instead of the (detailed) system error string when the connect syscall failed.
    * bugfix: the TCP/stream-unix cosocket object might go wrong after it connected successfully in a single run (that is, no `EAGAIN` returned in the middle) and DNS domain names were used.
    * bugfix: [tcpsock:receive()](http://wiki.nginx.org/HttpLuaModule#tcpsock:receive) and [tcpsock:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) always returned `"error"` as the error message instead of the (detailed) system error string.
    * bugfix: [ngx.req.clear_header()](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not remove all the instances for the built-in headers or custom headers.
    * bugfix: [ngx.req.clear_header()](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) might accidentally remove request headers that are not specified at all and left the specified headers with just empty header values when removing multiple built-in headers. thanks Matthieu Tourne for reporting the issues.
    * bugfix: we did not always test if the request object pointer is null in the `ngx.req.*_body` API.
    * bugfix: [ngx.exec()](http://wiki.nginx.org/HttpLuaModule#ngx.exec) did not accept the `nil` value for its second (optional) argument.
    * bugfix: `ngx.exit(404/500/...)` would throw out Lua errors when the response headers with exactly the same status code had already been sent. thanks Matthieu Tourne for reporting this.
    * bugfix: gcc might issue the "unused variable" warning when PCRE was disabled. thanks Dirk Feytons for the patch.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.11.
    * feature: added the `array_to_hash` method. thanks Brian Akins for the patch in [github #8](https://github.com/agentzh/lua-resty-redis/pull/8).
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.09.
    * feature: added the `compact_arrays` option to the `connect()` method to make the driver return arrays of arrays instead of the (default) arrays of hashes. thanks Lance Li for requesting this feature.
    * feature: added new method `set_compact_arrays` to change the current `compact_arrays` option value used by the current object for subsequent queries. thanks Lance Li for suggesting it.
    * feature: added the `pool` option to the `connect()` method.
    * bugfix: connections to different MySQL databases and/or different MySQL users would incorrectly share the same connection pool as long as they were connecting to the same MySQL server. thanks lhmwzy for reporting the issue.
    * docs: fixed the `path` option value for the `connect()` method in README. it should not take the `unix:` prefix. thanks Lance Li.
    * docs: documented that storing the object instance into lua module-level variables will result in failures for concurrent requests.
    * docs: documented that this library cannot be used in those contexts where the cosocket API is unavailable.
* upgraded the standard Lua interpreter to 5.1.5.
* disabled the Lua 5.0 compatibility in the standard Lua interpreter bundled.

#  Mainline Version 1.2.1.5 - 4 July 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.5.
    * feature: added new configure directives [init_by_lua](http://wiki.nginx.org/HttpLuaModule#init_by_lua) and [init_by_lua_file](http://wiki.nginx.org/HttpLuaModule#init_by_lua_file). they can be used to pre-load Lua modules, registering true Lua global variables, and initializing the shared-memory storage defined via [lua_shared_dict](http://wiki.nginx.org/HttpLuaModule#lua_shared_dict), at [Nginx](nginx.html) config-loading time. thanks drdrxp for suggesting this new feature.
    * feature: now we print backtrace to `error.log` when Lua errors happen in [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua)*, [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua)*, [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua)*, and [log_by_lua](http://wiki.nginx.org/HttpLuaModule#log_by_lua).
    * bugfix: upstream data buffers were not marked as fully consumed when [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua)* was used and `ngx.arg[1]` was overwritten. this could result in connection hang for large response bodies. thanks Tzury Bar Yochay for reporting this issue.
    * bugfix: gcc complained that "dereferencing type-punned pointer will break strict-aliasing rules" when `-O2` or above was enabled while compiling. thanks Ryan Ooi for reporting this and chaoslawful for fixing it.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.10.
    * feature: added the Redis `script` command introduced in Redis 2.6. thanks Evgeniy Dolzhenko for suggesting this.
    * docs: documented that storing the object instance into lua module-level variables will result in failures for concurrent requests.
    * docs: documented that this lib cannot be used in those contexts where the ngx_lua cosocket API is unavailable.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.14.
    * feature: added new nginx variable [$srcache_fetch_status](http://wiki.nginx.org/HttpSRCacheModule#.24srcache_fetch_status) which takes one of three values, `BYASS`, `MISS`, and `HIT`. thanks Feibo Li for the patch.
    * feature: added new [Nginx](nginx.html) variable [$srcache_store_status](http://wiki.nginx.org/HttpSRCacheModule#.24srcache_store_status) which takes the value `BYASS` or `STORE`.
    * optimize: removed unused context data field `fetch_sr` on the C level to reduce the memory footprint a bit.

#  Mainline Version 1.2.1.3 - 25 June 2012
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.40.
    * feature: added new directive [echo_status](http://wiki.nginx.org/HttpEchoModule#echo_status) which can be used to specify a different default response status code other than 200. thanks Maxime Corbeau for requesting this.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.3.
    * bugfix: [ngx.say](http://wiki.nginx.org/HttpLuaModule#ngx.say) and [ngx.print](http://wiki.nginx.org/HttpLuaModule#ngx.print) might cause nginx to crash when table-typed arguments were given. thanks sztanpet for reporting this in [github issue #54](https://github.com/chaoslawful/lua-nginx-module/issues/54#issuecomment-6527745).
* applied [location_if_inherits_proxy.patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.1-location_if_inherits_proxy.patch) to
the nginx core. see http://mailman.nginx.org/pipermail/nginx-devel/2012-June/002374.html
for details.

#  Mainline Version 1.2.1.1 - 22 June 2012
* upgraded the [Nginx](nginx.html) core to 1.2.1.
    * see the change log: http://nginx.org/en/CHANGES-1.2
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.2.
    * bugfix: [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua)* did not run at all when [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua)* was defined at the same time. thanks Tzury Bar Yochay for reporting this issue.
    * feature: added the `inclusive` option to the [cosocket:receiveuntil](http://wiki.nginx.org/HttpLuaModule#tcpsock:receiveuntil) method to include the delimiter pattern string in the resulting data read. thanks Matthieu Tourne for the patch.
    * optimize: merged two successive [Nginx](nginx.html) pool allocations in `ngx_http_lua_socket_resolve_handler` to reduce overhead.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.39.
    * bugfix: [Echo Nginx Module](echo-nginx-module.html)'s configure directives was not inherited automatically by `location if` inner blocks.
    * bugfix: the old HTTP 1.0 protocol handling was wrong. we should leave that to the [Nginx](nginx.html) core and just output responses without a `Content-Length` response header.
    * bugfix: reading the [$echo_it](http://wiki.nginx.org/HttpEchoModule#.24echo_it) variable outside the [echo_foreach_split](http://wiki.nginx.org/HttpEchoModule#echo_foreach_split) loop resulted in memory invalid reads and hence segfaults; now it is evaluates to the special `not found` value. thanks baqs for reporting this.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc1.
    * bugfix: memory leak might happen if nginx 1.1.14+ was used and (at least) `libpq` failed to connect to the remote database.
* upgraded the (optional) no-pool patch to the latest version, `642ae25`.
    * bugfix: we should postpone freeing the `elts` storage for `ngx_array_t` to `ngx_array_destroy` when resizing the array because at least the `ngx_rewrite` module stores external references to the array elements.

See [ChangeLog 1.0.15](changelog-1000015.html) for change log for ngx_openresty 1.0.15.x.
