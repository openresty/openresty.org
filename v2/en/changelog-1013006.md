<!---
    @title         ChangeLog 1.13.6
--->

# Version 1.13.6.2 - 22 April 2018

* win64: distributing official 64-bit Windows binary packages for OpenResty using the MSYS2/MinGW toolchain.
* win32: now we build our official 32-bit Windows binary packages for OpenResty using the MSYS2/MinGW toolchain.
* win32: upgraded pcre to 8.42 and openssl to 1.1.0h.
* optimize: now the openresty build system (`./configure`) automatically patches the resty command-line utility to use its own [nginx](nginx.html) binary so that it does not have to compute it at runtime (which is a bit expensive). this saves about 10ms (from for total 20ms to 10ms) for resty's startup time, as measured on a mid-2015 MBP. That's 50% reduction in total startup time! Yay!
* win32/win64: enabled [ngx_stream_ssl_preread_module](http://nginx.org/en/docs/stream/ngx_stream_ssl_preread_module.html) in our binary builds.
* bugfix: ./configure: relative paths in --add-dynamic-module=PATH option did not work. thanks catatsuy for the patch.
* feature: added a patch for the [nginx](nginx.html) core to add the `local=on` and `local=/path/to/resolv.conf` options to the standard "resolver" config directive.  This can enable the use of system-level nameserver configurations of /etc/resolv.conf, for example, in nginx's own nonblocking DNS resolver. thanks Datong Sun for the patch.
* feature: added the `socket_cloexec` patch to ensure most of the [nginx](nginx.html) connections could be closed before child process terminates. thanks spacewander for the patch.
* feature: added patches to the [nginx](nginx.html) core to make sure [ngx_stream_ssl_preread_module](http://nginx.org/en/docs/stream/ngx_stream_ssl_preread_module.html) will not skip the rest of the preread phase when SNI server name parsing was successful. thanks Datong Sun for the patch.
* feature: ./configure: updated the stream subsystem related options from [nginx](nginx.html) 1.13.6. thanks hy05190134 for the patch.
* feature: added the SSL `sess_set_get_cb` yielding support patch for OpenSSL 1.1.0d and beyond. thanks spacewander for the patch.
* feature: applied the `init_cycle_pool_release` patch to [nginx](nginx.html) 1.13.6+ cores to make it valgrind or asan clean.
* bugfix: we incorrectly removed the existing Makefile even for `./configure --help`. thanks spacewander for the patch.
* feature: added information about OpenResty's commercial support in the default index.html page.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.21.
    * resty: got rid of prerequisite perl modules to improve startup time. Startup time has been significantly reduced on `*NIX` systems. No improvment on Win32 though. On my mid-2015 MBP, the `resty -e "print(1)"` command's total time can drop from ~36ms to ~10ms.
    *bugfix: when the signal is received but the child process is already gone, resty incorrectly returned non-zero return code and output "No such process" error. thanks Datong Sun for the patch.
* upgraded [opm](https://github.com/openresty/opm#readme) to 0.0.5.
    * bugfix: [opm](https://github.com/openresty/opm#readme) get: curl via HTTP proxies would complain about "bad response status line received". The first "Connection established" response might not come with any response header entries at all.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.13.
    * feature: [ngx.req.get_post_args()](https://github.com/openresty/lua-nginx-module#ngxreqget_post_args), [ngx.req.get_uri_args()](https://github.com/openresty/lua-nginx-module#ngxreqget_uri_args), [ngx.req.get_headers()](https://github.com/openresty/lua-nginx-module#ngxreqget_headers), [ngx.resp.get_headers()](https://github.com/openresty/lua-nginx-module#ngxrespget_headers), and [ngx.decode_args()](https://github.com/openresty/lua-nginx-module#ngxdecode_args) now would return an error string, "truncated", when the input exceeds the `max_args`/`max_headers` limits.
    * feature: added support for the OpenSSL 1.1.0 serires. thanks Alessandro Ghedini for the original patch and the subsequent polishment work from Dejiang Zhu and spacewander.
    * feature: added the `init_ttl` argument to the pure C function for the [shdict:incr](https://github.com/openresty/lua-nginx-module#ngxshareddictincr)() API. thanks Thibault Charbonnier for the patch.
    * feature: added support for the 308 status code in [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect). thanks Mikhail Senin for the patch.
    * feature: ssl: support enabling TLSv1.3 via the [lua_ssl_protocols](https://github.com/openresty/lua-nginx-module#lua_ssl_protocols) config directive. thanks Alessandro Ghedini for the patch.
    * feature: `ngx_http_lua_ffi_set_resp_header()`: now add an override flag argument to control whether to override existing resp headers.  this feature is required by the new [ngx.resp](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/resp.md#readme) module's `add_header()` Lua API (in lua-resty-core). thanks spacewander for the patch.
    * feature: allowed sending boolean and nil values in cosockets. thanks spacewander for the patch.
    * feature: api.h: exposed the `ngx_http_lua_ffi_str_t` C data type for other [Nginx](nginx.html) C modules.
    * feature: logged the tcp cosocket's remote end address when [tcpsock:connect()](https://github.com/openresty/lua-nginx-module#tcpsockconnect) times out and `lua_socket_log_errors` is on. This feature makes debug connect timeout errors easier, since domain name may map to different ip address in different time. thanks spacewander for the patch.
    * bugfix: [ngx.resp.get_headers()](https://github.com/openresty/lua-nginx-module#ngxrespget_headers): the `max_headers` limit did not cover builtin headers.
    * bugfix: `ngx_http_lua_ffi_ssl_set_serialized_session()`: avoided memory leak when calling it repeatly.
    * bugfix: we now throw a Lua exception when [ngx.location.capture*](https://github.com/openresty/lua-nginx-module#ngxlocationcapture) Lua API is used inside an HTTP2 request since it is known to lead to hanging.
    * bugfix: [nginx](nginx.html) rewrite directive may initiate internal redirects without clearing any module ctx and [rewrite_by_lua*](https://github.com/openresty/lua-nginx-module#rewrite_by_lua) handlers might think it was re-entered and thus it might lead to request hang. thanks twistedfall for the report.
    * bugfix: avoided sharing the same code object for identical Lua inlined code chunks in different phases due to chunk name conflicts. thanks yandongxiao for the report and spacewander for the patch.
    * bugfix: [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header): the first part of the header would be discarded when using single LF as delimiter and the number of headers is large enough. thanks tokers for the patch.
    * bugfix: pure C API for ngx.var assignment: we failed to output the error message length. this might lead to error buffer overreads. thanks Ka-Hing Cheung for the patch.
    * bugfix: the upper bound of port ranges should be 65535 instead of 65536. thanks spacewander for the patch.
    * bugfix: we did not always free up all connections when cleaning up socket pools. thanks spacewander for the patch.
    * bugfix: use of lua-resty-core's [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme) API in [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) might lead to memory issues during [nginx](nginx.html) HUP reload when no [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict) directives are used and the regex cache is enabled.
    * change: switched to `SSL_version()` calls from `TLS1_get_version()`. `TLS1_get_version` is a simple wrapper for `SSL_version` that returns 0 when used with DTLS. However, it was removed from BoringSSL in 2015 so instead use `SSL_version` directly. Note: BoringSSL is never an officially supported target for this module. `ngx_http_lua_ffi_ssl_get_tls1_version` can never be reached with DTLS so the behaviour is the same. thanks Tom Thorogood for the patch.
    * optimize: switched exptime argument type to 'long' in the shdict [FFI](http://luajit.org/ext_ffi.html) API to mitigate potential overflows. thanks Thibault Charbonnier for the patch.
    * optimize: avoided the string copy in `ngx_http_lua_ffi_req_get_method_name()`.
    * optimize: corrected the initial table size of req socket objects. thanks spacewander for the patch.
    * optimize: destroy the Lua VM and avoid running any [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) code inside cache helper processes. thanks spacewander for the patch.
    * doc: fixed an error message typo in `set_der_priv_key()`. thanks Tom Thorogood for the patch.
    * doc: mentioned that OpenResty includes its own version of LuaJIT which is specifically optmized and enhanced for OpenResty.
    * doc: some typo fixes from hongliang.
    * doc: setting ngx.header.HEADER no longer throws out an exception when the header is already sent out; it now just logs an error message. thanks yandongxiao for the patch.
    * doc: typo fixes from yandongxiao.
    * doc: typo fixes from tan jinhua.
    * doc: fixed a typo in a code comment. thanks Alex Zhang for the patch.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.15.
    * feature: implemented [ngx.resp](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/resp.md#readme) module and its function add_header(). The [ngx.resp](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/resp.md#readme) module's `add_header` works like the `add_header` [Nginx](nginx.html) directive.  Unlike the `ngx.header.HEADER=` API, this method appends new header to the old one instead of overriding any existing ones.  Unlike the `add_header` directive, this method overrides the builtin header instead of appending to it. thanks spacewander for the patch.
    * feature: the [FFI](http://luajit.org/ext_ffi.html) version of the [ngx.req.get_uri_args()](https://github.com/openresty/lua-nginx-module#ngxreqget_uri_args) and [ngx.req.get_headers()](https://github.com/openresty/lua-nginx-module#ngxreqget_headers) API functions now would return an error string, "truncated", when the input exceeds the `max_args`/`max_headers` limits.
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme): fixed a `split()` corner case when successtive separator characters are at the end of the subject string.
    * bugfix: shdict: switched exptime argument type to 'long' to mitigate potential overflows.
    * bugfix: [ngx.ssl.session](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl/session.md#readme): avoided memory leaks when calling set_serialized_session repeatly. thanks spacewander for the patch.
    * optimize: avoided an extra string copy in [ngx.req](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/req.md#readme).get_method(). thanks spacewander for the patch.
    * change: replaced `return error()` with `error()` to avoid stack unwinding upon Lua exceptions. this should give much better Lua backtrace for the errors. thanks spacewander for the patch.
    * bugfix: [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme): fixed a split() edge-case when using control characters in the regex. thanks Thibault Charbonnier for the patch.
    * feature: [shdict:incr](https://github.com/openresty/lua-nginx-module#ngxshareddictincr)(): added the "init_ttl" argument to set the ttl of values when they are first created via the "init" argument. thanks Thibault Charbonnier for the patch.
    * feature: re-implemented the remaining time related Lua APIs with [FFI](http://luajit.org/ext_ffi.html) (like ngx.update_time, ngx.http_time, ngx.parse_http_time, and etc.). thanks spacewander for the patch.
    * feature: [ngx.errlog](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/errlog.md#readme): added the raw_log() API function to allow the building of custom logging facilities. thanks Thibault Charbonnier for the patch.
    * feature: added new API function `get_master_pid()` to the [ngx.process](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/process.md#readme) module. thanks chronolaw for the patch.
    * doc: typo fixes from chronolaw.
    * feature: added new resty.core.phase module to include the pure [FFI](http://luajit.org/ext_ffi.html) version of the [ngx.get_phase()](https://github.com/openresty/lua-nginx-module#ngxget_phase) API. thanks Robert Paprocki for the patch.
    * feature: added new ngx.base64 Lua module with the functions encode_base64url() and decode_base64url(). thanks Datong Sn for the patch.
    * bugfix: resty.core.var: ngx.var.VAR assignment might over-read the error msg buffer. thanks Ka-Hing Cheung for the patch.
    * optimize: use plain text [string.find](http://www.lua.org/manual/5.1/manual.html#pdf-string.find) calls when we mean it.
    * feature: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): added new raw_client_addr() Lua API function. thanks 王军伟 for the patch.
* upgraded [lua-cjson](https://github.com/openresty/lua-cjson#readme) to 2.1.0.6.
    * optimize: improved forward-compatibility with older versions of Lua/LuaJIT. thanks Thibault Charbonnier for the patch.
    * bugfix: fixed the C compiler warning "SO C90 forbids mixed declarations and code" on older operating systems.
    * feature: set `cjson.array_mt` on decoded JSON arrays. this can be turned on via `cjson.decode_array_with_array_mt(true)`. off by default for backward compatibility. thanks Thibault Charbonnier for the patch.
    * feature: added new cjson.array_mt metatable to allow enforcing JSON array encoding. thanks Thibault Charbonnier for the patch.
    * bugfix: fixed a -Wsign-compare compiler warning. thanks gnought for the patch.
* upgraded [lua-resty-lrucache](https://github.com/openresty/lua-resty-lrucache#readme) to 0.08.
    * feature: added new method flush_all() to flush all the data in an existing cache object. thanks yang.yang for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.21.
    * refactor: cleaned up some variable names and locals. thanks Thijs Schreijer for the patch.
    * bugfix: fixed issues with retrans not being honoured upon connection failures. thanks Thijs Schreijer for the patch.
    * feature: improved error reporting, making it more precise, and returning errors of previous tries. thanks Thijs Schreijer for the patch.
    * bugfix: fix parsing state after SOA record. Correct parsing of Additional Records failed due to a bad parsing state after processing a SOA record in the Authorative nameservers section. DNS response based on "dig @ns1.google.com SOA google.com". thanks Peter Wu for the patch.
    * bugfix: fix typo in SOA record field "minimum". Rename "mininum" to "minimum", fixes issue in original feature added with [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) v0.19rc1.
* upgraded lua-resty-string to 0.11.
    * feature: resty.aes: added compaibility with OpenSSL 1.1.0+. thanks spacewander for the patch.
* upgraded [ngx_stream_lua](https://github.com/openresty/stream-lua-nginx-module#readme) to 0.0.5.
    * feature: we now have raw request downstream cosocket support for scripting UDP servers. thanks Datong Sun for the patch.
    * feature: added the preread handler postponing feature. thanks Datong Sun for the patch.
    * feature: added new config directive lua_add_variable to allow adding changeable. thanks Datong Sun for the patch.
* upgraded [ngx_set_misc](https://github.com/openresty/set-misc-nginx-module#readme) to 0.32.
    * bugfix: [set_quote_pgsql_str](https://github.com/openresty/set-misc-nginx-module#set_quote_pgsql_str): we did not escape the `$` character. thanks Yuansheng Wang for the patch.
    * refactor: made `ngx_http_pg_utf_islegal()` much better.
    * bugfix: fixed the `-Wimplicit-fallthrough` warinings from GCC 7. thanks Andrei Belov for the patch.
* upgraded [ngx_redis2](https://github.com/openresty/redis2-nginx-module#readme) to 0.15.
    * bugfix: `ragel -G2` genreates C code which results in `-Werror=implicit-fallthrough` compilation errors at least with gcc 7.2. switched to `ragel -T1` instaed.
* upgraded [ngx_memc](https://github.com/openresty/memc-nginx-module#readme) to 0.19
    * bugfix: `ragel -G2` genreates C code which results in `-Werror=implicit-fallthrough` compilation errors at least with gcc 7.2. switched to `ragel -T1` instaed.
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.08.
    * feature: added support for OpenSSL 1.1.0. thanks spacewander for the patch.
* upgraded [ngx_rds_csv](https://github.com/openresty/rds-csv-nginx-module#readme) to 0.09.
    * bugfix: fixed the `-Werror=implicit-fallthrough` compilation errors at least with gcc 7.2.
* upgraded [ngx_drizzle](https://github.com/openresty/drizzle-nginx-module#readme) to 0.1.11.
    * bugfix: fixed the `-Werror=implicit-fallthrough` compilation errors at least with gcc 7.2.
* upgraded ngx_xss to 0.06.
    * bugfix: `ragel -G2` genreates C code which results in `-Werror=implicit-fallthrough` compilation errors at least with gcc 7.2. switched to `ragel -T1` instaed.
    * bugfix: fixed errors and warnings with C compilers without variadic macro support.
* upgraded LuaJIT to 2.1-20180419: https://github.com/openresty/luajit2/tags
    * feature: implemented new API function `jit.prngstate()` for reading or setting the current PRNG state number used in the JIT compiler.
    * feature: implemented the table.clone() builtin Lua API. This change only support shallow clone. e.g

        local tab_clone = require "table.clone"
        local x = {x=12, y={5, 6, 7}}
        local y = tab_clone(x)
        -- ... use y here ...

    We observed 7% over-all speedup in the edgelang-fan compiler's compiling speed whose Lua is generated by the fanlang compiler. thanks Shuxin Yang for the patch and OpenResty Inc. for sponsoring this work.
    * imported Mike Pall's latest changes:
        * DynASM/x86: Add BMI1 and BMI2 instructions.
        * Fix rechaining of pseudo-resurrected string keys.
        * Clear stack after `print_jit_status()` in CLI.
        * Fix GCC 7 `-Wimplicit-fallthrough` warnings.
        * [FFI](http://luajit.org/ext_ffi.html): Don't assert on `#1LL` (Lua 5.2 compatibility mode only).
        * MIPS64: Fix soft-float +-0.0 vs. +-0.0 comparison.
        * Fix LuaJIT API docs for `LUAJIT_MODE_*`.
        * Fix ARMv8 (32 bit subset) detection.
        * Fix `string.format("%c", 0)`.
        * Fix `IR_BUFPUT` assembly.
        * MIPS64: Fix `xpcall()` error case.
        * ARM64: Fix `xpcall()` error case.
        * Fix saved bytecode encapsulated in ELF objects.
        * MIPS64: Fix register allocation in assembly of HREF.
        * ARM64: Fix assembly of HREFK.
        * Fix FOLD rule for strength reduction of widening.

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
