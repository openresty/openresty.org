<!---
    @title         ChangeLog 1.11.2
--->

# Version 1.11.2.5 - 17 August 2017

* feature: applied a patch to the [nginx](nginx.html) core to make the [nginx](nginx.html) variable `$proxy_add_x_forwarded_for` accessible on Lua land. thanks spacewander for the patch.
* feature: added the balancer-status-code patch to the [nginx](nginx.html) core to allow returning arbitrary HTTP status codes inside upstream balancers. thanks Datong Sun for the patch.
* feature: we now search LuaJIT bytecode files `*.ljbc` before Lua source files `*.lua` in the default Lua module search paths.
* feature: applied the intercept-error-log patch to the [nginx](nginx.html) core to provide 3rd-party modules a hook to intercept [nginx](nginx.html) error log data without touching files. 3rd-party modules can register a custom interception hook to `ngx_http_core_main_conf_t.intercept_log_handler`. thanks Yuansheng Wang for the patch.
* feature: `./configure`: the user flags specified by the `--with-luajit-xcflags=FLAGS` option are not appended to the default flags instead of being prepended. thanks spacewander for the report.
* feature: applied a small patch to the [nginx](nginx.html) core to add support for the "privileged agent" process which is run by the same system account as the master. thanks Yuansheng Wang for the patch.
* change: applied a patch to the [nginx](nginx.html) core to turn [nginx](nginx.html) to openresty in the builtin special response pages' footer. thanks Datong Sun for the patch.
* bugfix: the feature test for SSE 4.2 support did not really check if the local CPU indeed has it. thanks Jukka Raimovaara for the patch.
* bugfix: applied the single-process-graceful-exit patch to the [nginx](nginx.html) core to fix the issue that [nginx](nginx.html) fails to perform graceful exit when `master_process` is turned off.
* bugfix: `./configure`: the `--without-http_lua_upstream` option alone incorrectly disabled all the Lua stuff.
* feature: applied the delayed-posted-events patch to the [nginx](nginx.html) core for adding "delayed posted events" which run in the next event cycle with 0 delay. this [nginx](nginx.html) core feature is needed by the `ngx.sleep(0)` feature in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme), for example. thanks Datong Sun for the patch.
* change: swtched to OpenResty's own fork of `ngx_postgres`: https://github.com/openresty/ngx_postgres
* doc: updated the LuaJIT restydoc indexes to the latest version.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.19.
    * feature: resty: added new command-line option `--errlog-level LEVEL`. thanks Michal Cichra for the patch.
    * feature: resty: added new command-line option `--rr` to use `rr record` to run the underlying C process. this is for [Mozilla rr](http://rr-project.org/) recording.
    * feature: resty: added new command-line option `--gdb` to use gdb to run the underlying C process.
    * feature: resty: implemented the `--http-conf CONF` command-line option.
    * feature: added the `--ns IP` command line options to override system (or google) nameservers. thanks Aapo Talvensaari for the patch.
    * bugfix: we did not quote the Lua code chunk names properly.
    * bugfix: bad Lua file names given on the command line might give rise to strange errors and even hanging.
    * bugfix: resty: user created timers and unwaited light threads were not handled gracefully upon exit.
    * bugfix: md2pod.pl: we did not unescape `&ast;`.
    * optimize: resty: now we increase the value of [lua_regex_cache_max_entries](https://github.com/openresty/lua-nginx-module#lua_regex_cache_max_entries) to 40K.
    * doc: made it clear that one should install `openresty-resty` and/or `openresty-doc` if they uses the [offiical OpenResty pre-built Linux package repositories](https://openresty.org/en/linux-packages.html).
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.10.
    * feature: added pure C API for tuning the `jit_stack_size` option in PCRE. this is used by the [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme) library of [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). thanks Andreas Lubbe for the patch.
    * feature: added pure C functions `ngx_http_lua_ffi_worker_type()` & `ngx_http_lua_ffi_worker_privileged()` for the [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme) module in [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). thanks Yuansheng Wang for the patch.
    * feature: added new config directive [lua_intercept_error_log](https://github.com/openresty/lua-nginx-module#lua_intercept_error_log) for capturing [nginx](nginx.html) error logs on Lua land. the corresponding Lua API is provided by the [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme) module in [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). thanks Yuansheng Wang for the patch and Jan Prachař for a bug fix.
    * feature: implemented the [ngx.timer.every()](https://github.com/openresty/lua-nginx-module#ngxtimerevery) API function for creating recurring timers. thanks Dejiang Zhu for the patch.
    * feature: [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block): now the user Lua code can terminate the current request with arbitrary HTTP response status codes via [ngx.exit()](https://github.com/openresty/lua-nginx-module#ngxexit). thanks Datong Sun for the patch.
    * feature: added pure C API function `ngx_http_lua_ffi_errlog_get_sys_filter_level` for the `ngx.errlog` module's `get_sys_filter_level()` function in the [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) library. thanks spacewander for the patch.
    * feature: `ngx.sleep(0)` now always yield the control to the [nginx](nginx.html) event loop. this can be used to do voluntary CPU time slicing when running CPU intensive computations on the Lua land and to avoid such computations from blocking the [nginx](nginx.html) event loop for too long. this feature requires OpenResty's delayed-posted-event patch for the [nginx](nginx.html) core. thanks Datong Sun for the patch.
    * feature: added new pure C API `ngx_http_lua_ffi_process_signal_graceful_exit()` for the [signal_graceful_exit()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#signal_graceful_exit) function of the [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme) module in [lua-resty-core](https://github.com/openresty/lua-resty-core#readme).
    * feature: [nginx](nginx.html) 1.11.11+ can now build with this module. note: [nginx](nginx.html) 1.11.11+ are still not an officially supported target yet. thanks Andrei Belov for the patch.
    * bugfix: the running timer counter might go out of sync when non-timer handlers using fake requests are involved (like ssl_certficate_by_lua* and ssl_session_fetch_by_lua*). thanks guanglinlv for the patch.
    * bugfix: [ngx.encode_args()](https://github.com/openresty/lua-nginx-module#ngxencode_args) did not escape "|", ",", "$", "@", and "&#96;". now it is now consistent with what Google Chrome's JavaScript API function `encodeURIComponent()` does. thanks goecho for the patch.
    * bugfix: [ngx.escape_uri()](https://github.com/openresty/lua-nginx-module#ngxescape_uri) did not escape "|", ",", "$", "@", and "&#96;".
    * bugfix: segmentation fault would occur when several server {} blocks listen on the same port or unix domain socket file path *and* some of them are using [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) configurations while some are not. thanks petrovich-ua for the report and original patch.
    * bugfix: the fake requests/connections might leak when memory allocations fail. thanks skyever for the patch.
    * bugfix: segmentation fault might happen when a stale read event happens after the downstream cosocket object is closed. thanks Dejiang Zhu for the report.
    * bugfix: [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme): when [nginx](nginx.html) workers exit, the harmless error message "semaphore gc wait queue is not empty" might be logged. thanks Yuansheng Wang for the patch.
    * bugfix: fixed typos in error messages. thanks spacewander for the patch.
    * refactor: ocsp: removed a useless line of code, which unbreak the libressl build. thanks Kyra Zimmer for the original patch.
    * doc: fixed a typo in a code example for `ngx.re.match`. thanks Ming Wen for the patch.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.12.
    * feature: added [opt()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#opt) function to the [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme) Lua module that accepts the "jit_stack_size" option to tune the JIT stack size of PCRE. thanks Andreas Lubbe for the patch.
    * feature: added new Lua module [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme) which has functions [type()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#type) and [enable_privileged_agent()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#enable_privileged_agent). thanks Yuansheng Wang for the patch.
    * feature: added new Lua module [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme) which provides Lua API to capture [nginx](nginx.html) error log data on Lua land. thanks Yuansheng Wang for the patch.
    * feature: added the new [signal_graceful_exit()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#signal_graceful_exit) function to the [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme) Lua module.
    * feature: [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme): added the [get_sys_filter_level()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#get_sys_filter_level) API function to get the "system" error log filtering level defined in [nginx](nginx.html).conf's [error_log](http://nginx.org/r/error_log) directive. thanks spacewander for the patch.
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme): [split()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#split) might enter infinite loops when the regex yields matches with empty captures. thanks Thibault Charbonnier for the patch.
    * optimize: simplified the "BOOL and true or false" expressions. thanks Evgeny S for the patch.
    * doc: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): added performace notes for [set_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_priv_key) and [set_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_cert). thanks Filip Slavik for the patch.
    * doc: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme): fixed some typos. thanks detailyang for the patch.
    * doc: code example: private keys are usually stored in PEM, so we use the func [priv_key_pem_to_der](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#priv_key_pem_to_der) in the example to do the conversion. thanks soul11201 for the patch.
    * doc: [ngx.ssl.session](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl/session.md#readme): fixed the missing arguments in the code example. thanks soul11201 for the patch.
    * doc: fixed the code examples since directives `ssl_session_*_by_lua*` are no longer allowed in `server {}`. thanks Yuansheng Wang for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.19.
    * feature: added support for SOA typed queries. thanks Ming Wen for the patch.
* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.20.
    * feature: [connect()](https://github.com/openresty/lua-resty-mysql/#connect): added the charset option to specify the connection charset. thanks Wilhelm Liao for the patch.
    * feature: added support for `FIELD_TYPE_DECIMAL` for MySQL servers prior to 5.0 and 5.0. thanks panyingxue for the patch.
    * bugfix: newer versions of MySQL use length-encoded strings for the human readable "info" message in MySQL's "OK packet". thanks zhuanyenan for the report.
* upgraded [lua-resty-lock](https://github.com/openresty/lua-resty-lock#readme) to 0.07.
    * feature: added new method [expire()](https://github.com/openresty/lua-resty-lock/#expire) that can change the TTL of the lock being held. thanks Datong Sun for the patch.
* upgraded lua-resty-string to 0.10.
    * bugfix: resty.aes: fixed memory overrun bug when user provided a salt of less than 8 characters but EVP_BytesToKey() expects more. disallows salt strings longer than 8 characters to avoid false sense of security.
    * refactor: commented out unneeded locals, and removed unused variable declarations. thanks Aapo Talvensaari for the patch.
    * doc: typo fixes from Juarez Bochi.
* upgraded lua-resty-upstream-healthcheck to 0.05.
    * optimize: removed useless code. thanks Yuansheng Wang for the patch.
    * doc: typo fixes from Mike Rostermund.
* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme) to 0.04.
    * bugfix: reduce race condition between get/incr(key). by using `incr` first, we could avoid overcommits between `get(key)` and `incr(key)`. thanks spacewander for the patch.
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache#readme) to 0.07.
    * bugfix: fixed a type mismatch issue found by 其实不想走. the old form still works due to LuaJIT FFI's magic.
* upgraded [ngx_lua_upstream](https://github.com/openresty/lua-upstream-nginx-module#readme) to 0.07.
    * bugfix: turning a peer up via [set_peer_down()](https://github.com/openresty/lua-upstream-nginx-module/#set_peer_down) did not reset the peer's "fails" counter, which might get the peer to be marked down again prematurely.
    * doc: documented the "down" key in the [get_primary_peers()](https://github.com/openresty/lua-upstream-nginx-module/#get_primary_peers) result.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.61.
    * feature: [nginx](nginx.html) 1.11.11+ can now build with this module. note: [nginx](nginx.html) 1.11.11+ are still not an officially supported target yet. thanks Andrei Belov for the patch.
    * doc: minor typo fixes from mrefish and Mathieu Aubin.
    * doc: added a note about the empty values of `$echo_client_request_headers` in HTTP/2 requests.
* upgraded [ngx_postgres](https://github.com/openresty/ngx_postgres#readme) to 1.0.
    * feature: fixed compilation errors with [nginx](nginx.html) 1.9.1+. thanks Vadim A. Misbakh-Soloviov for the original patch.
    * feature: fixed the compilation errors with [nginx](nginx.html) 1.11.6+.
* upgraded LuaJIT to v2.1-20170808: https://github.com/openresty/luajit2/tags
    * bugfix: [FFI](http://luajit.org/ext_ffi.html) C parsers could not parse some C constructs like `__attribute((aligned(N)))` and `#pragma`. decoupled hash functions used in comparison (hardcoded) and string table. thanks Shuxin Yang for the patch. this bug had first appeared in v2.1-20170405 (or OpenResty 1.11.2.3).
    * bugfix: fixed a clang warning in lj_str.c regarding unused str_fastcmp() when macro LUAJIT_USE_VALGRIND is defined.
    * imported Mike Pall's latest changes:
        * bugfix: added missing LJ_MAX_JSLOTS check, which might lead to JIT stack overflow when exceeding this limit. tracked down the Mozilla rr tool. already merged in upstream LuaJIT.
        * FreeBSD/x64: Avoid changing resource limits, if not needed.
        * PPC: Add soft-float support to interpreter.
        * x64/`LJ_GC64`: Fix `emit_rma()`.
        * MIPS64: Add soft-float support to JIT compiler backend.
        * MIPS: Fix handling of spare long-range jump slots.
        * MIPS: Use precise search for exit jump patching.
        * Add FOLD rules for mixed BAND/BOR with constants.
        * [FFI](http://luajit.org/ext_ffi.html): Compile bitfield loads/stores.
        * Add workaround for MSVC 2015 stdio changes.
        * MIPS64: Fix stores of MULTRES.
        * MIPS64: Fix write barrier in `BC_USETV`.
        * ARM64: Fix stores to vmstate.
        * From Lua 5.2: Add `lua_tonumberx()` and `lua_tointegerx()`.
        * From Lua 5.2: Add `luaL_setmetatable()`.
        * From Lua 5.2: Add `luaL_testudata()`.
        * From Lua 5.3: Add `lua_isyieldable()`.
        * From Lua 5.2: Add `lua_copy()`.
        * From Lua 5.2: Add `lua_version()`.
        * OSX: Fix build with recent XCode.
        * Allow building on Haiku OS. Note: this is not an officially supported target.

# Version 1.11.2.4 - 11 July 2017

* bugfix: [nginx](nginx.html): applied nginx's official security fix for an issue in the range filter (CVE-2017-7529).

# Version 1.11.2.3 - 21 April 2017

* change: we no longer bundle the standard Lua 5.1 interpreter (aka the PUC-Rio Lua). now we only bundle LuaJIT.
* win32: upgraded PCRE to 8.40, zlib to 1.2.11, and OpenSSL to 1.0.2k.
* bugfix: we did not use `PATH` in `./configure --sbin-path=PATH` when creating symlinks. thanks David Galeano for the patch.
* bugfix: default index.html: missing the `</p>` tag. thanks Xiaoyu Chen for the patch.
* feature: applied the `safe_resolver_ipv6_option` patch to the [nginx](nginx.html) core to avoid the `ipv6=off` option to be parsed by [nginx](nginx.html) when it is not built with IPv6 support. thanks Thibault Charbonnier for the patch.
* feature: now we automatically add the `-msse4.2` compilation option for building the bundled LuaJIT when it is available.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.8.
    * feature: fixed build compatibility with BoringSSL. thanks Tom Thorogood for the patch. Note: BoringSSL is *not* an officially supported target.
    * feature: `tcpsock:connect()`: allows the `options_table` argument being nil. thanks Dejiang Zhu for the patch.
    * feature: added support for the 303 status code in [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect). thanks Tom Thorogood for the patch.
    * bugfix: C API: `ngx_http_lua_add_package_preload()` might not take effect when lua_code_cache is off. thanks jimtan for the patch.
    * bugfix: [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block): the number of retres might exceed the limit of [proxy_next_upstream_tries](http://nginx.org/r/proxy_next_upstream_tries) or alike.
    * bugfix: setting response headers would change the `Content-Type` response header. thanks leafo for the report and Ming Wen for the patch.
    * bugfix: tcp cosockets: `sslhandshake()`: typo in the error message. thanks detailyang for the patch.
    * bugfix: typo fix in C POST args handler debug log. thanks Robert Paprocki for the patch.
    * change: removed the use of `luaL_getn()` macro as it is no longer available in the latest LuaJIT v2.1. thanks Datong Sun for the patch.
    * change: removed the `mmap(sbrk(0))` memory trick since glibc leaks memory when it is forced to use `mmap()` to fulfill `malloc()`.
    * doc: [ngx.exit()](https://github.com/openresty/lua-nginx-module#ngxexit) also returns immediately in the [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) context. thanks Jinhua Tan for the patch.
    * doc: various wording tweaks and more code examples. thanks Dayo Akanji for the patch.
    * doc: added a note about the LRU regex cache used in the [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme).* implementation of [lua-resty-core](https://github.com/openresty/lua-resty-core#readme).
    * tests: the test suite can now work with PCRE 8.39 ~ 8.40. thanks Andreas Lubbe for the patch.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.17.
    * optimize: removed unwanted exit status handling. thanks Thibault Charbonnier for the patch.
    * feature: generates Lua stacktraces by default for user errors. thanks Thibault Charbonnier for the patch.
    * bugfix: fixed exit code handling for [nginx](nginx.html) crashes and INT signal interrupts. thanks Aliaxandr Rahalevich and Gordon Gao for the report.
    * feature: resty: added the --shdict "NAME SIZE" option. thanks Thibault Charbonnier for the patch.
    * feature: resty: added new command-line option `--resolve-ipv6`. thanks Thibault Charbonnier for the patch.
* upgraded [opm](https://github.com/openresty/opm#readme) to 0.0.3.
    * `dist.ini`: relaxed the github repo link check.
    * feature: added support for HTTP proxies via environments `http_proxy` and `https_proxy`.
    * bugfix: tar might give the permissions error 'Cannot change ownership to uid XX, gid XX: Operation not permitted'. thanks Jon Keys for the patch.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.11.
    * feature: `resty.core.regex`: exported internal Lua helper functions `collect_captures`, `check_buf_size`, and `re_sub_compile`. these functions are deliberately undocumented and thus subject to future changes.
    * change: `resty.core`: made the warning louder by turning it to an alert when LuaJIT 2.0 is used.
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme): `split()` might enter infinite loops when the regex is an empty string. thanks Dejiang Zhu for the patch.
* upgraded [lua-resty-lock](https://github.com/openresty/lua-resty-lock#readme) to 0.06.
    * optimize: use branch-free algorithms for variables assignment. thanks Thibault Charbonnier for the patch.
    * optimize: removed the unused shdict metatable retrieval code. thanks Thibault Charbonnier for the patch.
    * doc: various documentation improvements from Thibault Charbonnier.
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache#readme) to 0.06.
    * bugfix: `resty.lrucache`: the `get()` method incorrectly ignored `false` values. thanks Proton for the patch.
    * optimize: small tweaks from Aapo Talvensaari and Thibault Charbonnier.
    * doc: typo fixes from Gordon Gao.
* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.19.
    * bugfix: the 8-bit packet numbers might overflow and led to runtime Lua exceptions. thanks Ming Wen for the patch.
* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme) to 0.03.
    * bugfix: fixed several known race conditions by switching to `shdict:incr(k, v, init)`. thanks Thibault Charbonnier for the patch.
    * optimize: use `math.max()` to reduce Lua branches. thanks Thibault Charbonnier for the patch.
* upgraded [lua-redis-parser](https://github.com/openresty/lua-redis-parser#readme) to 0.13.
    * bugfix: removed the use of the old Lua 5.0 `luaL_getn` API function since the latest LuaJIT 2.1 just removed it.
* upgraded [lua-cjson](https://github.com/openresty/lua-cjson#readme) to 2.1.0.5.
    * feature: supports MS C compiler older than VC2012. thanks spacewander for the patch.
    * bugfix: fixed compilation errors from the Microsoft C compiler. thanks Tim Chen for the patch.
    * bugfix: conditionally build `luaL_setfuncs()` function as the latest LuaJIT v2.1 already includes it. thanks Datong Sun for the patch.
    * bugfix: preserve `empty_array_mt` behavior upon multiple loadings of the module. thanks Thibault Charbonnier for the patch.
* upgraded [ngx_redis2](https://github.com/openresty/redis2-nginx-module#readme) to 0.14.
    * feature: fixed compilation errors with [Nginx](nginx.html) 1.11.6+.
* upgraded [ngx_memc](https://github.com/openresty/memc-nginx-module#readme) to 0.18.
    * feature: fixed the compilation errors with [nginx](nginx.html) 1.11.6+. thanks Hiroaki Nakamura for the patch.
* upgraded [ngx_drizzle](https://github.com/openresty/drizzle-nginx-module#readme) to 0.1.10.
    * feature: fixed compilation issues with [nginx](nginx.html) 1.11.6+. thanks James Christopher Adduono for the patch.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded LuaJIT to v2.1-20170405: https://github.com/openresty/luajit2/tags
    * feature: added the bytecode option `L` to display lua source line numbers. thanks Dejiang Zhu for the patch.
    * optimize: x64: `lj_str_new`: uses randomized hash functions based on crc32 when `-msse4.2` is used in build options. thanks Shuxin Yang for the patch.
    * optimize: `lj_str_new`: tests the full hash value before doing the full string comparison on hash collisions. thanks Shuxin Yang for the patch.
    * imported Mike Pall's latest changes:
        * Add some more changes and extensions from Lua 5.2.
        * Remove old Lua 5.0 compatibility defines.
        * [FFI](http://luajit.org/ext_ffi.html): Fix FOLD rules for `int64_t` comparisons.
        * ARM64: Add big-endian support.
        * x64/`LJ_GC64`: Fix `emit_loadk64()`.
        * `LJ_GC64`: Fix `BC_CALLM` snapshot handling.
        * x64/`LJ_GC64`: Fix assembly of CNEWI with 64 bit constant pointer.
        * ARM64: Fix Nintendo Switch build.
        * ARM64: Fix XLOAD/XSTORE with FP operand.
        * Remove unnecessary mcode alloc pointer check.
        * Limit mcode alloc probing, depending on the available pool size.
        * Fix overly restrictive range calculation in mcode allocation.
        * Fix out-of-scope goto handling in parser.
        * Remove internal `__mode = "K"` and replace with safe check.
        * Fix annoying warning, due to deterministic binutils configuration.
        * DynASM: Fix warning.
        * MIPS64, part 2: Add MIPS64 hard-float JIT compiler backend.
        * Fix FOLD rules for `math.abs()` and FP negation.
        * Fix soft-float `math.abs()` and negation.
        * x64/`LJ_GC64`: Fix warning for DUALNUM build.
        * x64/`LJ_GC64`: Fix (currently unused) integer stores in `asm_tvptr()`.
        * ARM64: Cleanup and de-cargo-cult TValue store generation.
        * MIPS: Don't use `RID_GP` as a scratch register.
        * MIPS: Fix emitted code for U32 to float conversion.
        * MIPS: Backport workaround for compact unwind tables.
        * Make `checkptrGC()` actually work.
        * ARM64: Fix AREF/HREF/UREF fusion.
        * `LJ_GC64`: Add build options and install instructions.
        * Add some more extensions from Lua 5.2/5.3.
        * Fix cross-endian jit.bcsave for MIPS target.
        * ARM64: Remove unused variables in disassembler.
        * ARM64: Fuse BOR/BXOR and BNOT into ORN/EON.
        * Add "proto" field to `jit.util.funcinfo()`.
        * Add missing FOLD rule for 64 bit shift+BAND simplification.
        * ARM64: Fix code generation for S19 offsets.
        * ARM64: Fuse various BAND/BSHL/BSHR/BSAR combinations.
        * ARM64: Fuse FP multiply-add/sub.
        * ARM64: Fuse XLOAD/XSTORE with STRREF/ADD/BSHL/CONV.
        * ARM64: Reorganize operand extension definitions.
        * ARM64: Add missing ldrb/strb instructions to disassembler.
        * ARM64: Fix pc-relative loads of consts. Cleanup branch codegen.
        * ARM64: Make use of tbz/tbnz and cbz/cbnz.
        * Eliminate use of lightuserdata derived from static data pointers.
        * ARM64: Emit more efficient trace exits.
        * Generalize deferred constant handling in backend to 64 bit.
        * ARM64: Reject special case in `emit_isk13()`.
        * ARM64: Allow full VA range for mcode allocation.
        * ARM64: Add JIT compiler backend.
        * Fix amalgamated build.
        * Increase range of `GG_State` loads via `IR_FLOAD` with `REF_NIL`.
        * MIPS: Fix TSETR barrier.
        * Report parent of stitched trace.

# Version 1.11.2.2 - 17 November 2016

* feature: added new command-line utility, [opm](https://github.com/openresty/opm#readme) of version 0.02, for managing community contributed [OpenResty packages](https://opm.openresty.org/).
* change: now we enable `-DLUAJIT_ENABLE_LUA52COMPAT` in our bundled LuaJIT build by default, which can be disabled by `./configure --without-luajit-lua52`.
note that this change may introduce some minor backeward incompatibilities on the Lua land, see http://luajit.org/extensions.html#lua52 for more details.
* win32: upgraded OpenSSL to 1.0.2j.
* win32: enabled http v2, http addition, http gzip static, http sub, and several other standard [nginx](nginx.html) modules by default.
* updated the help text of `./configure --help` to sync with the new [nginx](nginx.html) 1.11.2 core.
* `make install`: now we also create directories `<prefix>/site/pod/` and `<prefix>/site/manifest/`.
* doc: updated [README-win32.md](https://github.com/openresty/openresty/blob/master/doc/README-win32.md#readme) to reflect recent changes.
* added new component, [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme), which is enabled by default and can be explicitly
disabled via the `--without-lua_resty_limit_traffic` option of the `./configure` script during build.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.7.
    * feature: added a new API function `tcpsock:settimeouts(connect_timeout, send_timeout, read_timeout)`. thanks Dejiang Zhu for the patch.
    * feature: added public C API for 3rd-party [NGINX](nginx.html) C modules to register their own shm-based data structures for the Lua land usage
      (that is, to create custom siblings to [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict)). thanks helloyi and Dejiang Zhu for the patches.
    * feature, bugfix: added new config directive `lua_malloc_trim N` to periodically call `malloc_trim(1)` every `N` requests when `malloc_trim()` is available.
      by default, `lua_malloc_trim 1000` is configured. this should fix the glibc oddity of holding too much freed memory
      when it fails to use `brk()` to allocate memory in the data segment. thanks Shuxin Yang for the proposal.
    * bugfix: segmentation faults might happen when [ngx.exec()](https://github.com/openresty/lua-nginx-module#ngxexec) was fed with unsafe URIs. thanks Jayce LiuChuan for the patch.
    * bugfix: [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header): skips setting multi-value headers for bad requests to avoid segfaults. thanks Emil Stolarsky for the patch.
    * change: [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) are now only allowed in the `http {}` context.
      use of these session hooks in the `server {}` scope did not make much sense since server name dispatch happens
      *after* ssl session resumption anyway. thanks Dejiang Zhu for the patch.
    * optimize: optimized the [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict) node struct memory layout which can save 8 bytes for every key-value pair on 64-bit systems, for example.
    * doc: log level constants are also available in [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) and [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) contexts. thanks kraml for the report and detailyang for the patch.
    * doc: documented the support of 307 status argument value in [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect).
    * doc: use `*_by_lua_block {}` in all the configuration examples. thanks pj.vegan for the patch.
    * doc: documented how to easily test the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) locally with a modern web browser.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.9.
    * feature: implemented the [split()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#split) method in the [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme) module.
    * optimize: [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme): removed one unused top-level Lua variable.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.32.
    * bugfix: [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers): skips setting multi-value headers for bad requests to avoid segfaults.
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.26.
    * optimize: hmset: use `select` to avoid creating temporary Lua tables and
      to be more friendly to LuaJIT's JIT compiler. thanks spacewander for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.18.
    * optimize: removed unused local Lua variables. thanks Thijs Schreijer for the patch.
    * change: stops seeding the random generator. This is user's responsibility now. thanks Thijs Schreijer for the patch.
* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.17.
    * bugfix: fixed the Lua exception "attempt to perform arithmetic on local len (a boolean value)". thanks Dmitry Kuzmin for the report.
    * doc: renamed the "errno" return value to "errcode" for consistency. thanks Soojin Nam for the patch.
* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket#readme) to 0.06.
    * optimize: minor code optimizations and cleanups from Aapo Talvensaari.
    * doc: fixed copy&paste mistakes found by rock59.
* upgraded [lua-resty-upload](https://github.com/openresty/lua-resty-upload#readme) to 0.10.
    * feature: the `new()` method now accepts an optional 2nd arg to configure the max line size.
    * optimize: use the `$http_content_type` [nginx](nginx.html) built-in variable instead of
      `ngx.req.get_headers()["content-type"]`. thanks Soojin Nam for the patch.
    * optimize: minor optimization from Will Bond.
    * optimize: various minor optimizations and cleanups from Soojin Nam, Will Bond, Aapo Talvensaari, and hamza.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.16.
    * feature: resty: forwarded more UNIX signals. thanks Zekai.Zheng for the patch.
    * feature: restydoc: added new option `-r DIR` for specifying a custom root directory.
    * feature: restydoc: added support for comment syntax, `# ...`, in the `resty.index` file.
    * bugfix: resty: literal single quotes led to [nginx](nginx.html) configuration errors in -e option values. thanks spacewander for the report.
    * bugfix: restydoc-index: we did not ignore POD files in the output directory if they are also inside the input directory.
    * bugfix: restydoc-index: we should only ignore `pod` directories in the output directory, not the whole output directory.
    * bugfix: restydoc-index: we swallowed the section name right after the `Table of Contents` section (if any).
* upgraded LuaJIT to v2.1-20161104: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * LJ_GC64: Fix HREF for pointers.
        * LJ_FR2: Fix slot 1 handling.
        * Fix GC step size calculation.
        * LJ_GC64: Fix `jit.on/off`.
        * Fix `-jp=a` mode for builtins.
        * ARM: Fix BLX encoding for Thumb interworking calls.
        * Initialize uv->immutable for upvalues of loaded chunks.
        * Windows/x86: Add MSVC flags for debug build with exception interop.
        * Fix exit status for `luajit -b`.
        * Must preserve `J->fold.ins` (fins) around call to `lj_ir_ksimd()`.
        * Emit bytecode in .c/.h files with unsigned char type.
        * Set arg table before evaluating `LUA_INIT` and `-e` chunks.
        * Fix for cdata vs. non-cdata arithmetics/comparisons.
        * Fix unused vars etc. in internal Lua files.
        * Properly clean up state before restart of trace assembly.
        * Drop leftover regs in 'for' iterator assignment, too.
        * MIPS: Support MIPS16 interlinking.
        * x64/LJ_GC64: Fix code generation for IR_KNULL call argument.
        * Fix PHI remarking in SINK pass.
        * LJ_GC64: Set correct nil value when clearing a cdata finalizer.
        * LJ_GC64: Ensure all IR slot fields are initialized.
        * LJ_GC64: Allow optional use of the system memory allocator.
        * Fix Valgrind suppressions.
        * Don't try to record outermost `pcall()` return to lower frame.
        * MIPS: Fix build failures and warnings.
        * Proper fix for LJ_GC64 changes to `asm_href()`.
        * MIPS64, part 1: Add MIPS64 support to interpreter.
        * DynASM/MIPS: Add missing MIPS64 instructions.
        * x64/LJ_GC64: Fix `__call` metamethod for tailcall.
        * Fix collateral damage from LJ_GC64 changes to asm_href().
        * Use MAP_TRYFIXED for the probing memory allocator, if available.
        * x86: Don't spill an explicit REF_BASE in the IR.
        * x64/LJ_GC64: Add missing backend support and enable JIT compilation.
        * LJ_FR2: Add support for trace recording and snapshots.
        * Embed 64 bit constants directly in the IR, using two slots.
        * Simplify GCtrace * reference embedding for trace stitching.
        * Make the IR immovable after assembly.
        * Add guard for obscure aliasing between open upvalues and SSA slots.
        * Workaround for MinGW headers lacking some exception definitions.
        * Remove assumption that lj_math_random_step() doesn't clobber FPRs.

#  Version 1.11.2.1 - 24 August 2016

* upgraded the [Nginx](nginx.html) core to 1.11.2.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: bundled the sess_set_get_cb_yield patch for OpenSSL to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) directives of [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* win32: we now use pcre 8.39 and openssl 1.0.2h in our official build.
* feature: applied the `ssl_pending_session.patch` to the [nginx](nginx.html) core to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* feature: added `<openresty-prefix>/site/lualib/` to the default Lua module search paths used by OpenResty. This location is for 3rd-party Lua modules so that the users will not pollute the `<openresty-prefix>/lualib/` directory with non-standard Lua module files.
* feature: now we create the `<openresty-prefix>/bin/openresty` symlink which points to `<openresty-prefix>/nginx/sbin/nginx` to avoid polluting the `PATH` environment with the name "nginx".
* feature: added the `upstream_timeout_fields` patch to the [nginx](nginx.html) core to allow efficient per-request connect/send/read timeout settings for individual upstream requests and retries.
* feature: added the official LuaJIT documentation from LuaJIT 2.1 to our `restydoc` indexes.
* feature: added the Lua 5.1 reference manual from lua 5.1.5 to our restydoc indexes.
* bugfix: special characters like spaces in [nginx](nginx.html) configure option values (like `--with-pcre-opt` and `--with-openssl-opt`)  were not passed correctly. thanks Andreas Lubbe for the report.
* change: now we use our own version of default `index.html` and `50x.html` pages.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.6.
    * feature: added new shdict methods: [lpush](https://github.com/openresty/lua-nginx-module#ngxshareddictlpush),
[lpop](https://github.com/openresty/lua-nginx-module#ngxshareddictlpop),
[rpush](https://github.com/openresty/lua-nginx-module#ngxshareddictrpush),
[rpop](https://github.com/openresty/lua-nginx-module#ngxshareddictrpop),
[llen](https://github.com/openresty/lua-nginx-module#ngxshareddictllen)
for manipulating list-typed values. these methods can
be used in the same way as the redis commands of the same names. Essentially we now have shared memory based queues now. each queue is indexed by a key. thanks
Dejiang Zhu for the patch.
    * feature: implemented [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) configuration directives for doing (distributed) caching of SSL sessions (via SSL session IDs) for downstream connections. thanks Zi Lin for the patches.
    * feature: added pure C API for setting upstream request connect/send/read timeouts in [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) on a per session basis. thanks Jianhao Dai for the original patch.
    * feature: ssl: add [FFI](http://luajit.org/ext_ffi.html) functions to parse certs and private keys to cdata. With the current [FFI](http://luajit.org/ext_ffi.html) functions the certificate chain and the private key are parsed from DER every time they are set into the SSL state. Now we can cache the parsed certs and private keys as cdata objects directly. These new functions make it possible to avoid the DER -> OpenSSL parsing. Thanks Alessandro Ghedini for the patch.
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: allow [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) to receive nil args. thanks Thibault Charbonnier for the patch.
    * bugfix: `*_by_lua_file`: did not support absolute file paths on non-UNIX systems like Win32. thanks Someguynamedpie for the report and the original patch.
    * bugfix: fake connections did not carry a proper connection number. thanks Piotr Sikora for the patch.
    * bugfix: "lua_check_client_abort on" broke HTTP/2 requests.
    * bugfix: `ngx_http_lua_ffi_ssl_create_ocsp_request`: we did not clear the openssl stack errors in the right place.
    * bugfix: [ngx.sha1_bin()](https://github.com/openresty/lua-nginx-module#ngxsha1_bin) was always disabled with [nginx](nginx.html) 1.11.2+ due to incompatible changes in [nginx](nginx.html) 1.11.2+. thanks manwe for the report.
    * bugfix: segfaults might happen when calling [ngx.log()](https://github.com/openresty/lua-nginx-module#ngxlog) in [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) and [error_log](http://nginx.org/r/error_log) was configured with syslog. thanks Jonathan Serafini and Greg Karékinian for the report.
    * bugfix: fixed a typo in the error handling of the `SSL_get_ex_new_index()` call for our ssl ctx index. thanks Jie Chen for the report.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header) and [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module#ngxreqclear_header) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed crashes in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) for HTTP/2 requests. now we always throw out a Lua exception in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) when being called in HTTP/2 requests.
    * bugfix: specifying the C macro `NGX_LUA_NO_FFI_API` broke the build. thanks jsopenrb for the report.
    * doc: [ngx.worker.count()](https://github.com/openresty/lua-nginx-module#ngxworkercount) is available in the [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) context.
    * doc: documented that [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) does not work in HTTP/2 requests.
    * doc: typo fixes from Otto Kekäläinen and Nick Galbreath.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.8.
    * updated the `resty.core.shdict` Lua module to reflect the recent addition of list-typed shdict values in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: added the [ngx.ssl.session](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl/session.md#readme) module for the contexts [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block). thanks Zi Lin for the patches.
    * feature: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme): added new API functions [set_timeouts()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#set_timeouts) for setting per-session connect/send/read timeouts for the current upstream request and subsequent retries. thanks Jianhao Dai for the patch.
    * feature: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): add new API functions [parse_pem_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_cert), [parse_pem_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_priv_key), [set_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_cert), and [set_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_priv_key). thanks Alessandro Ghedini for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.17.
    * feature: now we support parsing answer records in all the answer sections (`AN`, `NS`, and `AR`). thanks Zekai Zheng for the patch.
    * optimize: commented out 3 lines of useless Lua code in `parse_response()`.
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.25.
    * feature: now this module automatically generate Lua methods for *any* Redis commands the caller attempts to use.
The lazily generated Lua methods are cached in the Lua module table for faster subsequent uses.
In theory, any Redis commands in existing Redis or even future Redis servers can work out of the box. thanks spacewander for the patch.
* upgraded [ngx_lua_upstream](https://github.com/openresty/lua-upstream-nginx-module#readme) to 0.06.
    *  feature: added [upstream.current_upstream_name()](https://github.com/openresty/lua-upstream-nginx-module#current_upstream_name) to return the proxy target used in the current request. thanks Justin Li for the patch.
    * minor Lua table initialization optimizations from Scott Francis.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.13.
    * bugfix: restydoc: pod2man from older perl versions (like 5.8) does not support `-u` option. we should be smarter here.
    * bugfix: when resty/restydoc/restydoc-index were invoked through symlinks, they might fail to locate the [nginx](nginx.html) executable of openresty.
    * bugfix: POD errors might get displayed in pod2man with older versions of perl (like perl 5.20.2). thanks Dominic for the patch.
    * bugfix: pod2man might abort with a "Can't open file" error with perl 5.24+.
    * bugfix: restydoc-index: improved the seciton name normalization for the documentation indexes.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.60.
    * bugfix: fixed compilation failures when specifying the C compiler option `-DDDEBUG=2`. thanks amdei for the report.
    * bugfix: fixed crashes in `$echo_client_request_headers` for HTTP/2 requests. thanks dilyanpalauzov for the report.
Now $echo_client_request_headers always evaluates to an empty value (not found) in HTTP/2 requests.
    * doc: make it clearer when to use the `--` form.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.31.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed a typo in an error message. thanks Albert Strasheim for the patch.
* upgraded [ngx_set_misc](https://github.com/openresty/set-misc-nginx-module#readme) to 0.31.
    * bugfix: the [set_sha1](https://github.com/openresty/set-misc-nginx-module#set_sha1) directive is always disabled when working with [nginx](nginx.html) 1.11.2+ due to recent changes in the new [nginx](nginx.html) cores.
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.06.
    * doc: we do require [ngx_http_ssl_module](http://nginx.org/en/docs/http/ngx_http_ssl_module.html) to work properly.

See [ChangeLog 1.9.15](changelog-1009015.html) for change log for [OpenResty](openresty.html) 1.9.15.x.
