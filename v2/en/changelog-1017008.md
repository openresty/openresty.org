<!---
    @title         ChangeLog for 1.17.8.x
    @creator       Thibault Charbonnier
    @created       2020-06-30 21:32 GMT
--->

# Version 1.17.8.2 - 13 July 2020

* bugfix: builds with http_perl_module was broken. this regression had appeared in 1.17.8.1.
* change: we no longer remove a lot of files (docs, perl modules, tests, and etc.) in our tarball.

# Version 1.17.8.1 - 4 July 2020

* upgraded the [nginx](nginx.html) core to 1.17.8.
    * see the changes here: https://nginx.org/en/CHANGES
* bugfix: [nginx](nginx.html) would crash when receiving SIGHUP in the single process mode. _Thanks root for the patch._
* bugfix: ngx_http_static_module: the 'Locatoin' response header value was not properly encoded by URI rules. _Thanks lijunlong for the patch._
* feature: passed C compiler option `-g` by default for statically linked openssl, pcre, and zlib libraries to enable debuginfo. _Thanks lijunlong for the patch._
* feature: added support for OpenSSL 1.1.1 by upgrading the OpenSSL patches. _Thanks spacewander for the patch._
* feature: added a new `--with-luajit-ldflags=OPTS` option for specifying custom [LuaJIT](https://github.com/openresty/luajit2#readme) linker flags.
* feature: ensured all OpenSSL patches are now included in the release tarball. _Thanks Thibault Charbonnier for the patch._
* optimize: added an [NGINX](nginx.html) core patch to ensure unused listening fds are closed when `reuseport` is used. _Thanks spacewander for the patch._
* optimize: removed many non-source files from the release tarball to reduce its final size. _Thanks Thibault Charbonnier for the patch._
* change: renamed the `ssl_pending_session` patch to `ssl_sess_cb_yield` for [NGINX](nginx.html) cores 1.17.1 and above. _Thanks spacewander for the patch._
* change: removed the `gcc-maybe-uninitialized-warning` patch which is now obsolete. _Thanks Thibault Charbonnier for the patch._
* change: we no longer maintain the [NGINX](nginx.html) `dtrace` patch.
* bugfix: support yielding in [ssl_certificate_by_lua_*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) when `ssl_early_data` is on. _Thanks spacewander for the patch._
* bugfix: ensured we apply the `init_cycle_pool_release` patch to [NGINX](nginx.html) cores >= 1.13.6 instead of 1.13.6 only. _Thanks Thibault Charbonnier for the patch._
* tweak: updated the `--without-luajit-gc64` option to follow Mike Pall's commit which enables GC64 by default on x64 platforms. _Thanks Thibault Charbonnier for the patch._
* tweak: updated the `./configure --help` usage text output for recent [NGINX](nginx.html) cores.
* win32/win64: upgraded PCRE to 8.44 and OpenSSL to 1.1.1d.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.16.
    * feature: `ngx.req.set_uri()`: added the 'binary' optional boolean arg to allow arbitrary binary data in the unencoded URI. _Thanks lijunlong for the patch._
    * security: `ngx.req.set_header()`: now we always escape bytes in headernames and header values which are prohibited by RFC 7230. _Thanks lijunlong for the patch._
    * feature: `ngx.req.set_uri_args()` now automatically escapes control and whitespace characters if the query-string is provided directly. _Thanks lijunlong for the patch._
    * bugfix: `ngx.req.set_uri_args()` threw an exception with wrong argument info. _Thanks lijunlong for the patch._
    * bugfix: `set_by_lua_block` allowed more than one arg (in addition to the block). _Thanks lijunlong for the patch._

    * bugfix: prevented request smuggling in the `ngx.location.capture()` API. _Thanks UltramanGaia for the report and Thibault Charbonnier for the patch._
    * bugfix: `ngx.req.set_header()`: only override the input header once. _Thanks spacewander for the patch._

    * change: [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) is now mandatorily loaded, and the [lua_load_resty_core](https://github.com/openresty/lua-nginx-module#lua_load_resty_core) directive is deprecated. _Thanks Thibault Charbonnier for the patch._
    * change: given the above change, old CFunction APIs have been retired when newer [FFI](https://luajit.org/ext_ffi.html) implementations are available via `resty.core`. _Thanks Thibault Charbonnier for the patch._
    * change: given the above changes, we now prevent compilation with PUC-Rio Lua; only [LuaJIT](https://github.com/openresty/luajit2#readme) 2.x is supported going forward. _Thanks Thibault Charbonnier for the patch._
    * change: removed compatibility code for unsupported [NGINX](nginx.html) core versions (< 1.6.0). _Thanks Thibault Charbonnier for the patch._
    * change: we now ignore `lua_regex_*` directives when [NGINX](nginx.html) is compiled without PCRE support, which allows for [resty-cli](https://github.com/openresty/resty-cli#readme) to work without requiring PCRE. _Thanks Thibault Charbonnier for the patch._
    * change: removed extraneous error logging when `coroutine.resume()` throws runtime errors; this change ensures [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) aligns with standard Lua behavior. _Thanks Thibault Charbonnier for the patch._
    * change: `coroutine.wrap()` now propagates runtime errors to the parent coroutine; this change ensures [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) aligns with standard Lua behavior. _Thanks Thibault Charbonnier for the patch._
    * feature: [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme): added support for specifying environment variables in the `ngx_pipe.spawn()` [FFI](https://luajit.org/ext_ffi.html) API. _Thanks spacewander for the patch._
    * feature: [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme): added support for specifying timeouts in the `ngx_pipe.spawn` [FFI](https://luajit.org/ext_ffi.html) API. _Thanks spacewander for the patch._
    * feature: [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme): added support for calling `ngx_pipe.shutdown()` on a sub-process when a light thread is waiting on it. _Thanks spacewander for the patch._
    * feature: enabled the `ngx.thread` and `ngx.socket.udp` APIs in [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block). _Thanks Tom Thorogood for the patch._
    * feature: implemented the [FFI](https://luajit.org/ext_ffi.html) interface for the `ngx_req.add_header` API. _Thanks spacewander for the patch._
    * feature: implemented the [FFI](https://luajit.org/ext_ffi.html) interfaces for `ngx.crc32_short` and `ngx.crc32_long`. _Thanks Thibault Charbonnier for the patch._
    * feature: when a timer fails to run, we now log the location of its function's definition. _Thanks spacewander for the patch._
    * bugfix: skip the [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) and [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) handlers when using TLS 1.3. _Thanks spacewander for the patch._
    * bugfix: config: ensured [LuaJIT](https://github.com/openresty/luajit2#readme) [FFI](https://luajit.org/ext_ffi.html) check and static PCRE builds succeed on all platforms. _Thanks Thibault Charbonnier for the patch._

    * bugfix: config: fallback to `--undefined` option for ld 2.25 and below. _Thanks Thibault Charbonnier for the patch._

    * bugfix: config: ensured the `pcre_version` symbol is always preserved when PCRE is statically linked. _Thanks Thibault Charbonnier for the patch._

    * bugfix: config: ensured the `pcre_version` symbol is always preserved on Darwin platforms as well. _Thanks Thibault Charbonnier for the patch._
    * bugfix: config: fixed an issue preventing compiliation with dynamic modules; we now avoid specifying `-DLUA_DEFAULT_PATH` and `-DLUA_DEFAULT_CPATH` via `CFLAGS`.

    * bugfix: ensured [set_by_lua_file](https://github.com/openresty/lua-nginx-module#set_by_lua_file) directives containing [NGINX](nginx.html) variables re-computes their closure's code cache key. _Thanks Thibault Charbonnier for the patch._

    * bugfix: fixed compilation with [NGINX](nginx.html) cores < 1.11.11. _Thanks Thibault Charbonnier for the patch._

    * bugfix: error logs now set LuaJIT's currentline to `-1` if no currentline is available. _Thanks spacewander for the patch._
    * bugfix: [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme): ensured reading while a process died returns the "closed" error. _Thanks Thibault Charbonnier for the patch._
    * bugfix: added missing arguments to an `ngx_log_error` call in `ngx_http_lua_pipe.c`. _Thanks Thibault Charbonnier for the patch._
    * optimize: improved code cache lookup performance by using `luaL_ref()` to avoid invoking the costly `lj_str_new` for each Lua handler execution. _Thanks Thibault Charbonnier for the patch._
    * optimize: fixed the pre-allocated number of keys in the `ngx.socket.tcp` table. _Thanks Thibault Charbonnier for the patch._
    * optimize: removed declaration of the obsolete `ngx_http_lua_inject_logby_ngx_api` function. _Thanks Thibault Charbonnier for the patch._
    * refactor: simplified Lua chunk and file cache key generation. _Thanks Thibault Charbonnier for the patch._
    * refactor: reduced cache key size by removing unnecessary chunkname component. _Thanks Thibault Charbonnier for the patch._
    * misc: `ngx_http_lua_util.h`: removed `ngx_str_set` definition as it is always defined in [NGINX](nginx.html) 1.6.0+ (the minimum supported [NGINX](nginx.html) core version). _Thanks Thibault Charbonnier for the patch._
    * misc: removed dead code, guard non-OpenResty [LuaJIT](https://github.com/openresty/luajit2#readme) definitions, and fixed styling issues. _Thanks Thibault Charbonnier for the patch._
    * misc: fixed some warnings from the clang static code analyzer.
    * style: fixed a minor alignment issue in `ngx_http_lua_ssl_certby.c`. _Thanks Thibault Charbonnier for the patch._
    * style: updated `nginx_version` guard macros and assume it is always defined. _Thanks Thibault Charbonnier for the patch._
* upgraded [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) to 0.0.8.
    * feature: this module can now be compiled as a dynamic module with via the `--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: config: fixed an issue preventing compiliation with dynamic modules; we now avoid specifying `-DLUA_DEFAULT_PATH` and `-DLUA_DEFAULT_CPATH` via `CFLAGS`.
    * Ported many features from ngx_http_lua 0.10.16. _Thanks Thibault Charbonnier for the ports._
        * change: [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) is now mandatorily loaded, and the [lua_load_resty_core](https://github.com/openresty/lua-nginx-module#lua_load_resty_core) directive is deprecated.
        * change: given the above change, old CFunction APIs have been retired when newer [FFI](https://luajit.org/ext_ffi.html) implementations are available via `resty.core`.
        * change: given the above changes, we now prevent compilation with PUC-Rio Lua; only [LuaJIT](https://github.com/openresty/luajit2#readme) 2.x is supported going forward.
        * change: removed compatibility code for unsupported [NGINX](nginx.html) core versions (< 1.6.0).
        * change: removed extraneous error logging when `coroutine.resume()` throws runtime errors; this change ensures [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) aligns with standard Lua behavior.
        * change: `coroutine.wrap()` now propagates runtime errors to the parent coroutine; this change ensures [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) aligns with standard Lua behavior.
        * feature: when a timer fails to run, we now log the location of its function's definition.
        * bugfix: error logs now set LuaJIT's currentline to `-1` if no currentline is available.
        * bugfix: fixed compilation with [NGINX](nginx.html) cores < 1.11.11.
        * misc: fixed some warnings from the clang static code analyzer.
    * Ported many features from ngx_http_lua 0.10.15. _Thanks Thibault Charbonnier for the ports._
        * feature: added the `pool_size` and `backlog` options to the [tcpsock:connect()](https://github.com/openresty/lua-nginx-module#tcpsockconnect) API in order to support backlog queuing in cosocket connection pools.
        * feature: implemented the [tcpsock:receiveany()](https://github.com/openresty/lua-nginx-module#tcpsockreceiveany) upstream cosocket API.
        * feature: allowed sending boolean and nil values in cosockets.
        * feature: api.h: exposed the `ngx_stream_lua_ffi_str_t` C data type for other [NGINX](nginx.html) C modules.
        * feature: errors are now logged when timers fail to run.
        * bugfix: we now avoid [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) putting connections into the pool when [NGINX](nginx.html) is already shutting down.
        * bugfix: inlined Lua code snippets in `nginx.conf` failed to use the Lua source checksum as part of the Lua code cache key.
        * bugfix: config: ensured [LuaJIT](https://github.com/openresty/luajit2#readme) [FFI](https://luajit.org/ext_ffi.html) check and static PCRE builds succeed on all platforms.
        * bugfix: config: fallback to `--undefined` option for ld 2.25 and below.
        * bugfix: config: ensured the `pcre_version` symbol is always preserved when PCRE is statically linked.
        * bugfix: config: ensured the `pcre_version` symbol is always preserved on Darwin platforms as well.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.18.
    * bugfix: `ngx.req.get_headers()` might return an empty table without the metatable set. _Thanks chengjie.zhou for the patch._
    * feature: `resty.core.uri`: `ngx.escape_uri()`: add optional argument `type`. _Thanks lijunlong for the patch._
    * change: we now require [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) v0.10.16 and [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) v0.0.8.
    * change: updated to support the ngx_http_lua module without the now removed CFunction APIs. _Thanks Thibault Charbonnier for the patch._
    * feature: updated the `ngx_ssl.get_tls1_version_str()` API to recognize TLS 1.3 connections. _Thanks Thibault Charbonnier for the patch._
    * feature: implemented the `ngx.req` module and the `ngx_req.add_header()` API. _Thanks spacewander for the patch._
    * feature: added support specifying timeouts in the `ngx_pipe.spawn()` API. _Thanks spacewander for the patch._
    * feature: added support for specifying environment variables in the `ngx_pipe.spawn()` API. _Thanks spacewander for the patch._
    * feature: allowed for calling `ngx_pipe.shutdown()` on a sub-process when a light thread is waiting on it. _Thanks spacewander for the patch._
    * feature: implemented `ngx.crc32_short()` and `ngx.crc32_long()` via [FFI](http://luajit.org/ext_ffi.html). _Thanks Thibault Charbonnier for the patch._
    * feature: ensured loading the `ngx.re` module without PCRE produces a friendly error. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based API for all `ngx.worker.*` APIs in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based API for `ngx.var` in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based API for `ngx.ctx` and 'ngx.status' in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based API for `ngx.encode_base64()` and `ngx.decode_base64()` in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based API for `ngx.exit()` in the stream submodule. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based APIs for `ngx.escape_uri()` and `ngx.unescape_uri()` in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled the FFI-based APIs for `ngx.md5()`, `ngx.md5_bin()`, and `ngx.sha1_bin()` in the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * bugfix: `ngx.re`: fixed the error stacktrace level when missing PCRE support. _Thanks Thibault Charbonnier for the patch._
    * bugfix: ensured `ngx.pipe` APIs with an invalid `self` argument throw an error with the proper stack level. _Thanks Thibault Charbonnier for the patch._
    * bugfix: updated `ssl.get_tls1_version_str()` to return the error `"unknown version"` when the TLS version number is not recognized. _Thanks Thibault Charbonnier for the patch._
    * optimize: load the `resty.core.misc` module last to avoid metatable lookups on `ngx`. _Thanks Thibault Charbonnier for the patch._
    * optimize: made `ngx_resp.add_header()` early-exit when `header_value` is an empty table. _Thanks spacewander for the patch._
* upgraded [LuaJIT](https://github.com/openresty/luajit2) to 2.1-20200102.
    * feature: Increased the maximum number of allowed upvalues from 60 to 120.
    * feature: Added initial s390x support.
    * Move all register allocations out of the asm_href loop.
    * aarch64: Fix register allocation issue for XLOAD.
    * aarch64: Use the xzr register whenever possible.
    * aarch64: Allocate LJ_TISNUM early.
    * aarch64: Fixed crash with side traces under register pressure.
    * ARM: Fix up condition codes for conditional arithmetic insn.
    * ARM64: Added support for FNMADD and FNMSUB.
    * Fixed `os.date` for timezone change awareness.
    * `jit.prngstate`: Return a sane value (0) for `LUAJIT_DISABLE_JIT`.
    * [thread.exdata](https://github.com/openresty/luajit2#threadexdata): Build `recff_thread_exdata` only for `LJ_HASFFI`.
    * Removed redundant `emit_check_ofs`.
    * doc: mentioned the increase in the maximum number of upvalues in the miscellaneous section.
    * doc: reworded the description of the [table.isempty](https://github.com/openresty/luajit2#tableisempty) API.
    * imported Mike Pall's latest changes:
        * Properly fix pointer diff in [string.find()](http://www.lua.org/manual/5.1/manual.html#pdf-string.find).
        * x64: Enable `LJ_GC64` mode by default.
        * [FFI](http://luajit.org/ext_ffi.html): Eliminate hardcoded string hashes.
        * Fix interaction between profiler hooks and finalizers.
        * Don't use STRREF for pointer diff in [string.find()](https://www.lua.org/manual/5.1/manual.html#pdf-string.find).
        * Fix `tonumber("-0")`.
        * Fix hash table chaining (again).
        * Fix declarations of _BitScanForward/_BitScanReverse.
        * Add stricter check for `print()` vs. `tostring()` shortcut.
        * Prevent integer overflow while parsing long strings.
        * Fix stack check when recording BC_VARG.
        * [FFI](http://luajit.org/ext_ffi.html): Add missing write barrier on C library index update.
        * [FFI](http://luajit.org/ext_ffi.html): Workaround for platform dlerror() returning NULL.
        * OSX: Use `__thread` attribute.
        * OSX: Don't set a default `MACOSX_DEPLOYMENT_TARGET`.
        * Build MinGW import library, too.
        * Fix MinGW make clean.
        * Update Android and iOS build docs.
        * Add note about the unsuitabilty of `math.random()` for crypto.
        * Update MSVC build script and docs.
        * More recent MSVC is partially C99 compliant.
        * Fix narrowing of conversions to U32.
        * doc: readme.md: improve completeness and readability.
        * Fix unsinking of 64 bit constants.
        * Fix bytecode dump unpatching.
        * Fix `debug.getinfo()` argument check.
        * MIPS: Fix delay slot hint.
        * Fix TNEW load forwarding with instable types.
        * ARM: Fix GCC 7 `-Wimplicit-fallthrough` warnings.
        * ARM: Fix condition code check fusion.
        * ARM64: Avoid side-effects of constant rematerialization.
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache#readme) to 0.10.
    * feature: implemented a user flags attribute similar to that of the 'shdict' API. _Thanks Thibault Charbonnier for the patch._
    * feature: implemented the `cache:get_keys()` API. _Thanks Thibault Charbonnier for the patch._
    * feature: implemented the `cache:count()` and `cache:capacity()` APIs. _Thanks Datong Sun for the patch._
    * feature: implemented a user `flags` attribute similar to that of the `ngx.shared` API. _Thanks Thibault Charbonnier for the patch._
    * makefile: added a `lint` target to detect invalid test cases which we now use in Travis CI. _Thanks Thibault Charbonnier for the patch._
    * doc: cleaned up outdated resources and grammatical improvements.
    * doc: fixed a minor typo in the `cache:flush_all()` description.
    * doc: updated the `cache:set` usage section to reflect the `ttl` argument being optional.
* upgraded [lua-resty-string](https://github.com/openresty/lua-resty-string#readme) to 0.12.
    * optimize: removed a duplicate string length lookup in `to_hex()`. _Thanks Robert Paprocki for the patch._
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.28.
    * bugfix: handle mixture of `read_reply()` and other commands.  _Thanks spacewander for the patch._
    * feature: added new options `ssl` and `ssl_verify` to the `red:connect()` API for connecting to Redis over TLS. _Thanks Vinayak Hulawale for the patch._
    * feature: implemented the `red:set_timeouts()` API. _Thanks zouyi for the patch._
* upgraded [lua-resty-shell](https://github.com/openresty/lua-resty-shell#readme) to 0.03.
    * doc: clarified return values and behavior upon reaching a timeout threshold. _Thanks Dejiang Zhu for the patch._
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.25.
    * security: restydoc-index: we did not quote doc file paths properly when interpolating them into shell commands, which was a security vulnerability. _Thanks xlibor for the patch._
    * feature: resty: added new `--user-runner` option.
    * feature: set the `ngx.config.is_console` field to `true` to detect the [resty-cli](https://github.com/openresty/resty-cli#readme) environment from Lua scripts.
    * bugfix: we do not forward `SIGHUP` to [NGINX](nginx.html) processes anymore since [resty-cli](https://github.com/openresty/resty-cli#readme) is usually run as non-daemon and `SIGHUP` should be converted to `SIGQUIT`.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.62.
    * bugfix: config: we now always use double quotes in `[...]` conditionals.
    * bugfix: config: avoided an error with [NGINX](nginx.html) 1.17.0 and above. _Thanks Thibault Charbonnier for the patch._
    * style: fixed a coding style issue found by `ngx-releng`.
* upgraded [ngx_srcache](https://github.com/openresty/srcache-nginx-module#readme) to 0.32.
    * bugfix: config: we should always use double quotes in `[...]` conditionals.
    * bugfix: config: avoided an error with [NGINX](nginx.html) 1.17.0 and above. _Thanks Thibault Charbonnier for the patch._
    * style: fixed minor coding style issues found by `ngx-releng`.
    * doc: documented a tip to make memcached store objects bigger than 1MB.

* upgraded [lua-cjson](https://github.com/openresty/lua-cjson) to 2.1.0.8.
    * feature: added an option to disable forward slash escaping. _Thanks Jesper Lundgren for the patch._

* upgraded [lua-resty-memcached](https://github.com/openresty/lua-resty-memcached#readme) to v0.15.
    * bugfix: `gets()` did not return socket send errors at the correct index. _Thanks Justin Li for the patch._
