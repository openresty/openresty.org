<!---
    @title         ChangeLog for 1.27.1.2
    @creator       Johnny Wang
    @created       2025-04-14 14:33 GMT
--->

# Version 1.27.1.2 - 14 Mar 2025

* upgraded [lua-nginx-module](https://github.com/openresty/lua-nginx-module) to v0.10.28
    * bugfix: remove http2 hardcode limitation in `ngx.location` subrequest API. _Thanks Jun Ouyang for the patch._
    * chore: more accurate error message. _Thanks willmafh for the patch._
    * doc:  clarify base64 for url encoding and padding. _Thanks Thijs Schreijer for the patch._
    * doc: clarify the backlog option (#2367) _Thanks Thijs Schreijer for the patch._
    * fix: removed null terminator. _Thanks n-bes for the patch._
    * feature: implemented ngx_http_lua_ffi_decode_base64mime. _Thanks WenMing for the patch._
    * style: remove duplicate check in ngx.send_headers _Thanks spacewander for the patch._
    * feature: add ngx.resp.set_status(status, reason). _Thanks lijunlong for the patch._
    * tests: add support for openssl3.0. _Thanks lijunlong for the patch._
    * optimize: removed unreachable code in ngx_http_lua_send_http10_headers(). _Thanks lijunlong for the patch._
    * bugfix: `setkeepalive` failure on TLSv1.3 _Thanks Zhefeng C. for the patch._
    * doc: Redraw directives png (#2353) _Thanks xiaobiaozhao for the patch._
    * doc: improve grammar. _Thanks Josh Soref for the patch._
* upgraded [stream-lua-nginx-module](https://github.com/openresty/stream-lua-nginx-module) to v0.0.16
    * feature: enable ngx.var at the ssl_certificate_by_lua and ssl_client_hello_by_lua. _Thanks lijunlong for the patch._
    * bugfix: `setkeepalive` failure on TLSv1.3 _Thanks Zhefeng C. for the patch._
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core) to v0.1.31
    * feature: implemented decode_base64mime. _Thanks WenMing for the patch._
    * feature: add ngx.resp.set_status(status, reason). _Thanks lijunlong for the patch._
    * feature: update nginx to v1.27.1. _Thanks lijunlong for the patch._
* upgraded [luajit2](https://github.com/openresty/luajit2) to v2.1-20250117
    * Fix recording of BC_VARG. _Thanks Mike Pall for the patch._
    * Reject negative getfenv()/setfenv() levels to prevent compiler warning. _Thanks Mike Pall for the patch._
    * Bump copyright date. _Thanks Mike Pall for the patch._
    * Force fallback source name for stripped bytecode. _Thanks Mike Pall for the patch._
    * Remove dependency on <limits.h>. _Thanks Mike Pall for the patch._
    * Restore state when recording __concat metamethod throws OOM. _Thanks Mike Pall for the patch._
    * MIPS64: Fix pcall() error case. _Thanks Mike Pall for the patch._
    * Fix detection of inconsistent renames due to sunk values. _Thanks Mike Pall for the patch._
    * Windows: Allow amalgamated static builds with msvcbuild.bat. _Thanks Mike Pall for the patch._
    * Always close profiler output file. _Thanks Mike Pall for the patch._
    * Fix override of INSTALL_LJLIBD in the presence of DESTDIR. _Thanks Mike Pall for the patch._
    * Fix bit op coercion for shifts in DUALNUM builds. _Thanks Mike Pall for the patch._
    * macOS: Remove obsolete -single_module flag. _Thanks Mike Pall for the patch._
    * macOS: Workaround for buggy XCode 15.0 - 15.2 linker. _Thanks Mike Pall for the patch._
    * macOS: Fix macOS 15 / Clang 16 build. _Thanks Mike Pall for the patch._
    * Fix bit op coercion in DUALNUM builds. _Thanks Mike Pall for the patch._
    * Fix compiliation of getmetatable() for UDTYPE_IO_FILE. _Thanks Mike Pall for the patch._
    * Remove ancient RtlUnwindEx workaround for MinGW64. _Thanks Mike Pall for the patch._
    * Drop unused function wrapper. _Thanks Mike Pall for the patch._
    * Fix limit check in narrow_conv_backprop(). _Thanks Mike Pall for the patch._
    * Always use IRT_NIL for IR_TBAR. _Thanks Mike Pall for the patch._
    * ARM64: Use ldr literal to load FP constants. _Thanks Mike Pall for the patch._
    * FFI: Add missing coercion when recording 64-bit bit.*(). _Thanks Mike Pall for the patch._
    * ARM64: Make tobit conversions match JIT backend behavior. _Thanks Mike Pall for the patch._
    * ARM: Make hard-float tobit conversions match JIT backend behavior. _Thanks Mike Pall for the patch._
    * FFI: Drop finalizer table rehash after GC cycle. _Thanks Mike Pall for the patch._
    * Fix another potential file descriptor leak in luaL_loadfile*(). _Thanks Mike Pall for the patch._
    * MIPS32: Fix little-endian IR_RETF. _Thanks Mike Pall for the patch._
    * Correctly close VM state after early OOM during open. _Thanks Mike Pall for the patch._
    * Fix potential file descriptor leak in luaL_loadfile*(). _Thanks Mike Pall for the patch._
