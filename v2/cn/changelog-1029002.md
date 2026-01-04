<!---
    @title         ChangeLog for 1.29.2.x
    @creator       Junlong Li
    @created       2026-01-04 14:33 GMT
--->

* Nginx core
    * Upgrade from nginx 1.27.1 to 1.29.2.

* OpenSSL
    * upgraded from version 3.4.1 to 3.5.4.

* PCRE
    * upgraded from version 10.44 to 10.46.

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
    * feature: add support for nginx-1.29.2. _Thanks lijunlong for the patch._
    * feature: add support for nginx-1.29.2. _Thanks lijunlong for the patch._
    * feature: add support for tcp/udp bind. _Thanks alonbg for the patch._
    * feature: ngx_stream_lua_ffi_req_shared_ssl_ciphers(). _Thanks Ri Shen Chen for the patch._
    * feature: proxy_ssl_verify_by_lua directives. _Thanks willmafh for the patch._
    * bugfix: failed to build with openssl 1.x.x and boringssl. _Thanks lijunlong for the patch._
    * bugfix: failed to build with openssl < 3.0.2. _Thanks lijunlong for the patch._
    * bugfix: fixed typo. _Thanks willmafh for the patch._
    * bugfix: fixed warning. _Thanks lijunlong for the patch._
    * bugfix resolve unused function warning in BoringSSL builds. _Thanks swananan for the patch._
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
    * bugfix: fix issue #499，to avoid unexpect assertion when c func return FFI_OK immediately. _Thanks akf00000 for the patch._
    * doc: add doc for get_client_hello_ext_present(). _Thanks lijunlong for the patch._
    * doc: fixed typo. _Thanks lijunlong for the patch._
    * style: fixed coding style. _Thanks lijunlong for the patch._

* [luajit2](https://github.com/openresty/luajit2) v2.1-20251022
    * Add compatibility string coercion for fp:seek() argument. _Thanks Mike Pall for the patch._
    * Add GNU/Hurd build support. _Thanks Mike Pall for the patch._
    * ARM64: Fix pass-by-value struct calling conventions. _Thanks Mike Pall for the patch._
    * ARM: Fix soft-float math.min()/math.max(). _Thanks Mike Pall for the patch._
    * Avoid out-of-range PC for stack overflow error from snapshot restore. _Thanks Mike Pall for the patch._
    * Avoid out-of-range PC for stack overflow error from snapshot restore. _Thanks Mike Pall for the patch._
    * Avoid unpatching bytecode twice after a trace flush. _Thanks Mike Pall for the patch._
    * bugfix: table.clone can't work after commit 538a82133ad. _Thanks lijunlong for the patch._
    * Change handling of nil value markers in template tables. _Thanks Mike Pall for the patch._
    * Change handling of nil value markers in template tables. _Thanks Mike Pall for the patch._
    * FFI: Add pre-declared int128_t, uint128_t, __int128 types. _Thanks Mike Pall for the patch._
    * FFI: Fix dangling CType references (again). _Thanks Mike Pall for the patch._
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

* [lua-resty-shell](https://github.com/openresty/stream-lua-nginx-module)
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
