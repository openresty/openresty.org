<!---
    @title         ChangeLog for 1.19.3.x
    @creator       Johnny Wang
    @created       2020-10-30 09:36 GMT
--->

# Version 1.19.3.1 - 30 Oct 2020

* upgraded the nginx core to 1.19.3.
    * see the changes here: https://nginx.org/en/CHANGES

* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.18.
    * bugfix: `ngx.resp.set_headers()`: may cause an error when Content-Length field is larger than 2^32. _Thanks Johnny Wang for the patch._
    * bugfix: process may crash when a timer run failed and a function with arguments run inside this timer. _Thanks lijunlong for the patch._
    * bugfix: wrong pipelined request body length when request body is parent's request body. _Thanks lijunlong for the patch._
    * bugfix: ngx.flush never blocks on http v2. _Thanks lijunlong for the patch._
    * feature: implemented the new `tcpsock:setoption()` function for setting options for the TCP socket. _Thanks poorsea for the patch._
    * bugfix: `ngx.resp.get_headers()`: may return a wrong (like: negative) value of the Content-Length field when it is larger than 2^32. _Thanks LubinLew for the patch._
    * optimize: added the "ev" to `ngx_posted_delayed_events` instead of the rbtree for 0 delay timer, so that we can save an epoll wait in such case. _Thanks syz for the patch._
    * feature: implemented the new `ngx.ssl.server_port()` API to get server port. _Thanks Yan Zhu for the patch._
    * bugfix: build error with nginx 1.7.4 or older version. _Thanks timebug for the patch._
    * optimize: now we make use of the new `lua_getexdata2` and `lua_setexdata2` to attach coctx to the Lua thread objects directly which save the lookup overhead which can become the bottleneck when there are many Lua light threads around in a single request handler.
    * feature: now we recycle lua thread GC objects for our "light threads" and added `lua_thread_cache_max_entries` directive to configure the cache size.
    * feature: added new C API `ngx_http_lua_pcre_version` to wrap the `pcre_version()` C API in libpcre.
    * bugfix: double values larger than `int32_t` were incorrectly printed out as 64-bit integers. _Thanks lijunlong for the patch._
    * bugfix: the format in argerror messages are incorrect. _Thanks Alexander Drozdov for the patch._
    * feature: shared `ngx.ctx` among SSL_* phases and the following phases. _Thanks spacewander for the patch._
    * feature(socket.tcp): enhance the logic of parameter verification in connect. _Thanks Jinhua Tan for the patch._
    * bugfix: the body size may overflow since the size_t is only int32 in 32-bit system. _Thanks syz for the patch._
    * feature: added the `ngx_http_lua_ffi_balancer_recreate_request` FFI function to allow recreation of request buffer in balancer phase. _Thanks Datong Sun for the patch._
    * feature: add FFI interface to verify SSL client certificate. _Thanks ArchangelSDY for the patch._
    * feature: added `exit_worker_by*` to run Lua code upon nginx worker process exit. _Thanks letian & Jinhua Tan for the patch._
    * optimize: avoided use of `lua_tolstring` in `ngx_http_lua_calc_strlen_in_table`, `ngx_http_lua_copy_str_in_table`, `ngx_http_lua_socket_udp_send`, `log_wrapper` and `ngx_http_lua_ngx_echo`. _Thanks lijunlong for the patch._
    * feature: supported receiveany on `ngx.req.socket(true?)` socks. _Thanks Guy Lewin for the patch._

* upgraded [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) to 0.0.9.
    * bugfix: process may crash when a timer run failed and a function with arguments run inside this timer. _Thanks lijunlong for the patch._
    * feature: added the receiveany function for raw req socket. _Thanks tangsty for the patch._
    * feature: implemented the new `ngx.ssl.server_port()` API to get server port. _Thanks Yan Zhu for the patch._
    * feature: added new C API `ngx_stream_lua_pcre_version` to wrap the `pcre_version()` C API in libpcre.
    * feature: shared `ngx.ctx` among SSL_* phases and the following phases. _Thanks spacewander for the patch._
    * bugfix: the stream subsystem was built incorrectly in debug mode. _Thanks spacewander for the patch._
    * bugfix: hide get_request API in stream subsystem. _Thanks spacewander for the patch._
    * feature: add FFI interface to verify SSL client certificate. _Thanks ArchangelSDY for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to v0.1.20.
    * bugfix: invalid write in `ffi.copy` since we missed the len argument, it is caught by the valgrind mode in ec2 testing. _Thanks lijunlong for the patch._
    * feature: implemented the new `tcpsock:setoption()` function for setting options for the TCP socket. _Thanks poorsea for the patch._
    * feature: implemented the new `ngx.ssl.server_port()` API to get server port. _Thanks Yan Zhu for the patch._
    * change: now we require `ngx_http_lua` 0.10.18 and `ngx_stream_lua` 0.0.9.
    * bugfix: `resty.core.regex` would fail to load silently on Windows. now we use `ngx_http_lua` or `ngx_stream_lua` modules' pcre version API wrapper to avoid such symbol exporting pains.
    * feature: shared `ngx.ctx` among SSL_* phases and the following phases. _Thanks spacewander for the patch._
    * bugfix: added the missing 'ngx.req.start_time' to the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: add the `balancer.recreate_request` function, which allows user to recreate request buffer in balancer phase. _Thanks Datong Sun for the patch._
    * feature: implemented the new `ssl.verify_client()` API to require a client certificate during TLS handshake. _Thanks ArchangelSDY for the patch._
    * feature: add `exit_worker` as new phase. _Thanks letian & Jinhua Tan for the patch._

* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.23.
    * feature: support sha256 plugin to auth. _Thanks Jinhua Tan for the patch._
    * feature: add connection backlog support. _Thanks syz for the patch._

* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket#readme) to 0.08.
    * optimization: using cdata instead lua table for generating masked payload. _Thanks Gerrard-YNWA for the patch._
    * feature: support adding custom headers during handshake. _Thanks Guilherme Salazar for the patch._

* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.29.
    * bugfix: reimplement unsubscribe mechanism. _Thanks spacewander for the patch._
    * bugfix: lack close() when receive timeout. _Thanks stone-wind for the patch._
    * bugfix: connect to unix socket without opts table. _Thanks Andreas Fischer for the patch._

* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.27.
    * bugfix: `--no-stream` did not really work. this is a followup fix for the previous commit.
    * feature: resty: added new CLI option `--no-stream` to disable `stream {}` config in auto-generated nginx.conf.
    * change: resty: we no longer support arg[N] where N < 0.
    * bugfix: resty: the tmp directory has not been deleted. _Thanks Johnny for the patch._
    * feature: resty: now we cache the original `ngx.say`/`ngx.print` functions into `ngx.orig_say` and `ngx.orig_print` since some times the user would need them.

* upgraded [LuaJIT](https://github.com/openresty/luajit2) to 2.1-20201008.
    * Detect SSE4.2 support dynamically.
    * feature: added new Lua API functions `thread.exdata2` as well as C API funcs `lua_getexdata2` and `lua_setexdata2`.
    * feature: added new LuaJIT C API `lua_resetthread`.
    * Patch for PPC64 support.
    * imported Mike Pall's latest changes:
        * Fix snapshot PC when linking to BC_JLOOP that was a BC_RET*.
        * Ensure full init of IR_NOP instructions.
        * Another fix for `lua_yield()` from C hook.
        * Mark CONV as non-weak, to prevent elimination of its side-effect.
        * Fix `lua_yield()` from C hook.
        * DynASM/x86: Fix VREG support.
        * Limit path length passed to C library loader.
        * LJ_GC64: Always snapshot functions for non-base frames.
        * Call error function on rethrow after trace exit.
        * Fix handling of errors during snapshot restore.
        * ARM: Ensure relative GG_State element alignment differently.
        * Fix Makefile dependencies.
        * Handle old OSX/iOS without `getentropy()`.
        * Add FAQ about sandboxing. Minor fixes.
        * Fix frame traversal for __gc handler frames.
        * Fix Clang build.
        * Android/ARM: Fix build with recent NDK.
        * Fix compiler warning.
        * Fix OSX build.
        * Follow-up fix for iOS build.
        * OSX/iOS: Handle iOS simulator and ARM64 Macs.
        * Fix pointer check for non-GC64 mode.
        * Windows: Fix NtAllocateVirtualMemory prototype.
        * Add `jit.security()`.
        * Redesign and harden string interning.
        * Use a securely seeded global PRNG for the VM.
        * Cleanup some arch defines and fix builds.
        * ARM: Implement FLOAD from GG_State.
        * Improve assertions.
        * Fix `debug.debug()` for non-string errors.
        * Optimize table length computation with hinting.
        * Remove `pow()` splitting and cleanup backends.
        * Cleanup math function compilation and fix inconsistencies.
        * Fix bytecode register allocation for comparisons.
        * Don't compile `math.modf()` anymore.
        * Fix `math.min()`/`math.max()` inconsistencies.
        * Fix narrowing of unary minus.
        * Cleanup CPU detection and tuning for old CPUs.
        * ARM64: Fix {AHUV}LOAD specialized to nil/false/true.
        * ARM, ARM64, PPC: Fix TSETR fallback.
        * Remove unused file.
        * FFI: Always fall back to metamethods for cdata length/concat.
        * Windows: Make actual use of internal allocator optimization.
        * Fix overflow check in `unpack()`.
        * Fix Windows make clean.
        * FFI/ARM64: Fix pass-by-value struct calling conventions.
        * Fix write barrier for `lua_setupvalue()` and `debug.setupvalue()`.
        * Make string to number conversions fail on NUL char.
        * x86/x64: Fix loop realignment.
        * Fix POSIX install with missing or incompatible ldconfig.
        * Fix C file generation in `jit.bcsave`.
        * Bump copyright date.
        * Remove support for de-facto dead archs.
        * DynASM/x86: Fix BMI instructions.
        * Minor fixes.
        * MIPS: Add MIPS64 R6 port.
        * Fix `string.char()` recording with no arguments.
        * Followup fix for embedded bytecode loader.
        * Fix embedded bytecode loader.
