<!---
    @title         ChangeLog for 1.21.4.x
    @creator       Johnny Wang
    @created       2022-05-13 06:49 GMT
--->

# Version 1.21.4.4 - 19 Jul 2024

* upgraded [LuaJIT](https://github.com/openresty/luajit2) to v2.1-20230410.1.
    * bugfix: disable hash computation optimization because of the possibility of severe degradation (CVE-2024-39702). _Thanks lijunlong for the patch._

# Version 1.21.4.3 - 7 Nov 2023

* bugfix: applied the patch for security advisory to NGINX cores. (CVE-2023-44487).

# Version 1.21.4.2 - 19 Jul 2023

* win32/win64: upgraded zlib to 1.2.13.
* win32/win64: upgraded OpenSSL to 1.1.1t.

* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to v0.10.25
    * bugfix: used after free when encountering invalid http IF-Match header. _Thanks lijunlong for the patch._
    * bugfix: ssl_client_hello_by_lua generating chunk cache key and chunk name. _Thanks willmafh for the patch._
    * bugfix: cosocket did not exit when `worker_shutdown_timeout` handler is called. _Thanks lijunlong for the patch._
    * feature: implement HTTP 3.0 support for `ngx.req.http_version()`. _Thanks Yu.Zhu for the patch._
    * bugfix: fix receiveuntil rest bytes count. _Thanks ZongRun for the patch._
    * bugfix: add a timed recycling child process as a last resort. _Thanks lijunlong for the patch._
    * feature: add new FFI API `ngx_http_lua_ffi_msec`. _Thanks lijunlong for the patch._
    * bugfix: did not wakeup coroutine when worker thread finished. _Thanks kingluo for the patch._
    * feature: add `ngx_http_lua_ffi_worker_pids` to get all workers pid map. _Thanks attenuation for the patch._
    * bugfix: `run_worker_thread` arg is self-reference. _Thanks fesily for the patch._
    * feature: introduced new API `tcpsock:bind()`. _Thanks lijunlong for the patch._
    * feature: add `shdict` APIs into worker thread. _Thanks jinhua luo for the patch._
    * bugfix: set flags for Darwin arm64. _Thanks lijunlong for the patch._
    * bugfix: improved handling of multiple headers changed in nginx 1.23.0. _Thanks Hiroaki Nakamura for the patch._
    * change: increased the maximum size to 65536 for the udp datagram. _Thanks lijunlong for the patch._
    * optimize: destroy pipe proc when freeing the request. _Thanks lijunlong for the patch._
    * optimize: add error log when closing the pipe failed. _Thanks lijunlong for the patch._
    * bugfix: fix potential null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * optimize: fixed dead code found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * feature: in `content_by_lua_file`, return 503 for file read error. _Thanks jizhuozhi for the patch._
    * bugfix: Apple Silicon FFI ABI limitation workaround. _Thanks Chrono for the patch._
    * bugfix: failed to compile when nginx https is disabled. _Thanks lijunlong for the patch._
    * feature: add `server_rewrite_by_lua*`. _Thanks xiaobiaozhao for the patch._
    * cosocket: add function `tcpsock:setclientcert`, reimplemented `tcpsock:sslhandshake` with FFI. _Thanks Datong Sun for the patch._
    * optimize: use `ngx_hash_t` to optimize the built-in header look-up process for `ngx.header.HEADER`. _Thanks lijunlong for the patch._
    * feature: add FFI implementation for `ngx.arg` getter. _Thanks 罗泽轩 for the patch._
    * bugfix: fixed size of the array when initialized in the `init_worker_by*` phase. _Thanks Jiahao Wang for the patch._
    * bugfix: ambiguous error message 'connection in dubious state' when connection is closed. _Thanks lijunlong for the patch._
    * bugfix: passing the wrong chunkname argument to `luaL_loadbuffer`. _Thanks lijunlong for the patch._
    * optimize: change lua chunkname to config filename and line number for `{init,header_filter,body_filter}_by_lua_block` and so on. _Thanks lijunlong for the patch._
    * change: the error message should use the first line rather than the last line of the code block when loading lua code block fails. _Thanks lijunlong for the patch._
    * bugfix: segment fault when get header via `ngx.req.raw_header` with malformed requests. _Thanks Gordon McKinney for the patch._
    * change: remove useless code for get old_cpath. _Thanks Tinglong Yang for the patch._
    * bugfix: `ngx.run_worker_thread` injected API into the wrong table. _Thanks jinhua luo for the patch._
    * feature: add API to fetch raw nginx SSL pointer of the downstream request. _Thanks James Callahan for the patch._
    * feature: SSL/TLS: support for passphrase protected key. _Thanks lijunlong for the patch._
    * feature: expose the 'Last-Modified' response header as `ngx.header["Last-Modified"]`. _Thanks lijunlong for the patch._
    * bugfix: posted event handler was called after event memory was freed. _Thanks lijunlong for the patch._
    * optimize: don't calculate hash when clearing the request header. _Thanks spacewander for the patch._
    * feature: check the number of parameters for `ngx.thread.wait`. _Thanks tan jinhua for the patch._
    * change: use `nil` instead of `false` when `lpush` & `rpush` overflow. _Thanks yang.yang for the patch._
    * feature: prevent calling `ngx.exit()` with invalid values. _Thanks Thibault Charbonnier for the patch._
    * feature: added FFI-based function `ngx_http_lua_ffi_req_is_internal`. _Thanks chronolaw for the patch._
    * feature: added http const `HTTP_NOT_IMPLEMENTED`. _Thanks Landon Manning for the patch._

* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) to v0.0.12
    * feature: introduced new API `ngx_stream_lua_ffi_monotonic_msec`. _Thanks lijunlong for the patch._
    * feature: add `CONTEXT_YIELDABLE` constant to stream subsys. _Thanks 罗泽轩 for the patch._
    * bugfix: wrong size for the pending timers. _Thanks lijunlong for the patch._
    * feature: add `ngx_stream_lua_ffi_worker_pids` to get all workers pid map. _Thanks attenuation for the patch._
    * bugfix: Apple Silicon FFI ABI limitation workaround. _Thanks Chrono for the patch._
    * feature: SSL/TLS supports passphrase protected private key. _Thanks lijunlong for the patch._
    * bugfix: posted event handler was called after event memory was freed. _Thanks lijunlong for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.27
    * optimize: avoid NYI in the `get_string_buf` function. _Thanks Jiahao Wang for the patch._
    * feature: implemented `monotonic_msec()` and `monotonic_time()` in `resty.core.time`. _Thanks lijunlong for the patch._
    * bugfix: get `ngx_lua_version` before 'not ngx.config'. _Thanks willmafh for the patch._
    * feature: add `ngx.worker.pids` to get all workers pid map. _Thanks attenuation for the patch._
    * optimize: destroy pipe when freeing request. _Thanks lijunlong for the patch._
    * optimize: localize `pcall` function in `base.lua` to improve performance. _Thanks Chrono for the patch._
    * feature: implemented `get_supported_versions()` in `clienthello` phase. _Thanks Attenuation for the patch._
    * bugfix: Apple Silicon FFI ABI limitation workaround. _Thanks Chrono for the patch._
    * bugfix: did not get the correct error message for when require module. _Thanks lijunlong for the patch._
    * feature: added support for `ssl_server_rewrite_by_lua`. _Thanks lijunlong for the patch._
    * cosocket: add function `tcpsock:setclientcert`, reimplemented `tcpsock:sslhandshake` with FFI. _Thanks Datong Sun for the patch._
    * feature: provide a way to reuse table in `ngx.req.get_uri_args`. _Thanks 罗泽轩 for the patch._
    * feature: add FFI implementation for `ngx.arg` getter. _Thanks 罗泽轩 for the patch._
    * optimize: localize `bit.bor` in `clienthello.lua` to improve performance. _Thanks Chrono for the patch._
    * optimize: reimplemented the coroutine wrapper using the FFI API. _Thanks lijunlong for the patch._
    * feature: support passphrase protected private key. _Thanks lijunlong for the patch._
    * feature: reimplemented `ngx.req.is_internal` with LuaJIT FFI. _Thanks chronolaw for the patch._
    * optimize: removed the extra return. _Thanks lijunlong for the patch._

