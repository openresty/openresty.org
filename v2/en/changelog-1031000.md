<!---
    @title         ChangeLog for 1.31.0.x
    @creator       Junlong Li
    @created       2026-05-13 14:33 GMT
--->

# Version 1.31.0.1 - 13 May 2026

* Nginx core
    * upgraded from nginx 1.29.2 to 1.31.0.

* OpenSSL
    * upgraded from version 3.5.5 to 3.5.6.

* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to v0.10.31
    * feature: add ffi ngx_http_lua_ffi_socket_tcp_get_ssl_pointer() and ffi ngx_http_lua_ffi_socket_tcp_get_ssl_ctx(). _Thanks lijunlong for the patch._
    * feature: add new API: tcpsock:getsslsession. _Thanks lijunlong for the patch._
    * feature: add ngx_http_lua_ffi_get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add precontent_by_lua directives _Thanks Hanada for the patch._
    * feature: add server random and master key fetch api. _Thanks xiangwei for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: proxy_ssl_verify_by_lua* directives _Thanks willmafh for the patch._
    * feature: support custom trusted CA store for cosocket TLS handshake. (#2495) _Thanks Walker Zhao for the patch._
    * bugfix: add dump in nginx -T. _Thanks Y.Horie for the patch._
    * bugfix: clear wait timer in ngx_http_lua_pipe_proc_wait_cleanup to prevent SIGSEGV on QUIC connection close _Thanks Jun Ouyang for the patch._
    * bugfix: fix the compatibility issue for freenginx. _Thanks Y.Horie for the patch._
    * bugfix: fixed typo in config. _Thanks xuruidong for the patch._
    * bugfix: prevent NULL dereference in SSL cache by ensuring old_cycle is set _Thanks Jun Ouyang for the patch._
    * bugfix: prevent SIGSEGV in event timer rbtree during worker shutdown. _Thanks Gabriel Clima for the patch._
    * bugfix: prevent use-after-free crash in ngx_http_lua_pipe by ensuring connections are closed before pool destruction in quic connection close path. _Thanks Jun Ouyang for the patch._
    * bugfix: prevent uthread crash by checking coroutine reference before deletion. _Thanks Jun Ouyang for the patch._
    * change: allow table for multiple values in ngx.header['WWW-Authenticate']. _Thanks BotoX for the patch._
    * optimize: add compatibility for freenginx. _Thanks Sergey A. Osokin for the patch._
    * optimize: add upstream server information to the error log of cosocket. _Thanks lijunlong for the patch._
    * test: fix flaky test at boringssl environment. _Thanks Jun Ouyang for the patch._
    * test: add dnsmasq in ci to avoid flaky test. _Thanks Y.Horie for the patch._
    * doc: fix unencoded characters with ngx.escape_uri. _Thanks Y.Horie for the patch._
    * doc: fixed typo. _Thanks leslie for the patch._
    * doc: typo fixes and delete incorrect statements. _Thanks willmafh for the patch._
    * doc: update copyright. _Thanks lijunlong for the patch._
    * doc: update context for ngx.req.http_version and ngx.req.raw_header to include log_by_lua. _Thanks kurt for the patch._

* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) to v0.0.19
    * feature: add ffi api ngx_stream_lua_ffi_socket_tcp_getfd. _Thanks lijunlong for the patch._
    * feature: add ffi functions ngx_stream_lua_ffi_socket_tcp_get_ssl_pointer() and ngx_stream_lua_ffi_socket_tcp_get_ssl_ctx(). _Thanks lijunlong for the patch._
    * feature: add new API: tcpsock:get_ssl_session. _Thanks lijunlong for the patch._
    * feature: add ngx_stream_lua_ffi_get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add reuseport for binding local port for udp cosocket. _Thanks lijunlong for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: implement serversslhandshake method on downstream sockets (#392) _Thanks Rob Mueller for the patch._
    * feature: proxy_ssl_certificate_by_lua directives _Thanks willmafh for the patch._
    * feature: support custom trusted CA store for cosocket TLS handshake. (#401) _Thanks Walker Zhao for the patch._
    * optimize: add compatibility for freenginx. _Thanks Sergey A. Osokin for the patch._
    * optimize: add upstream server information to the error log of cosocket. _Thanks lijunlong for the patch._
    * bugfix: didn't close cosocket when nginx shutdown timer has been triggered. _Thanks lijunlong for the patch._
    * bugfix: prevent uthread crash by checking coroutine reference before deletion. _Thanks Jun Ouyang for the patch._
    * bugfix: suppress clang warning. _Thanks lijunlong for the patch._

* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.34rc2
    * feature: add fetch server random and master key lua api _Thanks mengxiangwei for the patch._
    * feature: add new API: tcpsock:getsslsession. _Thanks lijunlong for the patch._
    * feature: add precontent_by_lua directives. _Thanks Hanada for the patch._
    * feature: add socket options keepintvl and keepcnt for tcp. _Thanks lijunlong for the patch._
    * feature: add sock:getsslpointer() and sock:getsslctx(). _Thanks lijunlong for the patch._
    * feature: add ssl.get_upstream_ssl_pointer. _Thanks lijunlong for the patch._
    * feature: add tcpsock.getfd() for stream subsystem. _Thanks lijunlong for the patch._
    * feature: add tcpsock:settrustedstore() for per-handshake trusted CAs _Thanks Walker Zhao for the patch._
    * feature: proxy_ssl_certificate_by_lua directives _Thanks willmafh for the patch._
    * feature: support tcpsock:settrustedstore() for stream subsystem. _Thanks Walker Zhao for the patch._
    * feature: update versions of ngx-lua and stream-ngx-lua. _Thanks lijunlong for the patch._
    * optimize: more detail error message when loading wrong lua-nginx-module. _Thanks lijunlong for the patch._
    * bugfix: failed to load socket.lua when building without ssl. _Thanks lijunlong for the patch._
    * bugfix: fixed typo. _Thanks lijunlong for the patch._
    * doc: update copyright. _Thanks lijunlong for the patch._
    * style: typo fixes. _Thanks Chrono for the patch._

* upgraded [luajit2](https://github.com/openresty/luajit2) to v2.1-20260415
    * Add ffi.abi("dualnum"). _Thanks Mike Pall for the patch._
    * Allow mcode allocations outside of the jump range to the support code. _Thanks Mike Pall for the patch._
    * ARM64: Enable unaligned accesses if indicated by the toolchain. _Thanks Mike Pall for the patch._
    * ARM64: Fix disassembly of >2GB branch targets. _Thanks Mike Pall for the patch._
    * ARM64: Fix disassembly of certain sub-word-size loads/stores. _Thanks Mike Pall for the patch._
    * ARM64: More fixes for ARM BTI. _Thanks Mike Pall for the patch._
    * Avoid recording interference due to invocation of VM hooks. _Thanks Mike Pall for the patch._
    * Avoid use of subnormals for internal registry keys. _Thanks Mike Pall for the patch._
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
    * FFI: Fix pointer difference operation on 64 bit platforms. _Thanks Mike Pall for the patch._
    * FFI: Shrink container of packed bitfield. _Thanks Mike Pall for the patch._
    * Fix compiler warning. _Thanks Mike Pall for the patch._
    * Fix edge cases when generating IR for string.byte/sub/find. _Thanks Mike Pall for the patch._
    * Fix edge cases when recording string.byte/sub. _Thanks Mike Pall for the patch._
    * Fix G->jit_base relocation on stack resize. _Thanks Mike Pall for the patch._
    * Fix minilua undefined behavior in bit.tohex. _Thanks Mike Pall for the patch._
    * Fix MSVC LJ_CONSTF declaration. _Thanks Mike Pall for the patch._
    * Fix string.format for limited precision FP conversions. _Thanks Mike Pall for the patch._
    * Fix VM event error handling for finalizers. _Thanks Mike Pall for the patch._
    * Ignore PDB files for git. _Thanks Mike Pall for the patch._
    * Implement double-to-integer conversions for s390x (#256) _Thanks Ilya Leoshkevich for the patch._
    * macOS: Change Mach-O object file layout required by XCode 15.0. _Thanks Mike Pall for the patch._
    * MIPS64: Avoid unaligned load in lj_vm_exit_interp. _Thanks Mike Pall for the patch._
    * PPC: Fix soft-float lj_num2u64(). _Thanks Mike Pall for the patch._
    * Prevent false positive sanitizer warning in unpack(). _Thanks Mike Pall for the patch._
    * Prevent recording of loops with -0 step or NaN values. _Thanks Mike Pall for the patch._
    * Prevent snapshot purge while recording a function header. _Thanks Mike Pall for the patch._
    * Remove compiler flag for FP conversions. Now unnecessary. _Thanks Mike Pall for the patch._
    * Remove pointless GCC/MSVC const function attributes. _Thanks Mike Pall for the patch._
    * Run VM events and finalizers in separate state. _Thanks Mike Pall for the patch._
    * s390x: simplify ceil/floor code (#246) _Thanks J. Neuschäfer for the patch._
    * Unify Lua number to FFI integer conversions. _Thanks Mike Pall for the patch._
    * x64/!LJ_GC64: The allocation limit is required for a no-JIT build, too. _Thanks Mike Pall for the patch._
    * x86/x64: Backport fix for math.min()/math.max() argument check. _Thanks Mike Pall for the patch._

* upgraded [ngx_postgres](https://github.com/openresty/ngx_postgres) to v1.1
    * bugfix: recover postgres peer data when wrapped by another module. _Thanks lijunlong for the patch._

* [lua-rds-parser](https://github.com/openresty/lua-rds-parser):
    * added a .gitattributes file to correct GitHub's language tag. _Thanks Yichun Zhang (agentzh) for the patch._
    * feature: added travis-ci support. _Thanks Ilya Shipitsin for the patch._
    * made the README more pretty. _Thanks Yichun Zhang (agentzh) for the patch._

* upgraded [xss-nginx-module](https://github.com/openresty/xss-nginx-module) to v0.07
    * bugfix: fixed #22 module already loaded. _Thanks lijunlong for the patch._
    * feature: add dynamic build support. _Thanks Su Yang for the patch._

* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql) to v0.30
    * feature: add support for ed25519. _Thanks lijunlong for the patch._

* [form-input-nginx-module](https://github.com/openresty/form-input-nginx-module):
    * doc: nginx compatibility as far as 1.9.15. _Thanks Yichun Zhang (agentzh) for the patch._

* [lua-resty-lock](https://github.com/openresty/lua-resty-lock):
    * doc: correct package status in README.markdown. _Thanks jumper047 for the patch._

* upgraded [echo-nginx-module](https://github.com/openresty/echo-nginx-module) to v0.64
    * doc: update the release date and version in README.md. _Thanks lijunlong for the patch._
    * optimize: add compatibility for freenginx _Thanks lijunlong for the patch._

* [redis2-nginx-module](https://github.com/openresty/redis2-nginx-module):
    * doc: updated the nginx compatibility list. _Thanks Yichun Zhang (agentzh) for the patch._
    * doc: update README.markdown. _Thanks Steve for the patch._
    * travis: clone the lua-resty-core and lua-resty-lrucache repositories. _Thanks Thibault Charbonnier for the patch._

* [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket):
    * doc: fix typo in comments. _Thanks harry-xm for the patch._

* upgraded [lua-upstream-nginx-module](https://github.com/openresty/lua-upstream-nginx-module) to v0.08
    * bugfix: acquire rlock and wlock when needed _Thanks Aleksandr Tuliakov for the patch._
    * dev: make sure we pass tests with nginx 1.13.6. _Thanks Yichun Zhang (agentzh) for the patch._
    * doc: get_upstreams() actually get implicit upstream created by proxy_pass, but doc said that was excluded. _Thanks silence2014 for the patch._
    * doc: small typo fixes in the docs for get_servers. _Thanks chronolaw for the patch._
    * doc: updated get_servers return value. _Thanks Peter Zhu for the patch._
    * travis: added nginx 1.13.6 to the test matrix. _Thanks Yichun Zhang (agentzh) for the patch._
    * travis: fixed build. _Thanks Yichun Zhang (agentzh) for the patch._

* upgraded [lua-resty-upstream-healthcheck](https://github.com/openresty/lua-resty-upstream-healthcheck) to v0.09
    * optimize: update peers in case of using resolve directive _Thanks Aleksandr Tuliakov for the patch._

* upgraded [lua-resty-string](https://github.com/openresty/lua-resty-string) to v0.17
    * feature: add AES-256-CTR binding and reuse buffers. _Thanks ^_^ for the patch._

* upgraded [lua-cjson](https://github.com/openresty/lua-cjson) to v2.1.0.17
    * bugfix: fix truncation of decoded numbers outside lua_Integer's range (#116) _Thanks James McCoy for the patch._
    * feature: add option to allow comments in decode. _Thanks skewb1k for the patch._
    * feature: add option to indent encoded output. _Thanks skewb1k for the patch._
    * bugfix: warning for explicit pointer to int conversion. _Thanks Deyan Dobromirov for the patch._
    * optimize: rename cjson.decode_allow_comments to cjson.decode_allow_comment. _Thanks lijunlong for the patch._

* [lua-resty-shell](https://github.com/openresty/lua-resty-shell):
    * doc: add a description of the default value of the max_size parameter. _Thanks lijunlong for the patch._
    * README.md: add info about default timeout (#21) _Thanks Jeffrey 'jf' Lim for the patch._

* [headers-more-nginx-module](https://github.com/openresty/headers-more-nginx-module):
    * doc: fix syntax by adding a semicolon in README. _Thanks Baba Boota for the patch._
    * doc: update copyright. _Thanks lijunlong for the patch._
    * doc: update latest compatible nginx version. _Thanks lijunlong for the patch._

* [set-misc-nginx-module](https://github.com/openresty/set-misc-nginx-module):
    * doc: several typo fixes in README.markdown. _Thanks willmafh for the patch._

* upgraded [drizzle-nginx-module](https://github.com/openresty/drizzle-nginx-module) to v0.1.13
    * bugfix: stash peer data in module ctx to survive upstream wrappers. (#52) _Thanks lijunlong for the patch._
