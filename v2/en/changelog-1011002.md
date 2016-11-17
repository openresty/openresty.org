<!---
    @title         ChangeLog 1.11.2
--->

# Version 1.11.2.2 - 17 November 2016

* feature: added new command-line utility, [opm](https://github.com/openresty/opm#readme) of version 0.02, for managing community contributed [OpenResty packages](https://opm.openresty.org/).
* change: now we enable `-DLUAJIT_ENABLE_LUA52COMPAT` in our bundled LuaJIT build by default, which can be disabled by `./configure --without-luajit-lua52`.
note that this change may introduce some minor backeward incompatibilities on the Lua land, see http://luajit.org/extensions.html#lua52 for more details.
* win32: upgraded OpenSSL to 1.0.2j.
* win32: enabled http v2, http addition, http gzip static, http sub, and several other standard [nginx](nginx.html) modules by default.
* updated the help text of `./configure --help` to sync with the new [nginx](nginx.html) 1.11.2 core.
* `make install`: now we also create directories `<prefix>/site/pod/` and `<prefix>/site/manifest/`.
* doc: updated [README-win32.md](https://github.com/openresty/openresty/blob/master/doc/README-win32.md#readme) to reflect recent changes.
* added new component, lua-resty-limit-traffic, which is enabled by default and can be explicitly
disabled via the `--without-lua_resty_limit_traffic` option of the `./configure` script during build.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.7.
    * feature: added a new api function `tcpsock:settimeouts(connect_timeout, send_timeout, read_timeout)`. thanks Dejiang Zhu for the patch.
    * feature: added public C API for 3rd-party [NGINX](nginx.html) C modules to register their own shm-based data structures for the Lua land usage
      (that is, to create custom siblings to [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict)). thanks helloyi and Dejiang Zhu for the patches.
    * feature, bugfix: added new config directive `lua_malloc_trim N` to periodically call `malloc_trim(1)` every `N` requests when `malloc_trim()` is available.
      by default, `lua_malloc_trim 1000` is configured. this should fix the glibc oddity of holding too much freed memory
      when it fails to use `brk()` to allocate memory in the data segment. thanks Shuxin Yang for the proposal.
    * bugfix: segmentation faults might happen when [ngx.exec()](https://github.com/openresty/lua-nginx-module#ngxexec) was fed with unsafe URIs. thanks Jayce LiuChuan for the patch.
    * bugfix: [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header): skips setting multi-value headers for bad requests to avoid segfaults. thanks Emil Stolarsky for the patch.
    * change: [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) are now only allowed in the `http {}` context.
      use of these session hooks in the `server {}` scope did not make much sense since server name dispatch happens
      *after* ssl session resumption anyway. thanks Dejiang Zhu for the patch.
    * optimize: optimized the [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict) node struct memory layout which can save 8 bytes for every key-value pair on 64-bit systems, for example.
    * doc: log level constants are also available in [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) and [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) contexts. thanks kraml for the report and detailyang for the patch.
    * doc: documented the support of 307 status argument value in [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect).
    * doc: use `*_by_lua_block {}` in all the configuration examples. thanks pj.vegan for the patch.
    * doc: documented how to easily test the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) locally with a modern web browser.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.9.
    * feature: implemented the [split()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#split) method in the [ngx.re](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/re.md#readme) module.
    * optimize: [resty.core.shdict](https://github.com/openresty/lua-resty-core/blob/master/lib/resty/core/shdict.md#readme): removed one unused top-level Lua variable.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.32.
    * bugfix: [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers): skips setting multi-value headers for bad requests to avoid segfaults.
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.26.
    * optimize: hmset: use `select` to avoid creating temporary Lua tables and
      to be more friendly to LuaJIT's JIT compiler. thanks spacewander for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.18.
    * optimize: removed unused local Lua variables. thanks Thijs Schreijer for the patch.
    * change: stops seeding the random generator. This is user's responsibility now. thanks Thijs Schreijer for the patch.
* upgraded [lua-resty-mysql](https://github.com/openresty/lua-resty-mysql#readme) to 0.17.
    * bugfix: fixed the Lua exception "attempt to perform arithmetic on local len (a boolean value)". thanks Dmitry Kuzmin for the report.
    * doc: renamed the "errno" return value to "errcode" for consistency. thanks Soojin Nam for the patch.
* upgraded [lua-resty-websocket](https://github.com/openresty/lua-resty-websocket#readme) to 0.06.
    * optimize: minor code optimizations and cleanups from Aapo Talvensaari.
    * doc: fixed copy&paste mistakes found by rock59.
* upgraded [lua-resty-upload](https://github.com/openresty/lua-resty-upload#readme) to 0.10.
    * feature: the `new()` method now accepts an optional 2nd arg to configure the max line size.
    * optimize: use the `$http_content_type` [nginx](nginx.html) built-in variable instead of
      `ngx.req.get_headers()["content-type"]`. thanks Soojin Nam for the patch.
    * optimize: minor optimization from Will Bond.
    * optimize: various minor optimizations and cleanups from Soojin Nam, Will Bond, Aapo Talvensaari, and hamza.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.16.
    * feature: resty: forwarded more UNIX signals. thanks Zekai.Zheng for the patch.
    * feature: restydoc: added new option `-r DIR` for specifying a custom root directory.
    * feature: restydoc: added support for comment syntax, `# ...`, in the `resty.index` file.
    * bugfix: resty: literal single quotes led to [nginx](nginx.html) configuration errors in -e option values. thanks spacewander for the report.
    * bugfix: restydoc-index: we did not ignore POD files in the output directory if they are also inside the input directory.
    * bugfix: restydoc-index: we should only ignore `pod` directories in the output directory, not the whole output directory.
    * bugfix: restydoc-index: we swallowed the section name right after the `Table of Contents` section (if any).
* upgraded LuaJIT to v2.1-20161104: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * LJ_GC64: Fix HREF for pointers.
        * LJ_FR2: Fix slot 1 handling.
        * Fix GC step size calculation.
        * LJ_GC64: Fix `jit.on/off`.
        * Fix `-jp=a` mode for builtins.
        * ARM: Fix BLX encoding for Thumb interworking calls.
        * Initialize uv->immutable for upvalues of loaded chunks.
        * Windows/x86: Add MSVC flags for debug build with exception interop.
        * Fix exit status for `luajit -b`.
        * Must preserve `J->fold.ins` (fins) around call to `lj_ir_ksimd()`.
        * Emit bytecode in .c/.h files with unsigned char type.
        * Set arg table before evaluating `LUA_INIT` and `-e` chunks.
        * Fix for cdata vs. non-cdata arithmetics/comparisons.
        * Fix unused vars etc. in internal Lua files.
        * Properly clean up state before restart of trace assembly.
        * Drop leftover regs in 'for' iterator assignment, too.
        * MIPS: Support MIPS16 interlinking.
        * x64/LJ_GC64: Fix code generation for IR_KNULL call argument.
        * Fix PHI remarking in SINK pass.
        * LJ_GC64: Set correct nil value when clearing a cdata finalizer.
        * LJ_GC64: Ensure all IR slot fields are initialized.
        * LJ_GC64: Allow optional use of the system memory allocator.
        * Fix Valgrind suppressions.
        * Don't try to record outermost `pcall()` return to lower frame.
        * MIPS: Fix build failures and warnings.
        * Proper fix for LJ_GC64 changes to `asm_href()`.
        * MIPS64, part 1: Add MIPS64 support to interpreter.
        * DynASM/MIPS: Add missing MIPS64 instructions.
        * x64/LJ_GC64: Fix `__call` metamethod for tailcall.
        * Fix collateral damage from LJ_GC64 changes to asm_href().
        * Use MAP_TRYFIXED for the probing memory allocator, if available.
        * x86: Don't spill an explicit REF_BASE in the IR.
        * x64/LJ_GC64: Add missing backend support and enable JIT compilation.
        * LJ_FR2: Add support for trace recording and snapshots.
        * Embed 64 bit constants directly in the IR, using two slots.
        * Simplify GCtrace * reference embedding for trace stitching.
        * Make the IR immovable after assembly.
        * Add guard for obscure aliasing between open upvalues and SSA slots.
        * Workaround for MinGW headers lacking some exception definitions.
        * Remove assumption that lj_math_random_step() doesn't clobber FPRs.

#  Version 1.11.2.1 - 24 August 2016

* upgraded the [Nginx](nginx.html) core to 1.11.2.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: bundled the sess_set_get_cb_yield patch for OpenSSL to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) directives of [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* win32: we now use pcre 8.39 and openssl 1.0.2h in our official build.
* feature: applied the `ssl_pending_session.patch` to the [nginx](nginx.html) core to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* feature: added `<openresty-prefix>/site/lualib/` to the default Lua module search paths used by OpenResty. This location is for 3rd-party Lua modules so that the users will not pollute the `<openresty-prefix>/lualib/` directory with non-standard Lua module files.
* feature: now we create the `<openresty-prefix>/bin/openresty` symlink which points to `<openresty-prefix>/nginx/sbin/nginx` to avoid polluting the `PATH` environment with the name "nginx".
* feature: added the `upstream_timeout_fields` patch to the [nginx](nginx.html) core to allow efficient per-request connect/send/read timeout settings for individual upstream requests and retries.
* feature: added the official LuaJIT documentation from LuaJIT 2.1 to our `restydoc` indexes.
* feature: added the Lua 5.1 reference manual from lua 5.1.5 to our restydoc indexes.
* bugfix: special characters like spaces in [nginx](nginx.html) configure option values (like `--with-pcre-opt` and `--with-openssl-opt`)  were not passed correctly. thanks Andreas Lubbe for the report.
* change: now we use our own version of default `index.html` and `50x.html` pages.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.6.
    * feature: added new shdict methods: [lpush](https://github.com/openresty/lua-nginx-module#ngxshareddictlpush),
[lpop](https://github.com/openresty/lua-nginx-module#ngxshareddictlpop),
[rpush](https://github.com/openresty/lua-nginx-module#ngxshareddictrpush),
[rpop](https://github.com/openresty/lua-nginx-module#ngxshareddictrpop),
[llen](https://github.com/openresty/lua-nginx-module#ngxshareddictllen)
for manipulating list-typed values. these methods can
be used in the same way as the redis commands of the same names. Essentially we now have shared memory based queues now. each queue is indexed by a key. thanks
Dejiang Zhu for the patch.
    * feature: implemented [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) configuration directives for doing (distributed) caching of SSL sessions (via SSL session IDs) for downstream connections. thanks Zi Lin for the patches.
    * feature: added pure C API for setting upstream request connect/send/read timeouts in [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) on a per session basis. thanks Jianhao Dai for the original patch.
    * feature: ssl: add [FFI](http://luajit.org/ext_ffi.html) functions to parse certs and private keys to cdata. With the current [FFI](http://luajit.org/ext_ffi.html) functions the certificate chain and the private key are parsed from DER every time they are set into the SSL state. Now we can cache the parsed certs and private keys as cdata objects directly. These new functions make it possible to avoid the DER -> OpenSSL parsing. Thanks Alessandro Ghedini for the patch.
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: allow [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) to receive nil args. thanks Thibault Charbonnier for the patch.
    * bugfix: `*_by_lua_file`: did not support absolute file paths on non-UNIX systems like Win32. thanks Someguynamedpie for the report and the original patch.
    * bugfix: fake connections did not carry a proper connection number. thanks Piotr Sikora for the patch.
    * bugfix: "lua_check_client_abort on" broke HTTP/2 requests.
    * bugfix: `ngx_http_lua_ffi_ssl_create_ocsp_request`: we did not clear the openssl stack errors in the right place.
    * bugfix: [ngx.sha1_bin()](https://github.com/openresty/lua-nginx-module#ngxsha1_bin) was always disabled with [nginx](nginx.html) 1.11.2+ due to incompatible changes in [nginx](nginx.html) 1.11.2+. thanks manwe for the report.
    * bugfix: segfaults might happen when calling [ngx.log()](https://github.com/openresty/lua-nginx-module#ngxlog) in [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) and error_log was configured with syslog. thanks Jonathan Serafini and Greg Karékinian for the report.
    * bugfix: fixed a typo in the error handling of the `SSL_get_ex_new_index()` call for our ssl ctx index. thanks Jie Chen for the report.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header) and [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module#ngxreqclear_header) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed crashes in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) for HTTP/2 requests. now we always throw out a Lua exception in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) when being called in HTTP/2 requests.
    * bugfix: specifying the C macro `NGX_LUA_NO_FFI_API` broke the build. thanks jsopenrb for the report.
    * doc: [ngx.worker.count()](https://github.com/openresty/lua-nginx-module#ngxworkercount) is available in the [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) context.
    * doc: documented that [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) does not work in HTTP/2 requests.
    * doc: typo fixes from Otto Kekäläinen and Nick Galbreath.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.8.
    * updated the `resty.core.shdict` Lua module to reflect the recent addition of list-typed shdict values in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: added the [ngx.ssl.session](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl/session.md#readme) module for the contexts [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block). thanks Zi Lin for the patches.
    * feature: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme): added new API functions [set_timeouts()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#set_timeouts) for setting per-session connect/send/read timeouts for the current upstream request and subsequent retries. thanks Jianhao Dai for the patch.
    * feature: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): add new API functions [parse_pem_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_cert), [parse_pem_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_priv_key), [set_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_cert), and [set_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_priv_key). thanks Alessandro Ghedini for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.17.
    * feature: now we support parsing answer records in all the answer sections (`AN`, `NS`, and `AR`). thanks Zekai Zheng for the patch.
    * optimize: commented out 3 lines of useless Lua code in `parse_response()`.
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.25.
    * feature: now this module automatically generate Lua methods for *any* Redis commands the caller attempts to use.
The lazily generated Lua methods are cached in the Lua module table for faster subsequent uses.
In theory, any Redis commands in existing Redis or even future Redis servers can work out of the box. thanks spacewander for the patch.
* upgraded [ngx_lua_upstream](https://github.com/openresty/lua-upstream-nginx-module#readme) to 0.06.
    *  feature: added [upstream.current_upstream_name()](https://github.com/openresty/lua-upstream-nginx-module#current_upstream_name) to return the proxy target used in the current request. thanks Justin Li for the patch.
    * minor Lua table initialization optimizations from Scott Francis.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.13.
    * bugfix: restydoc: pod2man from older perl versions (like 5.8) does not support `-u` option. we should be smarter here.
    * bugfix: when resty/restydoc/restydoc-index were invoked through symlinks, they might fail to locate the [nginx](nginx.html) executable of openresty.
    * bugfix: POD errors might get displayed in pod2man with older versions of perl (like perl 5.20.2). thanks Dominic for the patch.
    * bugfix: pod2man might abort with a "Can't open file" error with perl 5.24+.
    * bugfix: restydoc-index: improved the seciton name normalization for the documentation indexes.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.60.
    * bugfix: fixed compilation failures when specifying the C compiler option `-DDDEBUG=2`. thanks amdei for the report.
    * bugfix: fixed crashes in `$echo_client_request_headers` for HTTP/2 requests. thanks dilyanpalauzov for the report.
Now $echo_client_request_headers always evaluates to an empty value (not found) in HTTP/2 requests.
    * doc: make it clearer when to use the `--` form.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.31.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed a typo in an error message. thanks Albert Strasheim for the patch.
* upgraded [ngx_set_misc](https://github.com/openresty/set-misc-nginx-module#readme) to 0.31.
    * bugfix: the [set_sha1](https://github.com/openresty/set-misc-nginx-module#set_sha1) directive is always disabled when working with [nginx](nginx.html) 1.11.2+ due to recent changes in the new [nginx](nginx.html) cores.
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.06.
    * doc: we do require [ngx_http_ssl_module](http://nginx.org/en/docs/http/ngx_http_ssl_module.html) to work properly.

See [ChangeLog 1.9.15](changelog-1009015.html) for change log for [OpenResty](openresty.html) 1.9.15.x.