* upgraded [luajit2](https://github.com/openresty/luajit2) to v2.1-20230119
    * Avoid negation of signed integers in C that may hold INT*_MIN.
    * Correct fix for stack check when recording BC_VARG.
    * Disable FMA by default. Use -Ofma or jit.opt.start("+fma") to enable.
    * FFI: Fix dangling reference to CType. Improve checks.
    * ARM64: Fix code generation for IR_SLOAD with typecheck + conversion.
    * Avoid assertion in case of stack overflow from stitched trace.
    * Ensure correct stack top for OOM error message.
    * ARM64: Fix IR_SLOAD assembly.
    * Fix trace join to BC_JLOOP originating from BC_ITERN.
    * bugfix: fix `math.floor()` and `math.ceil()`. _Thanks Aditya Bisht for the patch._
    * Add -F option to override filename in jit.bcsave (luajit -b).
    * Patch luajit.pc with INSTALL_INC, if customized.
    * LJ_GC64: Fix `lua_concat()`.
    * Prevent use of RTLD_DEFAULT when NO_RTLD_DEFAULT is defined.
    * Improve GC estimation for userdata with attached managed memory.
    * Add missing GC steps to string buffer methods.
    * x86/x64: Limit VLOAD fusion to simple cases.
    * OSX/iOS/ARM64: Fix generation of Mach-O object files.
    * Prevent trace start at BC_ITERL after compiled BC_ITERN.
    * ARM64: Allow building with unwinding disabled.
    * FFI: Fix sizeof expression in C parser for reference types.
    * FFI: Fix ffi.alignof() for reference types.
    * FFI: Allow ffi.metatype() for typedefs with attributes.
    * OSX/iOS/ARM64: Fix bytecode embedding in Mach-O object file.
    * LJ_GC64: Fix IR_VARG offset for fixed number of results.
    * x86/x64: Fix math.ceil(-0.9) result sign.
    * Make embedded bytecode readable and forward-compatible.
    * Update console build instructions.
    * Avoid zero-sized arrays in jit_State.
    * Don't use jit_State during build with JIT disabled.
    * DynASM/ARM64: Fix LSL/BFI* encoding with variable registers.
    * Fix ITERN loop detection when hook checks are enabled.
    * Prevent C compiler undefined-behavior optimization.
    * Fix alias analysis for table length forwarding.
    * Fix loop initialization in table.foreach().
    * LJ_GC64: Fix HREFK optimization.
    * Fix recording of __concat metamethod.
    * Cleanup of system and architecture support docs.

* upgraded [resty-cli](https://github.com/openresty/resty-cli) to v0.29
    * change: save the original `ngx.exit` to `ngx.orig_exit`. _Thanks lijunlong for the patch._

* upgraded [lua-cjson](https://github.com/openresty/lua-cjson) to 2.1.0.11
    * bugfix: empty_array can not work on Apple because cjson did not compare light userdata address with masked address. _Thanks Datong Sun for the patch._
    * bugfix: windows luarocks doesn't export `cjson.safe`. _Thanks momoterraw for the patch._

* upgraded [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module) to v0.34
    * bugfix: nginx crash when accessing uninitialized pointer. _Thanks lijunlong for the patch._
    * bugfix: update handling of multiple headers changed in nginx 1.23.0. _Thanks Hiroaki Nakamura for the patch._
    * bugfix: fixed build error with nginx >= 1.23.0. _Thanks somni for the patch._

* upgraded [lua-resty-upstream-healthcheck](https://github.com/openresty/lua-resty-upstream-healthcheck) to v0.07
    * change: improved healthcheck status for prometheus. _Thanks Jonas Badstübner for the patch._
    * bugfix: `opts.host` has not been assigned to ctx. _Thanks yueziii for the patch._
    * feature: allowing check on different port. _Thanks Franck Lombardi for the patch._
    * feature: add HTTPS health check. _Thanks Yannic Rieger for the patch._
    * feature: add prometheus metrics format status. _Thanks Yannic Bastian Rieger for the patch._

* upgraded [opm](https://github.com/openresty/opm) to v0.0.7
    * change: web: show the package installation command in the package details page. _Thanks guisheng zhou for the patch._
    * bugfix: 'install_dir' should not be `/usr/local/openresty/site` but `/usr/local/openresty/bin`. _Thanks lijunlong for the patch._
    * feature: web: support github login and deferred deletion. _Thanks xlibor for the patch._

* upgraded [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit) to v0.3.2
    * change: fixed a typo in `ndk_upstream_list.c`. _Thanks lijunlong for the patch._

* upgraded [lua-resty-lock](https://github.com/openresty/lua-resty-lock) to v0.09
    * optimize: return setmetatable is NYI. _Thanks lijunlong for the patch._

* upgraded [srcache-nginx-module](https://github.com/openresty/srcache-nginx-module) to v0.33
    * bugfix: update handling of cache_control changed in nginx 1.23.0. _Thanks Hiroaki Nakamura for the patch._
    * change: add status code 307, 308 to the default value of `srcache_store_statuses`. _Thanks Jérémy Lal for the patch._

* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket) to v0.10
    * feature: add mtls client cert support. _Thanks Qi for the patch._
    * optimize: localize some `ngx.*` API to improve performance. _Thanks Chrono for the patch._
    * bugfix: default to port 443 for wss urls. _Thanks John Regan for the patch._

* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache) to v0.13
    * optimize: remove NYI call in lurcache. _Thanks lijunlong for the patch._

* upgraded [lua-resty-upload](https://github.com/openresty/lua-resty-upload) to v0.11
    * feature: add an option to preserve body. _Thanks Suika for the patch._

* upgraded [lua-resty-memcached](https://github.com/openresty/lua-resty-memcached) to v0.17
    * optimize: return `setmetatable` is NYI which can not be jit compiled. _Thanks lijunlong for the patch._
    * optimize: reuse the `cmd_tab` to minimize the gc. _Thanks lijunlong for the patch._
    * feature: implemented `{init,commit,cancel}_pipeline()`. _Thanks syz for the patch._
    * feature: add support for connecting over TLS. _Thanks Alessandro Ghedini for the patch._

* upgraded [echo-nginx-module](https://github.com/openresty/echo-nginx-module) to v0.63
    * optimize: fix potential null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * bugfix: fix potential null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * bugfix: fix minor issue found by Coverity in `src/ngx_http_echo_subrequest.c`. _Thanks Ilya Shipitsin for the patch._

* upgraded [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) to v0.1.12
    * bugfix: fix potential null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._

# Version 1.21.4.1 - 18 May 2022

* upgraded the [nginx](nginx.html) core to 1.21.4.
    * see the changes here: http://nginx.org/en/CHANGES

* win32/win64: upgraded zlib to 1.2.12.
* win32/win64: upgraded OpenSSL to 1.1.1n.
* feature: allow to be compiled with LibreSSL 3.0+.  _Thanks spacewander for the patch._
* feature: add [lua_ssl_conf_command](https://github.com/openresty/lua-nginx-module#lua_ssl_conf_command) directive for setting arbitrary OpenSSL configuration parameter particularly the TLSv1.3 ciphersuites. _Thanks Zhefeng Chen for the patch._
* feature: implemented the [ssl_client_hello_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_client_hello_by_lua) api for controlling the [NGINX](nginx.html) downstream SSL handshake dynamically with Lua. _Thanks Zhefeng Chen for the patch._
* feature: the number connections of privileged agent can be set by [enable_privileged_agent(connections)](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#enable_privileged_agent). _Thanks wangyao for the patch._
* feature: implemented the new [ngx.run_worker_thread](https://github.com/openresty/lua-nginx-module#ngxrun_worker_thread) API to run Lua function in a seperated worker thread. _Thanks kingluo for the patch._

* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to 0.10.21
    * bugfix: [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme) waits until timeout because child process forgot to close pipe after dup2. _Thanks Junlong Li for the patch._
    * bugfix: posted event handler was called after event memory was freed. _Thanks Junlong Li for the patch._
    * bugfix: prevent illegal memory access in ngx_http_lua_util.c. _Thanks Jiahao Wang for the patch._
    * optimize: removed superfluous code from shdict_store. _Thanks Odin Hultgren Van Der Horst for the patch._
    * bugfix: fix [nginx](nginx.html) crash caused by a bad format specifier. _Thanks balus for the patch._
    * bugfix: fixed memcpy param overlap detected by asan. _Thanks pengyanfeng for the patch._
    * bugfix: fix possible null pointer dereference found by Coverity. _Thanks doujiang24 for the patch._
    * bugfix: we should use luaL_typename() with lua stack index. _Thanks balus for the patch._
    * bugfix: fixed potential leak on memory allocation errors. we have to clean just created SSL context manually, thus appropriate call added. _Thanks nandsky for the patch._
    * bugfix: [nginx](nginx.html) crash when resolve an not exist domain in thread create by [ngx.thread.spawn](https://github.com/openresty/lua-nginx-module#ngxthreadspawn). _Thanks lijunlong for the patch._
    * bugfix: should reset the value_len to 0 when reuse the expired list type key in shared dict. _Thanks ngtee8 for the patch._
    * change: do not need to create the Lua request ctx data table from C. _Thanks doujiang for the patch._
    * bugfix: we should ignore match limit in DFA mode. _Thanks Jianyong Chen for the patch._
    * bugfix: buffer bloat and CPU 100% when download large file was filtered by body_filter_by_lua. _Thanks lijunlong for the patch._
    * bugfix: fixed missing 'const' qualifier causing compilation failure on freebsd. _Thanks Jiahao Wang for the patch._
    * bugfix: should not allow to create timer in the exit process phase.  _Thanks Jinhua Tan for the patch._
    * feature: support environ in [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme) on mac.  _Thanks tzssangglass for the patch._

* upgraded stream-lua-nginx-module to 0.0.11
    * bugfix: compilation failed when building without --with-stream_ssl_module. _Thanks vislee for the patch._
    * bugfix: we should use luaL_typename() with lua stack index. _Thanks Jianyong Chen for the patch._
    * bugfix: fixed possible null pointer dereference found by Coverity. _Thanks Ilya Shipitsin for the patch._
    * bugfix: [nginx](nginx.html) crash when resolve an not exist domain. _Thanks lijunlong for the patch._
    * bugfix: should reset the value_len to 0 when reuse the expired list type key in shared dict. _Thanks ngtee8 for the patch._
    * bugfix: we should ignore match limit in DFA mode. _Thanks balus for the patch._
    * bugfix: some lua configurations (i.e. `lua_ssl_trusted_certificate`) were missing in the init_worker phase. _Thanks doujiang for the patch._
    * bugfix: failed to start when non-ssl server configured with [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua*) directive.  _Thanks Zhefeng Chen for the patch._
    * bugfix: old coroutine APIs were used in the `preread` and `ssl_cert` phase.  _Thanks Zhefeng Chen for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.23
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme).sub/gsub may incorrectly dropped the last character. _Thanks Jianyong Chen for the patch._
    * optimize: use a new upvalue table for the ctxs holder to make [LuaJIT](https://github.com/openresty/luajit2#readme) JIT compiler happy to generate more efficient machine code. _Thanks doujiang for the patch._

* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket#readme) to 0.09
    * bugfix: should abort when status code is invalid in [wb:send_close(server)](https://github.com/openresty/lua-resty-websocket#send_close). _Thanks Gerrard-YNWA for the patch._

* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.30
    * feature: add a surface to support redis module. _Thanks spacewander for the patch._

* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme) to 0.08
    * optimize: [resty.limit.conn](https://github.com/openresty/lua-resty-limit-traffic/blob/master/lib/resty/limit/conn.md#readme) call dict:incr with `init_ttl` argument. _Thanks WindMGC for the patch._

* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.25
    * bugfix: fallback to default auth plugin if server doesn't have `CLIENT_PLUGIN_AUTH` capability. _Thanks Wangchong Zhou for the patch._

* upgraded [set-misc-nginx-module](https://github.com/openresty/set-misc-nginx-module) to 0.33
    * feature: added url safe base64 encoding/decoding. _Thanks Pavel for the patch._
    * bugfix: fix a possible resource leak of fd when exception occur. _Thanks Hai Shi for the patch._
    * feature: added new directive `set_hmac_sha256`. _Thanks erankor for the patch._

* upgraded [encrypted-session-nginx-module](https://github.com/openresty/encrypted-session-nginx-module) to 0.09
    * optimize: make it compatible with boringssl. _Thanks lijunlong for the patch._
* upgraded [lua-resty-string](https://github.com/openresty/lua-resty-string) to 0.15
    * feature: added an optional len parameter for resty.md5.update(). _Thanks lijunlong for the patch._
    * feature: add `enable_padding` option for aes. _Thanks beimingfish for the patch._
    * optimize: speed up `string.to_hex` by reusing hex buf. _Thanks jinjiezhao for the patch._

* upgraded [lua-cjson](https://github.com/openresty/lua-cjson#readme) to 2.1.0.10
    * bugfix: fixed bugs suspected by cppcheck: shift signed 32-bit value by 31 bits and uninitialized variable. _Thanks Jiahao Wang for the patch._
    * bugfix: fixed a possible division by zero bugs found by cppcheck. _Thanks Jiahao Wang for the patch._
    * feature: support lua 5.2+.

* upgraded luajit2 to 2.1-20220411
    * Add missing check for LJ_KEYINDEX in ITERN recording.
    * DynASM/ARM64: Fix NOP instruction for aligment.
    * Fix soft-float IR_POW splitting.
    * Fix BC_UCLO insertion for returns.
    * Fix string buffer COW handling.
    * Fix command-line argv handling.
    * Always exit after machine code page protection change fails.
    * Fix FOLD rule for BUFHDR append with intervening buffer use.
    * Fix compiled error handling for buffer methods.
    * FFI: Ensure library is loaded before de-serializing FFI types.
    * Fix HREFK forwarding vs. table.clear().
    * Fix FOLD rule for BUFHDR append.
    * Fix tonumber("-0") in dual-number mode.
    * Limit work done in SINK pass.
    * Fix ABC FOLD rule with constants.
    * Windows: Fix binary output of jit.bcsave to stdout.
    * Fix FOLD rule for x-0.
    * ARM64: Fix pcall() error case.
    * refactor: removed duplicated table entries. _Thanks lijunlong for the patch._
    * OSX/ARM64: Fix external unwinding.
    * Fix interaction of profiler and ITERN recording.
    * Fix compilation of multi-result call to next().
    * ARM64: Fix IR_HREF code generation.
    * MIPS64: Fix soft-float IR_TOSTR.
    * MIPS: Fix register allocation in assembly of HREF.
    * Windows/x64: Document MSVC flags for C++ exception interoperability.
    * [FFI](http://luajit.org/ext_ffi.html): Ensure returned string is alive in ffi.typeinfo().
    * bugfix: fixed merge error which was introduced by commit 63dee93f4e. _Thanks lijunlong for the patch._
    * OSX/ARM64: Disable unwind info.
    * Fix stack allocation after on-trace stack check.
    * Fix ITERN blacklisting.
    * Ensure ITERN forward progress on interpreter bailout.
    * ARM64: Reorder interpreter stack frame and fix unwinding.
    * Don't bail out to interpreter to JLOOP originating from ITERN.
    * [FFI](http://luajit.org/ext_ffi.html): Don't load PC from non-function object in [FFI](http://luajit.org/ext_ffi.html) continuation.
    * [FFI](http://luajit.org/ext_ffi.html): Fix missing cts->L initialization in argv2ctype().
    * OSX/ARM64: Disable external unwinding for now.
    * Compile table traversals: next(), pairs(), BC_ISNEXT/BC_ITERN. This work sponsored by OpenResty INC.
    * Use IR_HIOP for generalized two-register returns.
    * Refactor table traversal.
    * ARM: Fix symbol display in trace disassembly.
    * Refactor IR_TMPREF generation.
    * Refactor IR_VLOAD to take an offset.
    * MIPS: Fix trace linking.
    * feature: implemented string.buffer library.
    * Consider slots used by upvalues in use-def analysis.
    * Prevent loop in snap_usedef().
    * Fix io.close().
    * Fix minilua vararg stack handling.
    * Avoid out-of-range number of results when compiling select(k, ...).
    * Fix error message in lj_lib_checkintrange().
    * Fix IRXLOAD_* mode bits description.
    * Add IRCONV_NONE for pass-through INT to I64/U64 type change.
    * Fix jit.dump() output for IR_CONV.
    * Change: Resolve luaL_newstate() return NULL in ppc64le issue. _Thanks ManirajDeivendran for the patch._
    * Disable unreliable assertion for external frame unwinding.
    * Flush and close output file after profiling run.
    * Avoid conflict between 64 bit lightuserdata and ITERN key.
    * Change: Resolve compilation error in ppc _Thanks Maniraj Deivendran for the patch._
    * bugfix: disabled the assertion since it might be a false alarm on fedora aarch64.
    * feature: added the trace entry and normal exit events in the GC64 interpreter. _Thanks doujiang24 for the patch._
    * Throw any errors before stack changes in trace stitching.
    * DynASM/x86: Add missing escape in pattern.
    * DynASM/ARM64: Fix LSL/BFI* encoding with variable shifts.
    * Fix MinGW static build.
    * Fix dependencies.
    * Fix IR_BUFHDR assembly.
    * [FFI](http://luajit.org/ext_ffi.html): Support [FFI](http://luajit.org/ext_ffi.html) numbers in string.format() and buf:putf().
    * ARM64: More improvements to the generation of immediates.
    * Abstract out on-demand loading of [FFI](http://luajit.org/ext_ffi.html) library.
    * [FFI](http://luajit.org/ext_ffi.html): Fix dangling reference to CType.
    * PPC/PS3: Fix BC_ADD*/BC_SUB*.
    * Fix use-def analysis for vararg functions.
    * Fix use-def analysis for BC_VARG.
    * DynASM/ARM64: Fix ADRP encoding with absolute address.
    * Fix compiler warnings.
    * DynASM/ARM64: Add .long expr. Add .quad/.addr expr + refs.
    * DynASM/x86: Fix x64 .aword refs. Add .qword, .quad, .addr and .long.
    * FFI/ARM64/OSX: Fix vararg call handling.
    * Prevent compile of __concat with tailcall to fast function.
    * Fix IR_RENAME snapshot number. Follow-up fix for a32aeadc.
    * DynASM: Fix global label references
    * DynASM/ARM64: Add VREG support.
    * Fix build with busybox grep.
    * NetBSD: Use PROT_MPROTECT() and disable getentropy().
    * Allow disabling the serializer.
    * BSD: Fix build with BSD grep.
    * Fix .bat file builds.
    * OSX: Fix build by hardcoding external frame unwinding.
    * Reorganize lightuserdata interning code.
    * Upgrade docs to HTML5. It's about time.
    * [FFI](http://luajit.org/ext_ffi.html): Handle zero-fill of struct-of-NYI.
    * ARM64: Improve generation of immediates.
    * Detect inconsistent renames even in the presence of sunk values.
    * Handle on-trace OOM errors from helper functions.
    * Use weak guards for on-trace allocations.
    * PPC: Fix GG_State loads.
    * MIPS: Fix handling of long-range spare jumps.
    * Cleanup and enable external unwinding for more platforms.
    * Remove specific version numbers from the docs.
    * iOS: Don't use getentropy() since it's disallowed in the App Store.
    * Linux/ARM64: Make mremap() non-moving due to VA space woes.

