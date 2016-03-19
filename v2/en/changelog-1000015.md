<!---
    @title         ChangeLog 1.0.15
    @creator       Yichun Zhang
    @created       2012-04-29 02:56 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-06-16 03:29 GMT
    @changes       100
--->


#  Mainline Version 1.0.15.11 - 16 June 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc32.
    * bugfix: [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua) and its friend would leak memory when it is the only directive of [Lua Nginx Module](lua-nginx-module.html) configured in a location and the [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) API is also used there.
    * bugfix: Lua global variables was dangerously shared by all the concurrent requests if the special `_G` table was used in all those `*_by_lua` and `*_by_lua_file` directives. thanks chaoslawful for the patches. but please also note that `_G` is still shared among all the requests if used in the context of Lua modules, just like all those Lua module level variables.
    * bugfix: the [ngx.arg](http://wiki.nginx.org/HttpLuaModule#ngx.arg) API was not usable within external Lua module files in [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua) or [set_by_lua_file](http://wiki.nginx.org/HttpLuaModule#set_by_lua_file).
    * bugfix: unexpected values on the Lua stack might be concatenated when generating tracebacks for Lua errors and the Lua VM would crash when there happened to be values on the Lua stack that could not be concatenated (like `nil`).
    * bugfix: the Lua main thread stack might leak when [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua) or [header_filter_by_lua_file](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua_file) are used.
    * bugfix: the Lua VM might crash when calling the cosocket methods with a bad-typed `self` argument.
    * bufix: fixed the directive context for [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua) and [set_by_lua_file](http://wiki.nginx.org/HttpLuaModule#set_by_lua_file). they really work in the contexts `server`, `server if`, `location`, and `location if`. thanks Liu Taihua.
    * feature: added new directives [log_by_lua](http://wiki.nginx.org/HttpLuaModule#log_by_lua) and [log_by_lua_file](http://wiki.nginx.org/HttpLuaModule#log_by_lua_file) to support user Lua code running at the `log` request processing phase. thanks Matthieu Tourne for the patches.
    * feature: added new directives [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua) and [body_filter_by_lua_file](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua_file) to allow the user implement nginx output body filters in pure Lua.
    * feature: added support for loading Lua/[LuaJIT](luajit.html) raw bytecode files automatically in all those `*_by_lua_file` config directives. thanks jinglong and chaoslawful for the patches. benchmark results have shown that, for very big Lua-based web applications, bytecode loading gives an order of magnitude speedup at first requests that trigger the Lua code loading.
    * feature: added new directive [lua_transform_underscores_in_response_headers](http://wiki.nginx.org/HttpLuaModule#lua_transform_underscores_in_response_headers). thanks Kindy Lin.
    * optimize: now we no longer register the `ndk` and `ngx` API for [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua)* and [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua)* at config time rather than request time. this makes these directives 200+% faster.
    * optimize: eliminated unnecessary string concatenations when generating tracebacks for Lua errors.
    * optimize: now we store the metatables for [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) and [ngx.socket.tcp()](http://wiki.nginx.org/HttpLuaModule#ngx.socket.tcp) objects into the Lua registry.
    * optimize: changed the string keys to light userdata for various tracking tables (coroutines table, regex cache table, cosocket connection pool table, [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) table, and etc). This gives minor performance improvement from eliminating key hashing and etc. thanks Dirk Feytons.
    * diagnosis: now we issue user-friendly error messages when the [Nginx](nginx.html) Lua APIs are used in the wrong configure directive contexts (e.g., using [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) in [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua)).
    * docs: fixed a typo: [ngx.now](http://wiki.nginx.org/HttpLuaModule#ngx.now) returns time of the resolution of milliseconds, rather than microseconds. thanks Wang Xi.
    * docs: added a note for installation with Lua 5.1 on ubuntu 11.10. thanks Dan Sosedoff.
* updated [nginx-1.0.15-poll_del_event_at_exit.patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.15-poll_del_event_at_exit.patch).
thanks Maxim Dounin.

#  Stable Release 1.0.15.10 - 13 June 2012
This release is essentially equivalent to the devel version 1.0.15.9 except
excluding all the vim backup files *~ from the source code distribution. thanks
Xiaoyu Chen.

[Components](components.html) bundled:
* LuaJIT-2.0.0-beta10
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc7
* echo-nginx-module-0.38rc2
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.17rc1
* iconv-nginx-module-0.10rc7
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.09
* lua-resty-memcached-0.07
* lua-resty-mysql-0.07
* lua-resty-redis-0.09
* lua-resty-string-0.06
* lua-resty-upload-0.03
* memc-nginx-module-0.13rc3
* nginx-1.0.15
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.17
* ngx_lua-0.5.0rc30
* ngx_postgres-0.9
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.08rc4
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.13rc8
* upstream-keepalive-nginx-module-0.7
* xss-nginx-module-0.03rc9

#  Mainline Version 1.0.15.9 - 7 June 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc30.
    * feature: new Lua API, [ngx.sleep()](http://wiki.nginx.org/HttpLuaModule#ngx.sleep), for doing non-blocking sleep in Lua. thanks jinglong for the patch.
    * feature: [ngx.log()](http://wiki.nginx.org/HttpLuaModule#ngx.log) now checks if the log level number is in the valid range (0 ~ 8). thanks Xiaoyu Chen (smallfish) for suggesting this improvement.
    * bugfix: [cosocket:receiveuntil](http://wiki.nginx.org/HttpLuaModule#tcpsock:receiveuntil) could leak memory, especially for long pattern string arguments. this bug was caught by [Test::Nginx::Socket](http://search.cpan.org/perldoc?Test::Nginx::Socket) when setting the environment `TEST_NGINX_CHECK_LEAK=1`.
    * bugfix: [ngx.re.sub()](http://wiki.nginx.org/HttpLuaModule#ngx.re.sub) could leak memory when the `replace` template argument string is not well-formed and the `o` regex option is also specified. this issue was caught by [Test::Nginx::Socket](http://search.cpan.org/perldoc?Test::Nginx::Socket) when setting environment `TEST_NGINX_CHECK_LEAK=1`.
    * bugfix: [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) leaked memory when the `o` option was not specified. this bug was caught by [Test::Nginx::Socket](http://search.cpan.org/perldoc?Test::Nginx::Socket) when setting the environment `TEST_NGINX_CHECK_LEAK=1`.
    * bugfix: the Lua `_G` special table did not get cleared when [lua_code_cache](http://wiki.nginx.org/HttpLuaModule#lua_code_cache) is turned off. thanks Moven for reporting this issue.
    * bugfix: [cosocket:connect()](http://wiki.nginx.org/HttpLuaModule#tcpsock:connect) might hang on socket creation errors or segfault later due to left-over state flags.
    * bugfix: refactored on-demand handler registration. the old approach rewrites to static (global) variables at config-time, which could have potential problems with nginx config reloading via the `HUP` signal.
    * optimize: now we no longer call `ngx_http_post_request` to wake up the request associated with the current cosocket upstream from within the cosocket upstream event handlers, but rather call `r->write_event_handler` directly. this change can also make backtraces more meaningful because we preserve the original calling stack.
    * docs: massive wording improvements from the [Nginx](nginx.html) Wiki site. thanks Dayo.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.12rc10.
    * bugfix: refactored on-demand handler registration. the old approach rewrites to static (global) variables at config-time, which could have potential problems with nginx config reloading via the `HUP` signal.
* bugfix: the (optional) [no-pool patch](https://github.com/openresty/no-pool-nginx/) might
leak memory. now we have updated the no-pool patch to the latest version that
is a thorough rewrite.
* bugfix: applied [poll_del_event_at_exit patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.15-poll_del_event_at_exit.patch) that
fixed a segmentation fault in the nginx core when the poll event type is used:
http://mailman.nginx.org/pipermail/nginx-devel/2012-June/002328.html
* bugfix: applied the [resolver_debug_log patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.15-resolver_debug_log_overflow.patch) that
fixed reads of uninitialized memory in the nginx core: http://mailman.nginx.org/pipermail/nginx-devel/2012-June/002281.html

#  Mainline Version 1.0.15.7 - 29 May 2012
* bugfix: applied the [add_core_vars_polluting_globals patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.15-add_core_vars_polluting_globals.patch) to
fix a bug in the nginx core: http://mailman.nginx.org/pipermail/nginx-devel/2012-May/002231.html
* bugfix: fixed the [filter_finalize_hang patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.15-filter_finalize_hang.patch) for
a regression in the image filters. thanks Maxim Dounin.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc29.
    * bugfix: `cosocket:receive(0)` was not allowed and would throw an error saying `0` was a bad pattern. thanks huang kun for reporting this issue. This issue at least made [Lua Resty Redis Library](lua-resty-redis-library.html) reject reading 0-size values.
    * bugfix: the [set_by_lua](http://wiki.nginx.org/HttpLuaModule#set_by_lua) directive did support nginx variable interpolation and there was no easy way to use the dollar sign characters in the literal Lua source. the [set_by_lua_file](http://wiki.nginx.org/HttpLuaModule#set_by_lua_file) directive still supports nginx variable interpolation in its lua file path argument. thanks Vittly for reporting this in [github issue #111](https://github.com/openresty/lua-nginx-module/issues/111) and jinglong for the test in [github pull #115](https://github.com/openresty/lua-nginx-module/pull/115).
    * bugfix: fixed compilation errors when PCRE is missing. thanks Dirk Feytons for the patch.
    * feature: added the `[lua]` prefix to the log messages produced by [ngx.log()](http://wiki.nginx.org/HttpLuaModule#ngx.log) and [print()](http://wiki.nginx.org/HttpLuaModule#print). thanks Matthieu Tourne for the patches.
    * feature: [ngx.log()](http://wiki.nginx.org/HttpLuaModule#ngx.log) and [print()](http://wiki.nginx.org/HttpLuaModule#print) now output more debugging info, i.e., the current lua source file name (if any), the current source line number, and the current calling Lua function name (if any), into the [Nginx](nginx.html) `error.log` file. An example message is 
```
[error] 56651#0: *1 [lua] test.lua:6: bar():
hello
```
. thanks Matthieu Tourne for the patch.
    * feature: added the [rewrite_by_lua_no_postpone](http://wiki.nginx.org/HttpLuaModule#rewrite_by_lua_no_postpone) directive which can control whether or not to disable postponing [rewrite_by_lua](http://wiki.nginx.org/HttpLuaModule#rewrite_by_lua) and [rewrite_by_lua_file](http://wiki.nginx.org/HttpLuaModule#rewrite_by_lua_file) to the end of the `access` request-processing phase. thanks Matthieu Tourne for the patches.
    * feature: added new Lua method [ngx.decode_args](http://wiki.nginx.org/HttpLuaModule#ngx.decode_args) to decode URI-encoded query strings into Lua tables. thanks Matthieu Tourne for the patches.
    * feature: the special `$prefix` and `${prefix} ` notations can now be used in the directives [lua_package_path](http://wiki.nginx.org/HttpLuaModule#lua_package_path) and [lua_package_cpath](http://wiki.nginx.org/HttpLuaModule#lua_package_cpath) to indicate the nginx `server prefix` path (usually determined by the `-p PATH` command-line option while starting the [Nginx](nginx.html) server. thanks Matthieu Tourne for the patches.
    * docs: various wording improvements in the documentation from Joshua Zhu.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.12rc9.
    * feature: added the `rds_json_errcode_key` directive to override the default `errcode` key in the JSON output. thanks Liseen Wan for the patches.
    * feature: added the `rds_json_errstr_key` directive to override the default `errstr` key in the JSON output. thanks Liseen Wan for the patches.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.09.
    * feature: the `hmset` method can now take a key and a hash-like table as its arguments. thanks Brian Akins for the patches.
    * docs: fixed a typo found by Lance in `README`.

#  Mainline Version 1.0.15.5 - 16 May 2012
* upgraded [LuaJIT](luajit.html) to 2.0.0beta10.
    * see changes here: http://luajit.org/changes.html
* feature: added the `--with-luajit-xcflags=FLAGS` option to `./configure` to
add more C compiler options to [LuaJIT](luajit.html)'s build system.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc28.
    * bugfix: [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) did not honor the `Expect: 100-continue` request header and could hang. thanks Matthieu Tourne for the patch in [pull request #107](https://github.com/openresty/lua-nginx-module/pull/107).
    * bugfix: the [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) object (i.e., the downstream cosocket object) did not work with HTTP 1.1 pipelined requests at all.
    * bugfix: the [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) object might lose the last part of the request body when receiving data. this regression had appeared in v0.5.0rc25. thanks Matthieu Tourne for reporting it.
    * feature: detailed backtraces (Lua callstack) will be automatically printed to `error.log` when the user Lua code is interrupted by Lua exceptions. thanks Matthieu Tourne for the patch in [pull request #107](https://github.com/openresty/lua-nginx-module/pull/107).
    * optimize: removed dead code found by Simon Liu via scan-build.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.05rc2.
    * bugfix: the output buffer size would get wrong when the `affected_rows` field is larger than a single-digit number. thanks Wendal Chen for reporting this by using clang.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.06.
    * feature: added new Lua module `resty.random` that implements secure random and pseudo-random string generators. thanks Chase Colman for the patch.
    * feature: added new Lua module `resty.aes` that exposes the AES submodule of OpenSSL via [LuaJIT](luajit.html) FFI. thanks Chase Colman for the patch.

#  Mainline Version 1.0.15.3 - 13 May 2012
* now we bundle Sergey A. Osokin's [Redis Nginx Module](redis-nginx-module.html), 0.3.6,
which is also enabled by default. thanks Zhu Feng for requesting this.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc27.
    * bugfix: nginx could crash on request finalization when running the cosocket cleanup handle due to the lack of check of the `ctx` pointer. thanks shaneeb for reporting this in [github issue #110](https://github.com/openresty/lua-nginx-module/issues/110).
    * bugfix: [ngx.req.get_body_data()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_body_data) could not handle multi-buffer request bodies and discarded the body data after the first buffer.
    * bugfix: [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) was not accessible at all in `set_by_lua*`. thanks Pierre.
    * bugfix: fixed typo "on-array", which should be "non-array", in an error message.
    * optimize: now [ngx.log](http://wiki.nginx.org/HttpLuaModule#ngx.log) is much faster when the log level argument is lower than the actual [error_log](http://wiki.nginx.org/CoreModule#error_log) level specified in nginx.conf. thanks Matthieu Tourne for providing the patch.
    * optimize: now we call `ngx_http_lua_socket_finalize` in `cosocket:setkeepalive()` to help buffer reuse.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22rc8.
    * feature: added new directives [set_secure_random_alphanum](http://wiki.nginx.org/HttpSetMiscModule#set_secure_random_alphanum) and [set_secure_random_lcalpha|http://wiki.nginx.org/HttpSetMiscModule#set_secure_random_lcalpha]() for generating cryptographically strong random strings based on the `/dev/urandom` device. thanks Jeremy Wohl for the patch.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc8.
    * bugfix: the `Content-Length` response header for HEAD requests should leave intact when cache hits happen.
    * bugfix: the [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) subrequest did not set the `Content-Length` request header properly for multi-buffer request bodies. thanks Feibo Lee for submitting the patch.
    * feature: HTTP conditional GET requests are now supported (both `If-Modified-Since` and `If-Unmodified-Since` request headers are properly handled). thanks Nginx_User777.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to v0.09.
    * feature: added `redis.parser._VERSION`.
    * bugfix: now we use Lua userdata to allocate memory used on the C side to prevent potential leaks caused by malloc/free, as discussed in [github issue #6](https://github.com/agentzh/lua-redis-parser/issues/6).
* upgraded [Lua Rds Parser Library](lua-rds-parser-library.html) to 0.05.
    * feature: added `redis.parser._VERSION`.
    * bugfix: now we use Lua userdata to allocate memory used on the C side to prevent potential leaks caused by malloc/free, as discussed in [github issue #6](https://github.com/agentzh/lua-redis-parser/issues/6).
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.07.
    * feature: now the methods for the Memcached storage commands now accept Lua tables as the `value` argument. thanks Brian Akins for the patch.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.03.
    * feature: now the raw headers for each part are also returned, as suggested by zou2062 in [github issue #1](https://github.com/agentzh/lua-resty-upload/issues/1).
* applied the patch for a bug in `ngx_http_named_location` to the nginx core:
http://mailman.nginx.org/pipermail/nginx-devel/2012-May/002166.html
* applied the patch for a bug in the filter finalizer to the nginx core: http://mailman.nginx.org/pipermail/nginx-devel/2012-May/002190.html

#  Mainline Version 1.0.15.1 - 29 April 2012
* upgraded the [Nginx](nginx.html) core to 1.0.15.
* bugfix: now we also add `<openresty_prefix>/lualib/?/init.lua` to the default
`package.path` search list. thanks bigplum for reporting this issue.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc25.
    * bugfix: cosocket connections from the connection pool might lead to segfaults if it is not used immediately. thanks xukaifu for reporting this as [github issue #108](https://github.com/chaoslawful/lua-nginx-module/issues/108).
    * bugfix: debug logging in the cosocket receive line method could lead to invalid memory reads under extreme network conditions. this issue was caught by [mockeagain](https://github.com/agentzh/mockeagain) in reading mode.
    * bugfix: downstream cosockets might hang on the receive(size) method call for slow connections. [mockeagain](https://github.com/agentzh/mockeagain) in reading mode caught this issue.
    * bugfix: we no longer forcibly quit the lua threads by clearing out its environment and running it blindly to the end because Lua GC will collect all those unfinished coroutines anyway.
    * bugfix: improved the longjmp handling when Lua panic happens.
    * bugfix: certain compilers might complain about missing declarations for types like `int8_t`. now we explicitly included `stdint.h`. thanks runner-mei for reporting it in [github issue #98](https://github.com/chaoslawful/lua-nginx-module/issues/98).
    * feature: added new constant `ngx.HTTP_OPTIONS` for the HTTP OPTIONS method.
    * feature: added support for OPTIONS method in the subrequest capture APIs. thanks Jónas Tryggvi Jóhannsson for requesting this in [github issue #102](https://github.com/chaoslawful/lua-nginx-module/issues/102).
    * feature: added publich C functions `ngx_http_lua_add_package_preload`, `ngx_http_lua_get_global_state`, and `ngx_http_lua_get_request` to help other [Nginx](nginx.html) C modules expose new functionalities to [Lua Nginx Module](lua-nginx-module.html). thanks Brian Akins for suggesting them in [github pull request #101](https://github.com/chaoslawful/lua-nginx-module/pull/101).
    * feature: made `ngx_http_lua_api.h` visible to other [Nginx](nginx.html) modules by adding `src/api/` to the `CORE_INCS` config variable value in the config file. thanks Brian Akins for suggesting this in [github pull request #105](https://github.com/chaoslawful/lua-nginx-module/pull/105).
    * feature: add the `gdbinit` script to ease Lua user code debugging (Wang Xiaozhe).
    * optimize: various optimizations in cosocket's timeout handling. this gives about 2.5+% performance boost in some benchmarks using [Lua Resty Redis Library](lua-resty-redis-library.html) and [Lua Resty MySQL Library](lua-resty-mysql-library.html).
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to v0.12rc8.
    * bugfix: Microsoft C compilers complained about missing declarations of the type `int8_t`. now we explicitly include `stdint.h`. thanks runner-mei for reporting this issue in [github issue #3](https://github.com/agentzh/rds-json-nginx-module/issues/3).
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22rc7.
    * bugfix: we should omit the [set_sha1](http://wiki.nginx.org/HttpSetMiscModule#set_sha1) directive when we do not have any SHA1 libraries (including OpenSSL) installed. thanks runner-mei for reporting this in [github issue #9](https://github.com/agentzh/set-misc-nginx-module/issues/9).
    * feature: added new config directive [set_rotate](http://wiki.nginx.org/HttpSetMiscModule#set_rotate).
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2rc7.
    * bugfix: reading data on a reused MySQL connection (coming from the connection pool) could hang due to the inactive read event when `poll` event API is used in nginx.
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.07.
    * fixed a typo in error messages.
    * skipped parsing those column fields that we do not use (yet). this makes things noticeably faster.

See [ChangeLog 1.0.11](changelog-1000011.html) for change log for ngx_openresty 1.0.11.x.
