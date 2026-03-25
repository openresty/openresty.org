<!---
    @title         ChangeLog for 1.29.2.x
    @creator       Junlong Li
    @created       2026-02-28 14:33 GMT
--->

# Version 1.29.2.3 - 25 Mar 2025

* backported patches from [nginx](https://nginx.org/en/security_advisories.html)
    * CVE-2026-27654: Buffer overflow in ngx_http_dav_module
    * CVE-2026-27784: Buffer overflow in the ngx_http_mp4_module
    * CVE-2026-32647: Buffer overflow in the ngx_http_mp4_module
    * CVE-2026-27651: NULL pointer dereference while using CRAM-MD5 or APOP
    * CVE-2026-28753: Injection in auth_http and XCLIENT
    * CVE-2026-28755: OCSP result bypass in stream
    * CVE-2026-1642: SSL upstream injection

* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to v0.10.30rc2
    * feature: add ffi ngx_http_lua_ffi_socket_tcp_get_ssl_pointer() and ffi ngx_http_lua_ffi_socket_tcp_get_ssl_ctx(). _Thanks lijunlong for the patch._
    * feature: add new API: tcpsock:getsslsession. _Thanks lijunlong for the patch._
    * feature: add ngx_http_lua_ffi_get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add precontent_by_lua directives _Thanks Hanada for the patch._
    * feature: add server random and master key fetch api. _Thanks xiangwei for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: proxy_ssl_verify_by_lua* directives _Thanks willmafh for the patch._
    * feature: update to version v0.1.30. _Thanks lijunlong for the patch._
    * optimize: add compatibility for freenginx. _Thanks Sergey A. Osokin for the patch._
    * optimize: add upstream server information to the error log of cosocket. _Thanks lijunlong for the patch._
    * bugfix: clear wait timer in ngx_http_lua_pipe_proc_wait_cleanup to prevent SIGSEGV on QUIC connection close _Thanks Jun Ouyang for the patch._
    * bugfix: failed to build proxy_ssl* with openssl 1.0.2. _Thanks lijunlong for the patch._
    * bugfix: fix the compatibility issue for freenginx. _Thanks Y.Horie for the patch._
    * bugfix: prevent NULL dereference in SSL cache by ensuring old_cycle is set _Thanks Jun Ouyang for the patch._
    * bugfix: prevent use-after-free crash in ngx_http_lua_pipe by ensuring connections are closed before pool destruction in quic connection close path. _Thanks Jun Ouyang for the patch._
    * bugfix: prevent uthread crash by checking coroutine reference before deletion. _Thanks Jun Ouyang for the patch._
    * doc: fixed typo. _Thanks leslie for the patch._
    * doc: typo fixes and delete incorrect statements. _Thanks willmafh for the patch._
    * doc: update copyright. _Thanks lijunlong for the patch._
    * test: fix flaky test at boringssl environment. _Thanks Jun Ouyang for the patch._

* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module)
    * feature: add ffi api ngx_stream_lua_ffi_socket_tcp_getfd. _Thanks lijunlong for the patch._
    * feature: add ffi functions ngx_stream_lua_ffi_socket_tcp_get_ssl_pointer() and ngx_stream_lua_ffi_socket_tcp_get_ssl_ctx(). _Thanks lijunlong for the patch._
    * feature: add new API: tcpsock:get_ssl_session. _Thanks lijunlong for the patch._
    * feature: add ngx_stream_lua_ffi_get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: implement serversslhandshake method on downstream sockets (#392) _Thanks Rob Mueller for the patch._
    * feature: proxy_ssl_certificate_by_lua directives _Thanks willmafh for the patch._
    * feature: update version to v0.0.18. _Thanks lijunlong for the patch._
    * optimize: add compatibility for freenginx. _Thanks Sergey A. Osokin for the patch._
    * optimize: add upstream server information to the error log of cosocket. _Thanks lijunlong for the patch._
    * bugfix: didn't close cosocket when nginx shutdown timer has been triggered. _Thanks lijunlong for the patch._
    * bugfix: failed to build with old ssl. _Thanks lijunlong for the patch._
    * bugfix: prevent uthread crash by checking coroutine reference before deletion. _Thanks Jun Ouyang for the patch._
    * bugfix: supress clang warning. _Thanks lijunlong for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.33rc2
    * feature: add fetch server random and master key lua api _Thanks mengxiangwei for the patch._
    * feature: add new API: tcpsock:getsslsession. _Thanks lijunlong for the patch._
    * feature: add precontent_by_lua directives. _Thanks Hanada for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: add sock:getsslpointer() and sock:getsslctx(). _Thanks lijunlong for the patch._
    * feature: add ssl.get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add tcpsock.getfd() for stream subsystem. _Thanks lijunlong for the patch._
    * feature: proxy_ssl_certificate_by_lua directives _Thanks willmafh for the patch._
    * optimize: more detail error message when loading wrong lua-nginx-module. _Thanks lijunlong for the patch._
    * bugfix: failed to load socket.lua when building without ssl. _Thanks lijunlong for the patch._
    * doc: typo fixes. _Thanks Chrono for the patch._

* upgraded [luajit2](https://github.com/openresty/luajit2) to v2.1-20260311
    * Add ffi.abi("dualnum"). _Thanks Mike Pall for the patch._
    * Allow mcode allocations outside of the jump range to the support code. _Thanks Mike Pall for the patch._
    * ARM64: Enable unaligned accesses if indicated by the toolchain. _Thanks Mike Pall for the patch._
    * ARM64: Fix disassembly of >2GB branch targets. _Thanks Mike Pall for the patch._
    * ARM64: Fix disassembly of certain sub-word-size loads/stores. _Thanks Mike Pall for the patch._
    * ARM64: More fixes for ARM BTI. _Thanks Mike Pall for the patch._
    * Avoid recording interference due to invocation of VM hooks. _Thanks Mike Pall for the patch._
    * Back out MSVC LJ_CONSTF declaration. _Thanks Mike Pall for the patch._
    * bcsave.lua: add ppc64 and ppc64le mappings _Thanks Piotr Kubaj for the patch._
    * bugfix: failed to build with LUA_USE_TRACE_LOGS defined. _Thanks lijunlong for the patch._
    * DUALNUM: Add missing type conversion for FORI slots. _Thanks Mike Pall for the patch._
    * DUALNUM: Fix narrowing of unary minus. _Thanks Mike Pall for the patch._
    * DUALNUM: Fix recording of loops broken by previous change. _Thanks Mike Pall for the patch._
    * DUALNUM: Improve/fix edge cases of unary minus. _Thanks Mike Pall for the patch._
    * ELF/Mach-O: Force default visibility for public API functions. _Thanks Mike Pall for the patch._
    * FFI: Avoid dangling cts->L. _Thanks Mike Pall for the patch._
    * FFI: Fix constructor index resolution in JIT compiler. _Thanks Mike Pall for the patch._
    * Fix compiler warning. _Thanks Mike Pall for the patch._
    * Fix edge cases when generating IR for string.byte/sub/find. _Thanks Mike Pall for the patch._
    * Fix edge cases when recording string.byte/sub. _Thanks Mike Pall for the patch._
    * Fix G->jit_base relocation on stack resize. _Thanks Mike Pall for the patch._
    * Fix minilua undefined behavior in bit.tohex. _Thanks Mike Pall for the patch._
    * Fix MSVC LJ_CONSTF declaration. _Thanks Mike Pall for the patch._
    * Fix string.format for limited precision FP conversions. _Thanks Mike Pall for the patch._
    * Ignore PDB files for git. _Thanks Mike Pall for the patch._
    * Implement double-to-integer conversions for s390x (#256) _Thanks Ilya Leoshkevich for the patch._
    * macOS: Change Mach-O object file layout required by XCode 15.0. _Thanks Mike Pall for the patch._
    * MIPS64: Avoid unaligned load in lj_vm_exit_interp. _Thanks Mike Pall for the patch._
    * PPC: Fix soft-float lj_num2u64(). _Thanks Mike Pall for the patch._
    * Prevent recording of loops with -0 step or NaN values. _Thanks Mike Pall for the patch._
    * Prevent snapshot purge while recording a function header. _Thanks Mike Pall for the patch._
    * Remove compiler flag for FP conversions. Now unnecessary. _Thanks Mike Pall for the patch._
    * Remove pointless GCC/MSVC const function attributes. _Thanks Mike Pall for the patch._
    * Run VM events and finalizers in separate state. _Thanks Mike Pall for the patch._
    * s390x: simplify ceil/floor code (#246) _Thanks J. Neuschäfer for the patch._
    * Unify Lua number to FFI integer conversions. _Thanks Mike Pall for the patch._
    * x64/!LJ_GC64: The allocation limit is required for a no-JIT build, too. _Thanks Mike Pall for the patch._
    * x86/x64: Backport fix for math.min()/math.max() argument check. _Thanks Mike Pall for the patch._

# Version 1.29.2.1 - 14 Jan 2025

* Nginx core
    * Upgrade from nginx 1.27.1 to 1.29.2.

* OpenSSL
    * upgraded from version 3.4.1 to 3.5.5.

* PCRE
    * upgraded from version 10.44 to 10.47.

* [lua-nginx-module](https://github.com/openresty/lua-nginx-module) v0.10.29
    * feature: added ngx_http_lua_ffi_ssl_get_client_hello_ext_present(). _Thanks Gabriel Clima for the patch._
    * feature: add function to bypass HTTP conditional request checks (#2401) _Thanks kurt for the patch._
    * feature: add lua_ssl_key_log directive. _Thanks willmafh for the patch._
    * feature: add ngx_http_lua_ffi_req_shared_ssl_ciphers(). _Thanks Sunny Chan for the patch._
    * feature: add sock:getfd(). _Thanks lijunlong for the patch._
    * feature: Export three functions for manipulating ngx_http_lua_co_ctx_t structures. _Thanks lijunlong for the patch._
    * feature: ngx_http_lua_ffi_ssl_get_client_hello_ciphers(). _Thanks Gabriel Clima for the patch._
    * feature: proxy_ssl_verify_by_lua directives. _Thanks willmafh for the patch._
    * feature: support tcp binding ip:port or ip of ipv4 or ipv6 _Thanks ElvaLiu for the patch._
    * bugfix: add HTTP/3 QUIC SSL Lua yield patch macro protection. _Thanks swananan for the patch._
    * bugfix: didn't flush send buffer after lua phase(access/rewrite/server_rewrite) done. _Thanks lijunlong for the patch._
    * bugfix: didn't use right hostname when the length of hostname is greater than 32. _Thanks lijunlong for the patch._
    * bugfix: ensure context is restorable on fd writable events. _Thanks Zeping Bai for the patch._
    * bugfix: improve HTTP/3 SSL Lua callback yield handling. _Thanks swananan for the patch._
    * bugfix: resume QUIC handshake for OpenSSL external QUIC API builds _Thanks swananan for the patch._
    * bugfix: the modifications in this PR are to supplement the overlooked changes in the commit e8f65dc53. _Thanks lijunlong for the patch._
    * optimize: unnecessary to do error check. _Thanks willmafh for the patch._
    * change: ngx_http_lua_ffi_get_req_ssl_pointer() add err argument. _Thanks lijunlong for the patch._
    * style: code style consistency. _Thanks willmafh for the patch._

* [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) v0.0.17
    * feature: add lua_ssl_key_log directive to log client connection SSL keys in the tcpsock:sslhandshake method. Keys are logged in the SSLKEYLOGFILE format compatible with Wireshark. _Thanks willmafh for the patch._
    * feature: add ngx_stream_lua_ffi_get_req_ssl_pointer() for stream subsystem. _Thanks lijunlong for the patch._
    * feature: add ngx_stream_lua_ffi_req_dst_addr(). _Thanks lijunlong for the patch._
    * feature: add support for tcp/udp bind. _Thanks alonbg for the patch._
    * feature: ngx_stream_lua_ffi_req_shared_ssl_ciphers(). _Thanks Ri Shen Chen for the patch._
    * feature: proxy_ssl_verify_by_lua directives. _Thanks willmafh for the patch._
    * bugfix: failed to build with openssl 1.x.x and boringssl. _Thanks lijunlong for the patch._
    * bugfix: failed to build with openssl < 3.0.2. _Thanks lijunlong for the patch._
    * bugfix: fixed typo. _Thanks willmafh for the patch._
    * bugfix: fixed warning. _Thanks lijunlong for the patch._
    * bugfix: resolve unused function warning in BoringSSL builds. _Thanks swananan for the patch._
    * optimize: add error checking for SSL_set_tlsext_status_type(). _Thanks Fahnenfluchtige for the patch._
    * optimize:  checked r before using it. _Thanks Fahnenfluchtige for the patch._
    * optimize: fixed build warning. _Thanks lijunlong for the patch._
    * style: fixed coding style. _Thanks lijunlong for the patch._
    * style: fixed coding style. _Thanks willmafh for the patch._

* [lua-resty-core](https://github.com/openresty/lua-resty-core) v0.1.32
    * feature: add bind support for the stream subsystem. _Thanks lijunlong for the patch._
    * feature: add bypass_if_checks method to ngx.resp (#495) _Thanks kurt for the patch._
    * feature: add get_req_ssl_pointer() for stream subsystem. _Thanks lijunlong for the patch._
    * feature: add ngx.req.get_original_addr. _Thanks lijunlong for the patch._
    * feature: add sock:getfd(). _Thanks lijunlong for the patch._
    * feature: add ssl.get_shared_ssl_ciphers for stream subsystem. _Thanks Sunny Chan for the patch._
    * feature: add support for nginx-1.29.2. _Thanks lijunlong for the patch._
    * feature: add support for  ssl.get_req_shared_ssl_ciphers() _Thanks Sunny Chan for the patch._
    * feature: get_client_hello_ciphers() (#498) _Thanks Gabriel Clima for the patch._
    * feature: proxy_ssl_verify_by_lua directives. _Thanks willmafh for the patch._
    * feature: add get_client_hello_ext_present _Thanks Gabriel Clima for the patch._
    * optimize: remove unused code. _Thanks lijunlong for the patch._
    * optimize: remove unused param. _Thanks Bai Miao for the patch._
    * bugfix: failed to get error message because the input buffer length is not set. _Thanks lijunlong for the patch._
    * bugfix: fix issue #499 to avoid unexpect assertion when c func return FFI_OK immediately. _Thanks akf00000 for the patch._
    * doc: add doc for get_client_hello_ext_present(). _Thanks lijunlong for the patch._
    * doc: fixed typo. _Thanks lijunlong for the patch._
    * style: fixed coding style. _Thanks lijunlong for the patch._

* [luajit2](https://github.com/openresty/luajit2) v2.1-20251022
    * Add compatibility string coercion for fp:seek() argument. _Thanks Mike Pall for the patch._
    * Add GNU/Hurd build support. _Thanks Mike Pall for the patch._
    * ARM64: Fix pass-by-value struct calling conventions. _Thanks Mike Pall for the patch._
    * ARM: Fix soft-float math.min()/math.max(). _Thanks Mike Pall for the patch._
    * Avoid out-of-range PC for stack overflow error from snapshot restore. _Thanks Mike Pall for the patch._
    * Avoid unpatching bytecode twice after a trace flush. _Thanks Mike Pall for the patch._
    * bugfix: table.clone can't work after commit 538a82133ad. _Thanks lijunlong for the patch._
    * Change handling of nil value markers in template tables. _Thanks Mike Pall for the patch._
    * FFI: Add pre-declared int128_t, uint128_t, __int128 types. _Thanks Mike Pall for the patch._
    * FFI: Fix dangling CType references. _Thanks Mike Pall for the patch._
    * Fix error generation in load*. _Thanks Mike Pall for the patch._
    * Fix handling of nil value markers in template tables. _Thanks Mike Pall for the patch._
    * Fix io.write() of newly created buffer. _Thanks Mike Pall for the patch._
    * Fix JIT slot overflow during up-recursion. _Thanks Mike Pall for the patch._
    * Fix reporting of an error during error handling. _Thanks Mike Pall for the patch._
    * Fix state restore when recording __concat metamethod. _Thanks Mike Pall for the patch._
    * Gracefully handle broken custom allocator. _Thanks Mike Pall for the patch._
    * Improve CLI signal handling on POSIX. _Thanks Mike Pall for the patch._
    * Initialize unused value when specializing to cdata metatable. _Thanks Mike Pall for the patch._
    * macOS: Add support for Apple hardened runtime. _Thanks Mike Pall for the patch._
    * macOS: Fix Apple hardened runtime support and put behind build option. _Thanks Mike Pall for the patch._
    * macOS: Fix support for Apple hardened runtime. _Thanks Mike Pall for the patch._
    * Merge from upstream v2.1. _Thanks lijunlong for the patch._
    * Prevent Clang UB 'optimization' which breaks integerness checks. _Thanks Mike Pall for the patch._
    * Remove Cygwin from docs, since it's not a supported target. _Thanks Mike Pall for the patch._
    * REVERT: Change handling of nil value markers in template tables. _Thanks Mike Pall for the patch._
    * Use dylib extension for iOS installs, too. _Thanks Mike Pall for the patch._
    * Windows: Add lua52compat option to msvcbuild.bat. _Thanks Mike Pall for the patch._
    * Windows: Allow mixed builds with msvcbuild.bat. _Thanks Mike Pall for the patch._
    * Windows: Clarify installation directory layout. _Thanks Mike Pall for the patch._
    * x64: Add support for CET IBT. _Thanks Mike Pall for the patch._
    * x86/x64: Don't use undefined MUL/IMUL zero flag. _Thanks Mike Pall for the patch._

* [lua-resty-redis](https://github.com/openresty/lua-resty-redis)
    * bugfix: connection is closed after the blpop and brpop calls time out. _Thanks 冉朋 for the patch._
    * docs: fix typo in README.markdown. _Thanks hms5232 for the patch._
    * optimize: return setmetatable is NYI which can not be jit compiled. (#287) _Thanks Zero King for the patch._

* [xss-nginx-module](https://github.com/openresty/xss-nginx-module)
    * feature: add dynamic build support. _Thanks Su Yang for the patch._

* [lua-upstream-nginx-module](https://github.com/openresty/lua-upstream-nginx-module)
    * doc: small typo fixes in the docs for get_servers. _Thanks chronolaw for the patch._

* [lua-resty-lock](https://github.com/openresty/lua-resty-lock)
    * doc: correct package status in README.markdown. _Thanks jumper047 for the patch._

* [ngx_devel_kit](https://github.com/simplresty/ngx_devel_kit)
    * src/ndk.h: Do not #error if 'NDK' is undefined _Thanks Simpl for the patch._
    * src/ndk.h: do not #error if 'NDK' is undefined _Thanks Zurab Kvachadze for the patch._
    * src/ndk.h: Update version _Thanks Simpl for the patch._

* [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module)
    * bugfix: didn't set next to NULL for the output header. _Thanks lijunlong for the patch._
    * Move the LICENSE content to a separate file. _Thanks uhliarik for the patch._

* [rds-csv-nginx-module](https://github.com/openresty/rds-csv-nginx-module)
    * bugfix: change bit filed member type to unsigned to suppress the warning. _Thanks lijunlong for the patch._

* [lua-resty-shell](https://github.com/openresty/lua-resty-shell)
    * doc: add a description of the default value of the max_size parameter. _Thanks lijunlong for the patch._
    * README.md: add info about default timeout (#21) _Thanks Jeffrey 'jf' Lim for the patch._

* [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql)
    * bugfix: mysql driver doesn't handle well server side query timeout (Query execution was interrupted). _Thanks Nir Nahum for the patch._

* [resty-cli](https://github.com/openresty/resty-cli)
    * feature: add new option --load-module. _Thanks lijunlong for the patch._
    * feature: resty: implemented the --dump-nginx-conf option to print out the generated configuration. _Thanks 罗泽轩 for the patch._

* [opm](https://github.com/openresty/opm)
    * opm: revamp options. _Thanks Dmitry Meyer for the patch._
    * doc: fixed wrong example of user command line arguments. _Thanks Johnny Wang for the patch._
