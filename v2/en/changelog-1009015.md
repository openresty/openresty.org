<!---
    @title         ChangeLog 1.9.15
    @creator       Yichun Zhang
    @created       2015-12-20 00:18 GMT
--->


#  Version 1.9.15.1 - 17 May 2016

* upgraded the [Nginx](nginx.html) core to 1.9.15.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: added restydoc documentation indexes for the official nginx core and most of the official openresty components.
* upgraded [ngx_lua](https://github.com/openresty/ -nginx-module#readme) to 0.10.4.
    * feature: linux x64: now we try limiting the growth of the data segment of the [nginx](nginx.html)
processes to preserve as much lowest address space for LuaJIT as possible. thanks Shuxin Yang for the help.
    * bugfix: [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) did not
honor `http {}` top-level configurations like
[lua_ssl_verify_depth](https://github.com/openresty/lua-nginx-module#lua_ssl_verify_depth)
and [lua_ssl_trusted_certificate](https://github.com/openresty/lua-nginx-module#lua_ssl_trusted_certificate).
thanks Vladimir Shaykovskiy for the report.
    * bugfix: [ngx.exit()](https://github.com/openresty/lua-nginx-module#ngxexit) could not be used in the context
of [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) when
[lua-resty-core](https://github.com/openresty/lua-resty-core#readme) was used.
    * bugfix: `*_by_lua_block`: fixed Lua long bracket parsing at buffer boundaries. thanks Maxim Ivanov and Tom Thorogood for the report.
    * bugfix: [ngx.req.append_body()](https://github.com/openresty/lua-nginx-module#ngxreqappend_body) might enter infinite loops when
[ngx.req.init_body()](https://github.com/openresty/lua-nginx-module#ngxreqinit_body) has not specified a buffer size and the request
header `Content-Length` is 0 (or [client_body_buffer_size](http://nginx.org/r/client_body_buffer_size) is configured to 0).
thanks Hai for the report and Dejiang Zhu for the patch.
    * bugfix: [ngx.re.match](https://github.com/openresty/lua-nginx-module#ngxrematch): the 5th argument hid the 4th one.
thanks iorichina for the report and rako9000 for the original patch.
    * bugfix: [ngx.worker.id()](https://github.com/openresty/lua-nginx-module#ngxworkerid) should return
`nil` in non-worker processes like nginx's cache managers. thanks Weixie Cui for the patch.
    * bugfix: fixed a memory leak in [cert_pem_to_der()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#cert_pem_to_der), caught by valgrind.
    * bugfix: ignore unexpected closing long-brackets in `*_by_lua_block` directives. thanks Thibault Charbonnier for the patch.
    * bugfix: changing peers in [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block)
might lead to stale values of [$upstream_addr](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_upstream_addr).
    * bugfix: clear errors in [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme)
and [ngx.ocsp](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ocsp.md#readme) functions to avoid flooding [nginx](nginx.html) error logs. thanks Hamish for the original patch.
    * bugfix: [tcpsock:sslhandshake()](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake)
did not correctly check argument count. thanks Ilya Shipitsin for the report.
    * bugfix: [tcpsock:sslhandshake()](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake)
accepts up to 5 arguments now (including the object itself).
    * bugfix: assignment to [ngx.status](https://github.com/openresty/lua-nginx-module#ngxstatus)
might not affect subsequent [ngx.status](https://github.com/openresty/lua-nginx-module#ngxstatus)
reads when [error_page](http://nginx.org/r/error_page) had already
taken place. thanks wangwei4514 for the report.
    * refactor: refactored the implementation of the [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme) API.
thanks Weixie Cui for the patch.
    * doc: typo fixes from Christos Trochalakis.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.6.
    * feature: implemented [ngx.worker.id()](https://github.com/openresty/lua-nginx-module#ngxworkerid)
and [ngx.worker.count()](https://github.com/openresty/lua-nginx-module#ngxworkercount)
with [FFI](http://luajit.org/ext_ffi.html). thanks Yuansheng Wang for the patch.
    * bugfix: Lua's tail-call optimization might unexpectedly make
[ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme) objects
get garbage-collected prematurely even when there're still waiters.
this could happen when [lua_check_client_abort](https://github.com/openresty/lua-nginx-module#lua_check_client_abort) is enabled. thanks Dejiang Zhu for the patch.
    * doc: [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme): documented the "timeout"
argument of `wait()` in more detail.
    * doc: typo fixes from Alessandro Ghedini.
    * doc: formatting fixes from ms2008.
* upgraded [lua-resty-memcached](https://github.com/openresty/lua-resty-memcached#readme) to 0.14.
    * optimize: reduced [table.concat()](http://www.lua.org/manual/5.1/manual.html#pdf-table.concat) calls
while constructing memcached requests, which can lead to fewer Lua string creation operations.
    * bugfix: `get()` did not return server error responses. thanks Lorenz Bauer for the report.
    * bugfix: `gets()` did not return server error responses. thanks Lorenz Bauer for the report.
    * bugfix: `get()`: simplified the error messages so that the caller can check the error more easily.
    * feature: `set_timeout()` now returns the result of the operation. thanks Guanlan Dai for the report.
* upgraded resty-cli to 0.07rc3.
    * added new command-line utility, restydoc, for viewing OpenResty/Nginx documentation on the terminal (inspired by Perl's `perldoc` utility) via `groff` (used by `man` as well).
    * added new command-line utility, md2pod.pl, for converting GitHub-flavored Markdown source to Perl's POD format.
    * added new command-line utility, restydoc-index, for generating the documentation indexes by scanning Markdown and POD document
files in user-specified directories, which can be used by the restydoc tool.
    * added new command-line utility, nginx-xml2pod, for converting NGINX's official XML-formatted documentation to Perl's POD format.
* upgraded [lua-cjson](https://github.com/openresty/lua-cjson#readme) to 2.1.0.4.
    * feature: added the `cjson.as_array` metamethod to enforce empty array encoding. thanks Thibault Charbonnier for the patch.
    * bugfix: fixed the 16 decimal number encoding assertion. thanks Thibault Charbonnier for the patch.
    * doc: added proper documentation for OpenResty's fork of [lua-cjson](https://github.com/openresty/lua-cjson#readme). thanks Thibault Charbonnier for the patch.
* upgraded [LuaJIT](luajit.html) to v2.1-20160517: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * Rollback due to `HREFK` + load fwd must restore guardemit state.
        * Always merge snapshots without instructions inbetween.
        * [FFI](http://luajit.org/ext_ffi.html): Parse `#line NN` and `#NN`.
        * MIPS: Switch to dual-number mode. Fix soft-float interpreter.
        * PS4: Switch default build to amalgamated and `LJ_GC64` mode.
        * MIPS: Add soft-float support to JIT compiler backend.
        * Don't allocate unused 2nd result register in JIT compiler backend.
        * Use internal implementation for converting FP numbers to strings.
        * MIPS soft-float: Fix code generation for HREF.
        * ARM: Fix build problem with external frame unwinding.
        * Fix display of `NULL` (light)userdata in `-jdump`.
        * x64/LJ_GC64: Fix JIT glue code in interpreter.
        * x86: Detect `BMI2` instruction support.
        * x86: Generate `BMI2` shifts and rotates, if available.
        * MIPS: Fix use of ffgccheck delay slots in interpreter.
        * Windows/x64/LJ_GC64: Fix `math.frexp()` and `math.modf()`.
        * Cygwin: Allow cross-builds to non-Cygwin targets.
        * Fix recording of `select(n, ...)` with off-trace varargs.
        * x86: Improve disassembly of BMI2 instructions.
        * x64/LJ_GC64: Fix `BC_UCLO` check for fast-path.
        * MIPS: Fix `BC_ISNEXT` fallback path.
        * Rewrite memory block allocator.

          Use a mix of linear probing and pseudo-random probing.
Workaround for 1GB `MAP_32BIT` limit on Linux/x64. Now 2GB with `!LJ_GC64`.
Enforce 128TB `LJ_GC64` limit for > 47 bit memory layouts (ARM64).
        * x86/x64: Search for exit jumps with instruction length decoder.
        * Fix handling of non-numeric strings in arithmetic coercions.
        * Fix GCC 6 -Wmisleading-indentation warnings.
        * Constrain value range of `lj_ir_kptr()` to unsigned 32 bit pointers.
* upgraded [ngx_srcache](https://github.com/openresty/srcache-nginx-module#readme) to 0.31.
    * bugfix: this module should not depend on builtin modules like [ngx_http_ssi](http://nginx.org/en/docs/http/ngx_http_ssi_module.html)
and [ngx_http_addition](http://nginx.org/en/docs/http/ngx_http_addition_module.html) to pull
in the ngx_http_postpone module to function properly. thanks Dejiang Zhu for the original patch.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`. thanks Hiroaki Nakamura for the original patch.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
    * doc: clarified what `0s` means for the default expiration time. thanks matlloyd for the patch.
    * doc: documented the memcached maximum key length and the [set_md5](https://github.com/openresty/set-misc-nginx-module#set_md5) directive.
thanks Jérémy Lal for the patch.
* upgraded [ngx_form_input](https://github.com/calio/form-input-nginx-module#readme) to 0.12.
    * bugfix: avoided use of C global variables in configuration phase since it might cause problems in failed HUP reloads.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.
* upgraded [ngx_devel_kit](https://github.com/simpl/ngx_devel_kit#readme) to 0.3.0.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`. thanks Andrei Belov for the patch.
    * bugfix: compiler errors: comparison between signed and unsigned integer expressions. thanks Xiaochen Wang for the patch.
    * doc: added the new section "Modules using NDK".
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.05.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.30.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`. thanks Sjir Bagmeijer for the original patch.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.59.
    * feature: added support for [nginx](nginx.html) 1.9.11+ when no [nginx](nginx.html) builtin modules pull in the ngx_http_postpone module.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: fixed warnings with C compilers without variadic macro support.
* upgraded [ngx_memc](https://github.com/openresty/memc-nginx-module#readme) to 0.17.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded [ngx_redis2](https://github.com/openresty/redis2-nginx-module#readme) to 0.13.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded [ngx_iconv](https://github.com/calio/iconv-nginx-module#readme) to 0.14.
    * feature: this module can now be compiled as a dynamic module with [NGINX](nginx.html) 1.9.11+ via the
`--with-dynamic-module=PATH` option of `./configure`.

See [ChangeLog 1.9.7](changelog-1009007.html) for change log for [OpenResty](openresty.html) 1.9.7.x.
