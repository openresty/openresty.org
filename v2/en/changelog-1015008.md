<!---
    @title         ChangeLog 1.15.8
    @creator       Thibault Charbonnier
    @created       2018-11-14 01:32 GMT
--->

# Version 1.15.8.1 - dd MM YYYY

* upgraded the [nginx](nginx.html) core to 1.15.8.
    * see the changes here: http://nginx.org/en/CHANGES
* change: we now enable the GC64 mode by default in our bundled LuaJIT build for x86_64 architectures; this can be disabled using `--without-luajit-gc64`. _Thanks Thibault Charbonnier for the patch._
* feature: bundled the [lua-tablepool](https://github.com/openresty/lua-tablepool#readme) library.
* feature: bundled the [lua-resty-signal](https://github.com/openresty/lua-resty-signal#readme) library. _Thanks OpenResty Inc. for supporting this work._
* feature: bundled the [lua-resty-shell](https://github.com/openresty/lua-resty-shell#readme) library. _Thanks OpenResty Inc. for supporting this work._
* feature: ./configure: added new options `--without-stream_ssl_module` and `--without-stream`.
* feature: ./configure: added support for the `-h` option.
* feature: ./configure: support `@rpath` placeholder in OS X. _Thanks Datong Sun for the patch._
* feature: updated the `socket_cloexec` patches to support the [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme) API. _Thanks OpenResty Inc. for supporting this work and spacewander for the development of the patch._
* bugfix: [nginx](nginx.html) did not destroy the cycle memory pool before the daemon process exits. _Thanks Yuansheng Wang for the patch._
* resty-doc indexes: skipped nginx's njs docs due to the use of special xml tags.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.14rc6.
    * feature: added support for ARM64 (Aarch64). _Thanks Cloudflare for sponsoring this work. Thanks Dejiang Zhu and Zexuan Luo for the development of the patch._
    * feature: added the `pool_size` and `backlog` options to the [tcpsock:connect()](https://github.com/openresty/lua-nginx-module#tcpsockconnect) API in order to support backlog queuing in cosocket connection pools. _Thanks OpenResty Inc. for supporting this work and spacewander for the development of the patch._
    * feature: implemented a new [lua_sa_restart](https://github.com/openresty/lua-nginx-module#lua_sa_restart) directive, which sets the `SA_RESTART` flag on [nginx](nginx.html) workers signal dispositions. _Thanks Thibault Charbonnier for the patch._
    * feature: implemented the [tcpsock:receiveany()](https://github.com/openresty/lua-nginx-module#tcpsockreceiveany) upstream cosocket API. _Thanks spacewander for the patch._
    * feature: added support for the [nginx](nginx.html) builtin Link header, which allows for specifying multiple values for this header. _Thanks tokers and Thibault Charbonnier for the patch._
    * feature: errors are now logged when timers fail to run. _Thanks spacewander for the patch._
    * feature: added an [FFI](http://luajit.org/ext_ffi.html) API to support the [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme) API provided by [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). _Thanks OpenResty Inc. for supporting this work and spacewander for the development of the patch._
    * feature: added an [FFI](http://luajit.org/ext_ffi.html) API for retrieving `env` directives values from [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua). _Thanks Thibault Charbonnier for the patch._
    * change: we no longer support the standard Lua 5.1 interpreter (PUC-Rio Lua). It is now strongly recommended to use the OpenResty LuaJIT releases, bundled with the official OpenResty releases.
    * change: we now avoid running [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) in signaller processes and when testing the [nginx](nginx.html) configuration. _Thanks spacewander for the patch._
    * change: we now print an alert when a non openresty-specific version of LuaJIT is detected since many optimizations would be missing. _Thanks Thibault Charbonnier for the patch._
    * change: we now print a warning when writing to the Lua global variable `_G`.
    * change: we now avoid generating the Content-Type response header when getting all response headers. _Thanks spacewander for the patch._
    * bugfix: fixed a segfault in [nginx](nginx.html) core >= 1.15.0 when [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) is used. _Thanks Datong Sun for the patch._
    * bugfix: [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme): [type()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#type) didn't return 'master' in master process. _Thanks spacewander for the patch._
    * bugfix: [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive): worker processes might take too long to gracefully shutdown when the keep alive connections take a long max idle time. _Thanks Dejiang Zhu for the patch._
    * bugfix: setting the request "Host" header should clear any existing cached `$host` variable so that subsequent reads return the expected result.
    * bugfix: inlined Lua code snippets in `nginx.conf` failed to use the Lua source checksum as part of the Lua code cache key.
    * bugfix: silenced `-Wcast-function-type` warnings, allowing for compilation with gcc8. _Thanks Alessandro Ghedini for the patch._
    * doc: noted that [ngx.req.get_method()](https://github.com/openresty/lua-nginx-module#ngxreqget_method) can be used in the [body_filter_by_lua*](https://github.com/openresty/lua-nginx-module#body_filter_by_lua) and [log_by_lua*](https://github.com/openresty/lua-nginx-module#log_by_lua) phases. _Thanks tokers for the patch._
    * doc: updated the docs to reflect the change that we now no longer support the standard Lua 5.1 interpreter in this module. also recommended OpenResty's LuaJIT branch version instead of the stock LuaJIT.
    * doc: mention that [ngx.req.set_body_data()](https://github.com/openresty/lua-nginx-module#ngxreqset_body_data) and [ngx.req.set_body_file()](https://github.com/openresty/lua-nginx-module#ngxreqset_body_file) must read the request body. _Thanks Thibault Charbonnier for the patch._
    * doc: fixed the links to [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block). _Thanks chronolaw for the patch._
    * typo: fixed a debug log in access and rewrite handlers. _Thanks sbhr for the patch._
* upgraded [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) to 0.0.6rc5.
    * feature: added support for ARM64. _Thanks Cloudflare for sponsoring this work. Thanks Dejiang Zhu and Zexuan Luo for the development of the patch._
    * feature: implemented the preread [reqsock:peek()](https://github.com/openresty/stream-lua-nginx-module#reqsockpeek) API. _Thanks Kong Inc. for sponsoring this work. Thanks Datong Sun for the development of the patch._
    * feature: enabled [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) support. _Thanks Kong Inc. for sponsoring the development of this feature, and thanks James Callahan and Datong Sun for the development of the patch._
    * feature: implemented a new [lua_sa_restart](https://github.com/openresty/lua-nginx-module#lua_sa_restart) directive, which sets the `SA_RESTART` flag on [nginx](nginx.html) workers signal dispositions. _Thanks Thibault Charbonnier for the patch._
    * feature: enabled [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme) support. _Thanks Datong Sun for the patch._
    * feature: enabled [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme) support. _Thanks Datong Sun for the patch._
    * feature: enabled [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme) support. _Thanks Thibault Charbonnier for the patch._
    * feature: added an [FFI](http://luajit.org/ext_ffi.html) API for retrieving `env` directives values from [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua). _Thanks Thibault Charbonnier for the patch._
    * change: we now avoid running [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) in signaller processes and when testing the [nginx](nginx.html) configuration. _Thanks Thibault Charbonnier for the patch._
    * change: we now print an alert when a non openresty-specific version of LuaJIT is detected since many optimizations would be missing. _Thanks Thibault Charbonnier for the patch._
    * misc: re-rendered all files to include newly added template header. _Thanks Datong Sun for the patch._
    * doc: added missing links for [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) directives. _Thanks chronolaw for the patch._
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.16rc4.
    * feature: added support for ARM64 (AArch64). _Thanks Cloudflare for sponsoring this work. Thanks Dejiang Zhu and Zexuan Luo for the development of the patch._
    * feature: implemented the [ngx.pipe](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/pipe.md#readme) API which allows spawning processes and communicating with them in a non-blocking way. _Thanks OpenResty Inc. for supporting this work and spacewander for the development of the patch._
    * feature: [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) support for the stream subsystem. _Thanks Kong Inc. for sponsoring the development of this feature, and thanks James Callahan and Datong Sun for the development of the patch._
    * feature: [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme): enabled the FFI-based API for the stream subsystem. _Thanks Datong Sun for the patch._
    * feature: [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme): enabled the FFI-based API for the stream subsystem. _Thanks Datong Sun for the patch._
    * feature: [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme): enabled the FFI-based API for the stream subsystem. _Thanks Thibault Charbonnier for the patch._
    * feature: `os.getenv` is now able to retrieve `env` directives values from within [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua). _Thanks Thibault Charbonnier for the patch._
    * change: we now require OpenResty's LuaJIT branch to work properly on ARM64 since we make use of the `thread.exdata` Lua API.
    * change: increased stack level on subsystem violation error to expose the offending module. _Thanks Datong Sun for the patch._
    * feature: implemented the `ndk.*` API with [FFI](http://luajit.org/ext_ffi.html).
    * bugfix: [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme): [type()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#type) didn't return 'master' in master process. _Thanks spacewander for the patch._
    * bugfix: now we only allow a single version of [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) and [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme). _Thanks spacewander for the patch._
    * optimize: fixed misuses of Lua global variables in our Lua code (caught by the new version of the lj-releng tool).
    * doc: [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme): fixed a typo in the spelling of 'privileged agent'. _Thanks spacewander for the patch._
    * doc: [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme): updated the process type list. _Thanks spacewander for the patch._
    * doc: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme): fixed a typo in the sample code. _Thanks chronolaw for the patch._
    * doc: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): documented the `get_tls1_version_str()` API function.
    * doc: [ngx.semaphore](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/semaphore.md#readme): switch status to production ready.
* upgraded LuaJIT to 2.1-20190131: https://github.com/openresty/luajit2/tags
    * feature: implemented a new [table.isempty()](https://github.com/openresty/luajit2/blob/v2.1-agentzh/README) API. _Thanks OpenResty Inc. for supporting this work._
    * feature: implemented a new [table.isarray()](https://github.com/openresty/luajit2/blob/v2.1-agentzh/README) API. _Thanks OpenResty Inc. for supporting this work._
    * feature: implemented a new [table.nkeys()](https://github.com/openresty/luajit2/blob/v2.1-agentzh/README) API. _Thanks OpenResty Inc. for supporting this work._
    * feature: implemented the new Lua and C API functions for [thread.exdata](https://github.com/openresty/luajit2/blob/v2.1-agentzh/README). This API is used internally by the OpenResty and we advise not to use it yourself in the context of OpenResty. _Thanks Zexuan Luo for preparing the final version of the patch._
    * feature: luajit.h: defined the macro `OPENRESTY_LUAJIT` for our branch of LuaJIT.
    * change: run the LJ_64 branch in asm_hrefk when LUAJIT_USE_VALGRIND and LUAJIT_ENABLE_GC64 are both supplied. _Thanks spacewander for the patch._
    * bugfix: 16-bit MCLink.mapofs and GCtrace.nsnapmap fields would overflow for large Lua programs, leading to segfaults; enlarged them to 32-bit.
    * bugfix: fixed assertion failure "lj_record.c:92: rec_check_slots: Assertion `nslots <= 250' failed" found by stressing our edgelang compiler.
    * doc: documented what we change in our OpenResty branch of LuaJIT.
    * imported Mike Pall's latest changes:
        * Improve luaL_addlstring().
        * Fix os.date() for wider libc strftime() compatibility.
        * Fix MinGW build.
        * DynASM/MIPS: Fix shadowed variable.
        * DynASM/PPC: Fix shadowed variable.
        * Fix overflow of snapshot map offset.
        * Better detection of MinGW build.
        * Actually implement maxirconst trace limit.
        * MIPS/MIPS64: Fix TSETR barrier (again).
        * Fix memory probing allocator to check for valid end address, too.
        * DynASM/x86: Fix vroundps/vroundpd encoding.
        * DynASM: Fix warning.
        * ARM64: Fix exit stub patching.
        * ARM64: Fix write barrier in BC_USETS.
        * Windows: Add UWP support, part 1.
        * From Lua 5.3: assert() accepts any type of error object.
        * x86: Disassemble FMA3 instructions.
        * DynASM/x86: Add FMA3 instructions.
        * PPC/NetBSD: Fix endianess check.
        * x86/x64: Check for jcc when using xor r,r in emit_loadi().
        * [FFI](http://luajit.org/ext_ffi.html): Make FP to U64 conversions match JIT backend behavior.
        * Bump copyright date to 2018.
        * [FFI](http://luajit.org/ext_ffi.html): Add tonumber() specialization for failed conversions.
        * Give expected results for negative non-base-10 numbers in tonumber().
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache#readme) to 0.09rc1.
    * optimize: fixed misuses of Lua global variables in our Lua code (caught by the new version of the lj-releng tool).
* upgraded [lua-resty-lock](https://github.com/openresty/lua-resty-lock#readme) to 0.08rc1.
    * bugfix: we now enforce the use of lua-resty-core's [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme) module to avoid dead locking with the CFunction-based shdict API in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
    * doc: made it clearer that we depend on [lua-resty-core](https://github.com/openresty/lua-resty-core#readme).
    * doc: documented the limitations of certain [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) execution contexts which prohibit yielding.
* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme) to 0.06rc1.
    * bugfix: set_conn() method did not work at all due to a copy&paste error. _Thanks pearzl for the patch._
    * doc: added the [resty.limit.count](https://github.com/openresty/lua-resty-limit-traffic/blob/master/lib/resty/limit/count.md#readme) module to the library's README. _Thanks Thibault Charbonnier for the patch._
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.22rc7.
    * feature: implemented new `--stap` and `--stap-opts` command-line options to trace the underlying [nginx](nginx.html) C process directly (without going through the Perl wrapper layer).
    * feature: implemented a new `--main-conf` command-line option for specifying nginx's main {} context directives directly from the command line. _Thanks Datong Sun for the patch._
    * feature: implemented a new `--gdb-opts` command-line option which implies `--gdb`. The `--valgrind-opts` option also implies `--valgrind`.
