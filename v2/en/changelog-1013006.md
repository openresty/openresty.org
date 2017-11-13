<!---
    @title         ChangeLog 1.13.6
--->

# Version 1.13.6.1 - 13 November 2017

* upgraded the [Nginx](nginx.html) core to 1.13.6.
    * see the changes here: http://nginx.org/en/CHANGES
* bundled the new component, [ngx_stream_lua_module](https://github.com/openresty/stream-lua-nginx-module) 0.0.4, which is also enabled by default. One can disable this 3rd-party [Nginx](nginx.html) C module by passing `--without-stream_lua_module` to the `./configure` script. We provide compatible Lua API with [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) wherever it makes sense. Currently we support [content_by_lua*](https://github.com/openresty/lua-nginx-module#content_by_lua), preread_by_lua* (similar to [ngx_lua](https://github.com/openresty/lua-nginx-module#readme)'s [access_by_lua*](https://github.com/openresty/lua-nginx-module#access_by_lua) ), [log_by_lua*](https://github.com/openresty/lua-nginx-module#log_by_lua), and [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) in the stream subsystem. thanks Mashape Inc. for sponsoring the [OpenResty Inc.](https://openresty.com) team to do the development work on rewriting [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) for recent [nginx](nginx.html) core version.
* change: applied a patch to the [nginx](nginx.html) core to make sure the "server" header in HTTP/2 response shows "openresty" when the `server_tokens` diretive is turned off.
* feature: added [nginx](nginx.html) core patches needed by [ngx_stream_lua_module](https://github.com/openresty/stream-lua-nginx-module#readme)'s [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block).
* win32: upgraded PCRE to 8.41.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.11.
    * feature: shdict: added pure C API for getting free page size and total capacity for [lua-resty-core](https://github.com/openresty/lua-resty-core#readme). thanks Hiroaki Nakamura for the patch.
    * feature: added pure C functions for [shdict:ttl](https://github.com/openresty/lua-nginx-module#ngxshareddictttl)() and [shdict:expire](https://github.com/openresty/lua-nginx-module#ngxshareddictexpire)() API functions. thanks Thibault Charbonnier for the patch.
    * bugfix: `*_by_lua_block` directives might break [nginx](nginx.html) config dump (`-T` switch). thanks Oleg A. Mamontov for the patch.
    * bugfix: segmentation faults might happen when pipelined http requests are used in the downsteram connection. thanks Gao Yan for the report.
    * bugfix: the ssl connections might be drained and reused prematurely when [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) or [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) were used. this might lead to segmentation faults under load. thanks guanglinlv for the report and the original patch.
    * bugfix: [tcpsock:connect()](https://github.com/openresty/lua-nginx-module#tcpsockconnect): when the [nginx](nginx.html) resolver's `send()` immediately fails without yielding, we didn't clean up the coroutine ctx state properly. This might lead to segmentation faults. thanks xiaocang for the report and root for the patch.
    * bugfix: added fallthrough comment to silence GCC 7's `-Wimplicit-fallthrough`. thanks Andriy Kornatskyy for the report and spacewander for the patch.
    * bugfix: [tcpsock:settimeout](https://github.com/openresty/lua-nginx-module#tcpsocksettimeout), [tcpsock:settimeouts](https://github.com/openresty/lua-nginx-module#tcpsocksettimeouts): throws an error when the timeout argument values overflow. Here we only support timeout values no greater than the max value of a 32 bits integer. thanks spacewander for the patch.
    * doc: added "413 Request Entity Too Large" to the possible short circuit response list. thanks Datong Sun for the patch.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.13.
    * feature: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme) now supports the [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme); also disabled all the other [FFI](http://luajit.org/ext_ffi.html) APIs for the stream subsystem for now.
    * feature: [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme): added new methods [shdict:free_space](https://github.com/openresty/lua-nginx-module#ngxshareddictfree_space)() and [shdict:capacity](https://github.com/openresty/lua-nginx-module#ngxshareddictcapacity)(). thanks Hiroaki Nakamura for the patch.
    * feature: implemented the [ngx.re.gmatch](https://github.com/openresty/lua-nginx-module#ngxregmatch) function with [FFI](http://luajit.org/ext_ffi.html). thanks spacewander for the patch.
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme): fix an edge-case where [re.split()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#split) might not destroy compiled regexes. thanks Thibault Charbonnier for the patch.
    * feature: implemented the [shdict:ttl](https://github.com/openresty/lua-nginx-module#ngxshareddictttl)() and [shdict:expire](https://github.com/openresty/lua-nginx-module#ngxshareddictexpire)() API functions using [FFI](http://luajit.org/ext_ffi.html).
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.20.
    * feature: allows `RRTYPE` values larger than 255. thanks Peter Wu for the patch.
* upgraded [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic#readme) to 0.05.
    * feature: added new module [resty.limit.count](https://github.com/openresty/lua-resty-limit-traffic/blob/master/lib/resty/limit/count.md#readme) for GitHub API style request count limiting. thanks Ke Zhu for the original patch and Ming Wen for the followup tweaks.
    * bugfix: [resty.limit.traffic](https://github.com/openresty/lua-resty-limit-traffic/blob/master/lib/resty/limit/traffic.md#readme): we might not uncommit previous limiters if a limiter got rejected while committing a state. thanks Thibault Charbonnier for the patch.
    * bugfix: [resty.limit.conn](https://github.com/openresty/lua-resty-limit-traffic/blob/master/lib/resty/limit/conn.md#readme): we incorrectly specified the exceeded connection count as the initial value for the shdict key decrement which may lead to dead locks when the key has been evicted in very busy systems. thanks bug had appeared in v0.04.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.20.
    * feature: resty: impelented the `-j off` option to turn off the JIT compiler.
    * feature: resty: implemented the `-j v` and `-j dump` options similar to luajit's.
    * feature: resty: added new command-line option `-l LIB` to mimic lua and luajit -l parameter. thanks Michal Cichra for the patch.
    * bugfix: resty: handle `SIGPIPE` ourselves by simply killing the process. thanks Ingy dot Net for the report.
    * bugfix: resty: hot looping Lua scripts failed to respond to the `INT` signal.
* upgraded [opm](https://github.com/openresty/opm#readme) to 0.0.4.
    * bugfix: [opm](https://github.com/openresty/opm#readme): when curl uses HTTP/2 by default [opm](https://github.com/openresty/opm#readme) would complain about "bad response status line received". thanks Donal Byrne and Andrew Redden for the report.
    * debug: [opm](https://github.com/openresty/opm#readme): added more details in the "bad response status line received from server" error.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.33.
    * feature: add wildcard match support for [more_clear_input_headers](https://github.com/openresty/headers-more-nginx-module#more_clear_input_headers).
    * doc: fixed [more_clear_input_headers](https://github.com/openresty/headers-more-nginx-module#more_clear_input_headers) usage examples. thanks Daniel Paniagua for the patch.
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.07.
    * bugfix: fixed one potential memory leak in an error condition. thanks dyu for the patch.
* upgraded [ngx_rds_json](https://github.com/openresty/rds-json-nginx-module#readme) to 0.15.
    * bugfix: fixed warnings with C compilers without variadic macro support.
    * doc: added context info for all the config directives.
* upgraded [ngx_rds_csv](https://github.com/openresty/rds-csv-nginx-module#readme) to 0.08.
    * tests: varous changes in the test suite.
* upgraded LuaJIT to v2.1-20171103: https://github.com/openresty/luajit2/tags
    * optimize: use more appressive JIT compiler parameters as the default to help large OpenResty Lua apps. We now use the following jit.opt defaults: `maxtrace=8000 maxrecord=16000 minstitch=3 maxmcode=40960 -- in KB`.
    * imported Mike Pall's latest changes:
        * `LJ_GC64`: Make `ASMREF_L` references 64 bit.
        * `LJ_GC64`: Fix ir_khash for non-string GCobj.
        * DynASM/x86: Fix potential `REL_A` overflow. Thanks to Joshua Haberman.
        * MIPS64: Hide internal function.
        * x64/`LJ_GC64`: Fix type-check-only variant of SLOAD. Thanks to Peter Cawley.
        * PPC: Add soft-float support to JIT compiler backend. Contributed by Djordje Kovacevic and Stefan Pejic from RT-RK.com. Sponsored by Cisco Systems, Inc.
        * x64/`LJ_GC64`: Fix fallback case of `asm_fuseloadk64()`. Contributed by Peter Cawley.

See [ChangeLog 1.11.2](changelog-1011002.html) for change log for [OpenResty](openresty.html) 1.11.2.x.
