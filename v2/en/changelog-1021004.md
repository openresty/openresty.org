<!---
    @title         ChangeLog for 1.21.4.x
    @creator       Johnny Wang
    @created       2022-05-13 06:49 GMT
--->

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
