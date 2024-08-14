<!---
    @title         ChangeLog for 1.27.0.x
    @creator       Johnny Wang
    @created       2024-08-14 14:33 GMT
--->

# Version 1.27.0.1 - 14 Aug 2024

* upgraded the [nginx](nginx.html) core to 1.27.0
    * see the changes here: http://nginx.org/en/CHANGES
* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to 0.10.27
    * bugfix: fixed keepalive error in cosocket. _Thanks lijunlong for the patch._
    * bugfix: ensure compatibility with older nginx versions lacking TLS 1.3 support. _Thanks lijunlong for the patch._
    * bugfix: initialize ASN1_GENERALIZEDTIME pointers in ssl_validate_ocsp_response. _Thanks lijunlong for the patch._
    * bugfix: nginx crashed when binding local address failed from lua. _Thanks lijunlong for the patch._
    * bugfix: treat shared dict entries with TTL of 0 as expired. _Thanks lijunlong for the patch._
    * bugfix: let `balancer.recreate_request` API work for body data changed case. _Thanks Jun Ouyang for the patch._
    * feature: add support for SSL trusted certificates in client verification. _Thanks xiangwei for the patch._
    * bugfix: respect max retry after using balancer pool. _Thanks kurt for the patch._
    * feature: support ngx.location.capture and ngx.location.capture_multi with `headers` option. _Thanks Tinglong Yang for the patch._
    * bugfix: undefined symbol `SSL_client_hello_get0_ext` when linking against libressl. _Thanks lijunlong for the patch._
    * bugfix: fixed compilation errors when building without SSL. _Thanks Johnny Wang for the patch._
    * change: should match the local address when get connection from the keepalive pool. _Thanks lijunlong for the patch._
    * feature: implemented keepalive pooling in `balancer_by_lua*`. _Thanks lijunlong for the patch._
    * bugfix: prevent main thread access to freed fake request in init_worker. _Thanks fesily for the patch._
    * bugfix: preserve lua-nginx-module context when `ngx.send_header()` triggers filter_finalize. _Thanks Jun Ouyang for the patch._
    * bugfix: fix config test for signalfd with gcc 11. _Thanks Jiří Setnička for the patch._
    * bugfix: worker thread Lua VM may take lots of memory. _Thanks lijunlong for the patch._
    * bugfix: ensure proper connection closure when setting empty body before last chunk. _Thanks Liu Wei for the patch._
    * bugfix: wrong arguments of `setkeepalive()` result in the compromise of data integrity. _Thanks lijunlong for the patch._
    * bugfix: Fixing compatibility issues with BoringSSL. _Thanks lijunlong for the patch._
    * feature: validate and expose nextUpdate field in OCSP response. _Thanks Elvin Efendi for the patch._
    * feature: add support for deriving key from tls master secret. _Thanks bas-vk for the patch._
    * feature: add UDP cosocket bind api. _Thanks syz for the patch._
    * bugfix: fixed HTTP HEAD request smuggling issue. _Thanks lijunlong for the patch._
    * optimize: allow to reenable the tls for the upstream. _Thanks lijunlong for the patch._
    * feature: add FFI function for `balancer.disable_ssl()`. _Thanks lijunlong for the patch._
    * bugfix: correct offset vector memory allocation size for PCRE2. _Thanks Zhongwei Yao for the patch._
    * feature: implemented `ngx_http_lua_ffi_ssl_client_random`. _Thanks Ruidong-X for the patch._
    * bugfix: fix memory corruption in consecutive regex calls. _Thanks Zhongwei Yao for the patch._
    * feature: add `ngx_http_lua_ffi_parse_der_cert` and `ngx_http_lua_ffi_parse_der_key` functions. _Thanks Brian Rak for the patch._
* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) to 0.0.15
    * bugfix: fixed keepalive error in cosocket. _Thanks lijunlong for the patch._
    * bugfix: treat shared dict entries with TTL of 0 as expired. _Thanks lijunlong for the patch._
    * feature: add support for SSL trusted certificates in client verification. _Thanks xiangwei for the patch._
    * feature: support lua balancer set proxy bind dynamic _Thanks ytlm for the patch._
    * bugfix: check for SSL context instead of listen flag for nginx 1.25.5+ compatibility. _Thanks Konstantin Pavlov for the patch._
    * bugfix: wrong arguments of setkeepalive() result in the compromise of data integrity. _Thanks lijunlong for the patch._
    * bugfix: correct offset vector memory allocation size for PCRE2. _Thanks Zhongwei Yao for the patch._
    * feature: implemented `ngx_stream_lua_ffi_ssl_client_random`. _Thanks Ruidong-X for the patch._
    * bugfix: wrong argument for `pcre2_match`. _Thanks lijunlong for the patch._
    * feature: add functions to parse DER formatted certificates/keys. _Thanks Brian Rak for the patch._
    * changes: remove the useless pcre config. _Thanks swananan for the patch._
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to 0.1.29
    * feature: add ssl_trusted_certificate argument for `ssl.verify_client()`. _Thanks xiangwei for the patch._
    * feature: add `balancer.bind_to_local_addr` for stream module. _Thanks ytlm for the patch._
    * feature: makes outgoing connections to a proxied server originate from the specified local IP address with an optional port. _Thanks lijunlong for the patch._
    * feature: implemented keepalive pooling in `balancer_by_lua*`. _Thanks lijunlong for the patch._
    * bugfix: initialize next_update pointer to avoid potential stale values. _Thanks YanLIU for the patch._
    * optimize: localize tonumber for `ngx.worker.pids`. _Thanks Chrono for the patch._
    * feature: `validate_ocsp_response` should return nextUpdate if available. _Thanks Elvin Efendi for the patch._
    * feature: add `ssl.get_req_ssl_pointer`. _Thanks James Callahan for the patch._
    * feature: add support for exporting key material to derive keys from the tls master secret. _Thanks bas-vk for the patch._
    * feature: add `balancer.set_upstream_tls(on)`. _Thanks lijunlong for the patch._
    * feature: add `ssl.get_client_random`. _Thanks Ruidong-X for the patch._
    * optimize: explicit requirement to use bash. _Thanks lynch for the patch._
    * feature: add `parse_der_cert` and `parse_der_priv_key` functions. _Thanks Brian Rak for the patch._
* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket) to 0.12
    * feature: add `send_continue` method. _Thanks Toru for the patch._
    * feature: `client:connect()` returns HTTP response header. _Thanks Michael Martin for the patch._
    * feature: custom sec-websocket-key in client. _Thanks Michael Martin for the patch._
    * feature: add support for discrete send/recv payload limits in WebSocket client. _Thanks Michael Martin for the patch._
    * feature: support custom host header in client. _Thanks flrgh for the patch._
    * feature: support connecting to unix sockets. _Thanks Petter Berven for the patch._
    * optimization: check ssl_support early. _Thanks Michael Martin for the patch._
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis) to v0.31
    * optimize: cache the table for sending requests. _Thanks lijunlong for the patch._
* upgraded [lua-resty-string](https://github.com/openresty/lua-resty-string) to 0.16
    * feature: add AAD support in aes gcm. _Thanks wzxjohn for the patch._
    * change: make `random.bytes` cryptographically strong by default. _Thanks rfl890 for the patch._
* upgraded [lua-cjson](https://github.com/openresty/lua-cjson) to 2.1.0.14
    * feature: Lua 5.3 + 5.4 integer support, with CI and conflicts fixed. _Thanks Hisham Muhammad for the patch._
    * bugfix: bus error or SIGSEGV caused by encode not keep buffer. _Thanks hyw0810 for the patch._
* upgraded [lua-resty-signal](https://github.com/openresty/lua-resty-signal) to 0.04
    * bugfix: handle '?.so' in package.cpath. _Thanks Michael Martin for the patch._
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache) to v0.14
    * optimize: echo warning message when install this library to "/usr/local/lib/lua/" and copy installation guide from lua_resty_core module. _Thanks lynch for the patch._
* upgraded [rds-json-nginx-module](https://github.com/openresty/rds-json-nginx-module) to 0.17
    * bugfix: failed to compilation on rockylinux 9. _Thanks lijunlong for the patch._
* upgraded [luajit2](https://github.com/openresty/luajit2) to 2.1-20240626
    * change: disable hash computation optimization in the OpenResty branch (agentzh-v2.1) due to the possibility of
      severe performance degradation ([CVE-2024-39702](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2024-39702)).
      This issue is specific to our branch and does not affect upstream LuaJIT.  _Thanks to Zhongwei Yao from Kong Inc. for reporting this issue. Thanks lijunlong for the patch._
    * bugfix: Enabled ppc64le arch on travis and fixed one failing test case. _Thanks Alhad Deshpande for the patch._
    * Prevent sanitizer warning in snap_restoredata().
    * Limit number of string format elements to compile.
    * FFI: Clarify scalar boxing behavior.
    * OSX/iOS: Fix SDK incompatibility.
    * Windows/MSVC: Cleanup msvcbuild.bat and always generate PDB.
    * Fix segment release check in internal memory allocator.
    * FFI: Turn FFI finalizer table into a proper GC root.
    * OSX/iOS: Always generate 64 bit non-FAT Mach-O object files.
    * Show name of NYI bytecode in -jv and -jdump.
    * Use generic trace error for OOM during trace stitching.
    * feature: add s390x disassembler. _Thanks Aditya Bisht for the patch._
    * Handle all types of errors during trace stitching.
    * Fix recording of __concat metamethod.
    * Prevent down-recursion for side traces.
    * Check frame size limit before returning to a lower frame.
    * FFI: Treat cdata finalizer table as a GC root.
    * Handle stack reallocation in debug.setmetatable() and lua_setmetatable().
    * optimize: [ppc64le] Aligned code as per other archs for next_1 function and relevant code changes. _Thanks Alhad Deshpande for the patch._
    * Rework stack overflow handling.
    * Preserve keys with dynamic values in template tables when saving bytecode.
    * Prevent include of luajit_rolling.h.
    * Fix zero stripping in %g number formatting.
    * Fix unsinking of IR_FSTORE for NULL metatable.
    * DynASM/x86: Add endbr instruction.
    * MIPS64 R2/R6: Fix FP to integer conversions.
    * Add cross-32/64 bit and deterministic bytecode generation.
    * DynASM/x86: Allow [&expr] operand.
    * Check for IR_HREF vs. IR_HREFK aliasing in non-nil store check.
    * Respect jit.off() on pending trace exit.
    * Simplify handling of instable types in TNEW/TDUP load forwarding.
    * Only emit proper parent references in snapshot replay.
    * Fix anchoring for string buffer set() method (again).
    * ARM: Fix stack restore for FP slots.
    * Document workaround for multilib vs. cross-compiler conflict.
    * Fix anchoring for string buffer set() method.
    * Fix runtime library flags for MSVC debug builds.
    * Fix .debug_abbrev section in GDB JIT API.
    * Optimize table.new() with constant args to (sinkable) IR_TNEW.
    * Emit sunk IR_NEWREF only once per key on snapshot replay.

