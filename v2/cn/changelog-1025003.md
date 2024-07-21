<!---
    @title         ChangeLog for 1.25.3.x
    @creator       Johnny Wang
    @created       2024-01-04 04:05 GMT
--->

# Version 1.25.3.2 - 19 Jul 2024

* upgraded [LuaJIT](https://github.com/openresty/luajit2) to v2.1-20231117.1
    * bugfix: disable hash computation optimization because of the possibility of severe degradation (CVE-2024-39702). This issue originates from the OpenResty LuaJIT branch. _Thanks Kong INC. for reporting the issue, and thanks lijunlong for the patch._

# Version 1.25.3.1 - 04 Jan 2024

* upgraded the [Nginx](nginx.html) core to 1.25.3.
    * see the changes here: http://nginx.org/en/CHANGES
* win32/win64:
    * upgraded OpenSSL to 1.1.1w.
    * upgraded Zlib to 1.3.
* Added support for PCRE2. _Thanks swananan for the patch._
* Added support for lua_ssl_certificate and lua_ssl_certificate_key. _Thanks zhangjie for the patch._
* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module#readme)	to 0.10.26
    * optimize: prevent moving the expired item to the LRU queue head during lookup. _Thanks lijunlong for the patch._
    * bugfix: fixed a memory leak in the case of dubious connections. _Thanks Johnny Wang for the patch._
    * feature: set the HTTP/3 authority as the `http_host` header. _Thanks lijunlong for the patch._
    * feature: add max_bytes argument for get_body_data() function. _Thanks masterlvng for the patch._
    * bugfix: failed to build when building without http2 and http3 modules. _Thanks lijunlong for the patch._
    * changes: modified read body API limitations for HTTP/2 or HTTP/3 requests. _Thanks swananan for the patch._
    * bugfix: resolved a compilation failure with Clang. _Thanks lijunlong for the patch._
    * bugfix: fixed compilation error: variable 'nelts' set but not used. _Thanks lijunlong for the patch._
    * change: remove `ngx.re` from `ngx.run_worker_thread`. _Thanks lijunlong for the patch._
    * bugfix: addressed a use-after-free issue when encountering an invalid HTTP If-Match header. _Thanks lijunlong for the patch._
    * optimize: Optimized use of SSL contexts. _Thanks Jan Prachař for the patch._
    * bugfix: permitted ngx_http_lua_socket_tcp_bind in ssl_session_fetch_by and ssl_client_hello_by contexts. _Thanks willmafh for the patch._
    * bugfix: fixed an issue in ssl_client_hello_by_lua while generating the chunk cache key and chunk name. _Thanks mafh for the patch._
    * bugfix: when the value type is `SHDICT_TNUMBER`, it now correctly retrieves the number field instead of the boolean field. _Thanks willmafh for the patch._
    * bugfix: fixed an issue where mixed recv API calls caused unexpected results. _Thanks ZongRun for the patch._
    * change: in lua-ssl-protocols, disabled SSLv3 and enabled TLSv1.3 by default. _Thanks lijunlong for the patch._
    * bugfix: disabled HTTP/2 during body reads due to an http2 stream processing bug. _Thanks Jun Ouyang for the patch._
    * bugfix: improved handling of new list elements. _Thanks A compound of Fe and O for the patch._
* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module#readme) to 0.0.14
    * bugfix: stream server block didn't inherit the [log_by_lua*](https://github.com/openresty/lua-nginx-module#log_by_lua) directives configured in stream block. _Thanks willmafh for the patch._
    * optimize: now we make use of the new lua_getexdata2 and lua_setexdata2 to attach coctx to the Lua thread objects directly which save the lookup overhead which can become the bottleneck when there are many Lua light threads around in a single request handler. _Thanks lijunlong for the patch._
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.28
    * optimize: small optimization of `ngx.worker.pids()` . _Thanks Chrono for the patch._
* upgraded [lua-cjson](https://github.com/openresty/lua-cjson) to 2.1.0.13
    * bugfix: Lua cjson integer overflow issues (CVE-2022-24834). _Thanks lijunlong for the patch._
    * feature: updated netlib `dtoa.c` from https://netlib.sandia.gov/fp/dtoa.c. _Thanks lijunlong for the patch._
    * feature: Add option to skip invalid value types. _Thanks lijunlong for the patch._
    * optimization: add void to functions with no arguments to prevent compiler warning. _Thanks lijunlong for the patch._
* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket) to 0.11
    * bugfix: support socket connection pool and fix repeated ssl_handshake(). _Thanks Nathan for the patch._
* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql) to 0.27
    * bugfix: ensure packet_no is not nil before proceeding. _Thanks AccidentallyTheCable for the patch._
* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic) to v0.09
    * refactor: remove unused var. _Thanks Abhishek Choudhary for the patch._
* upgraded [memc-nginx-module](https://github.com/openresty/memc-nginx-module) to 0.20
    * bugfix: corrected overallocations due to sizeof('c') being 4 instead of 1. _Thanks наб for the patch._
* upgraded [opm](https://github.com/openresty/opm) to 0.0.8
    * bugfix: Made compatible with [LuaJIT](https://github.com/openresty/luajit2) x.y.ROLLING version. _Thanks Johnny Wang for the patch._
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns) to v0.23
    * feature: Add a cleanup method for destroying the cosocket resources within the resolver object explicitly. _Thanks Robin Xiang for the patch._
* upgraded [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module#readme) to 0.37
    * bugfix: initialized previously uninitialized field `h[i]->append`. _Thanks Johnny Wang for the patch._
    * change: remove the Set-Cookie restriction of `-a` option. _Thanks menglei for the patch._
    * optimize: set `r->keepalive` 0 to close connection. _Thanks Masahiro Nagano for the patch._
    * feature: add append mode for more_set_headers(so far just for Set-Cookie field). _Thanks menglei for the patch._
    * bugfix: fixed an unused variable on non-debug builds. _Thanks Thibault Charbonnier for the patch._
* upgraded [resty-cli](https://github.com/openresty/resty-cli) to v0.30
    * feature: add label for resty cmd. _Thanks lijunlong for the patch._
* upgraded [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit) to v0.3.3
    * fix compile errors. _Thanks lynch for the patch._
* upgraded [lua-tablepool](https://github.com/openresty/lua-tablepool) to v0.03
    * optimize: only call cleartab just before we really put it back. _Thanks Chrono for the patch._
* upgraded [LuaJIT](https://github.com/openresty/luajit2) to v2.1-20231117
    * x86/x64: Don't fuse loads across IR_NEWREF and table.clear.
    * x86/x64: Add more red zone checks to assembler backend.
    * Add stack check to pcall/xpcall.
    * Invalidate SCEV entry when returning to lower frame.
    * [FFI](http://luajit.org/ext_ffi.html): Fix pragma push stack limit check and throw on overflow.
    * ARM64: Fix disassembly of ldp/stp offsets and U12 loads.
    * Check for upvalue state transition in IR_UREFO.
    * x64: Properly fix __call metamethod return dispatch.
    * Windows/x86: _BitScan*64 are only available on 64-bit archs.
    * Add 'cc' file type for saving bytecode.
    * FFI/Windows: Fix type declaration for int64_t and uint64_t.
    * [FFI](http://luajit.org/ext_ffi.html): Fix dangling reference to CType in carith_checkarg().
    * DynASM/ARM64: Support ldp/stp of q registers.
    * ARM64: Use ADR and ADRP to form constants, fix IR_HREF code generation for constant FP keys, and Fuse negative 32 bit constants into arithmetic ops again.
    * ARM64: Unify constant register handling in interpreter.
    * ARM: Fix register hint for [FFI](http://luajit.org/ext_ffi.html) calls with FP results.
    * ARM64: Restore fp before sp in C stack unwinders.
    * [FFI](http://luajit.org/ext_ffi.html): Fix ffi.abi("pauth").
    * Maintain chain invariant in DCE.
    * LJ_FR2: Fix stack checks in vararg calls.
    * Follow-up fix for stack overflow handling cleanup.
    * Handle OOM error on stack resize in coroutine.resume and lua_checkstack.
    * Restore cur_L for specific Lua/C API use case.
    * Consistently use 64-bit constants for 64-bit IR instructions.
    * Handle all stack layouts in (delayed) TRACE vmevent.
    * Add missing coercion when recording select(string, ...).
    * Cleanup stack overflow handling.
    * Windows/ARM64: Add MSVC cross-build support for x64 to ARM64, update install docs, fix exception unwinding, and support Windows calling conventions.
    * IR_MIN/IR_MAX is non-commutative due to underlying FPU ops.
    * Windows: Call C++ destructors without compiling with /EHa, Pass scratch CONTEXT record to RtlUnwindEx.
    * ARM64: External unwinder already restores non-volatile registers.
    * [FFI](http://luajit.org/ext_ffi.html): Fix 64-bit shift fold rules.
    * Fix Cygwin build.
    * bugfix: Update s390x support.
    * Allow path overrides in genversion.lua with minilua, too.
    * Improve architecture detection error messages.
    * ARM64: Fuse rotates into logical operands and don't fuse sign extensions into these operands.
    * ARM64: Disassemble rotates on logical operands.
    * ARM: Fix stack check code generation.
    * ARM64: Fix LDP/STP fusion (again), ensure branch is in range before emitting TBZ/TBNZ, improve BC_JLOOP, integer IR_MUL code generation, IR_STRTO, IR_OBAR, IR_UREF, IR_HREF code generation, and Reload BASE via GL.
    * ARM64: Inline only use of emit_loada and Tune emit_lsptr.
    * ARM64: Improve K13 constant rematerialization and register allocation for integer IR_MUL/IR_MULOV.
    * ARM64: Fix register allocation for IR_*LOAD.
    * Update external MSDN URL in code.
    * FFI/ARM64/OSX: Handle non-standard OSX C calling conventions.
    * [FFI](http://luajit.org/ext_ffi.html): Unify stack setup for C calls in interpreter.
    * ARM64: Prevent STP fusion for conditional code emitted by TBAR and Fix LDP/STP fusing for unaligned accesses.
    * Handle table unsinking in the presence of IRFL_TAB_NOMM.
    * Use fallback name for install files without valid .git or .relver.
    * Handle non-.git checkout with .relver in .bat-file builds.
    * Fix external C call stack check when using LUAJIT_MODE_WRAPCFUNC.
    * Fix predict_next() in parser (again).
    * Handle the case when .git is not a directory.
    * Switch to rolling releases: mark v2.1 as production, update build scripts and documentation for rolling releases.
    * MIPS: Fix "bad FP FLOAD" assertion.
    * Ensure forward progress on trace exit to BC_ITERN.
    * ARM64: Add support for ARM64e pointer authentication codes (PAC) and Add instructions for ARM64e PAC in DynASM.
    * Fix maxslots for various bytecode instructions.
    * Fix frame for on-trace error messages and more types of on-trace error messages.
    * Add workaround for bytecode dump of builtins.
    * DynASM: Fix regression due to warning fix.
    * Fix base register coalescing in side trace.
    * ARM64: Fix assembly of HREFK (again) and Fix LDP code generation.
    * PPC/e500 with SPE enabled: use soft float instead of failing.
    * MIPSr6: Add missing files to Makefile install target.
    * Fix frame for on-trace out-of-memory error.
    * Fix handling of instable types in TNEW/TDUP load forwarding.
    * Print errors from __gc finalizers instead of rethrowing them.
    * Fix TDUP load forwarding after table rehash.
    * Fix canonicalization of +-0.0 keys for IR_NEWREF.
    * Improve error reporting on stack overflow.
    * Allow building sources with mixed LF/CRLF line-endings.
    * Don't fail for Clang builds, which pretend to be an ancient GCC.
    * Update lj_parse.c and lj_ccall.c.
    * ppc64le support.
