<!---
    @title         ChangeLog 1.7.10
    @creator       Yichun Zhang
    @created       2015-02-19 22:50 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-07-04 11:13 GMT
    @changes       43
--->


#  Version 1.7.10.2 - 3 July 2015
* bugfix: ./configure: fixed the `--without-http_rewrite_module` option by disabling
[Nginx Devel Kit](nginx-devel-kit.html) automatically; also automatically disable
the [Encrypted Session Nginx Module](encrypted-session-nginx-module.html) when
[Nginx Devel Kit](nginx-devel-kit.html) is disabled.
* bugfix: ./configure: removed hacks to work around an old bug in [Lua Nginx Module](lua-nginx-module.html)'s
build system (just recently fixed in [Lua Nginx Module](lua-nginx-module.html)).
* bugfix: [LuaJIT](luajit.html) compilation might fail when old gcc 4 compilers
are used (like gcc 4.1.0). this regression had appeared in [OpenResty](openresty.html) 1.7.7.2.
thanks aseiot for the report.
* upgraded [Resty CLI](resty-cli.html) to 0.03.
    * bugfix: resty: command-line options did not pass to the user Lua script unless `--` was intentionally specified. now standalone Lua scripts with a shebang line work out of the box (if [LuaJIT](luajit.html) is used, which is the default). thanks neomantra for the report.
    * bugfix: resty: now sends `error_log` to `stderr` instead of the system-specific path `/dev/stderr`. thanks Evan Wies for the patch.
    * doc: added the new section "Test Suite" as per Enrique Garcia's request.
    * tests: fixed test failures on Mac OS X. thanks Enrique García for the report.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.16.
    * feature: [ngx.encode_base64()](https://github.com/openresty/lua-nginx-module#ngxencode_base64): added support for the "no_padding" boolean argument to disable padding when a true value is specified. thanks Shuxin Yang for the patch. this feature can be used for streaming base64 computation.
    * feature: fixed compilation failures with nginx 1.9.0. thanks Charles R. Portwood II for the original patch.
    * feature: removed the dead code for the old `NGX_THREADS` mode which broke the new nginx (1.7.11+) with thread pool support. thanks Tatsuhiko Kubo for the patch.
    * bugfix: use of `ngx_http_image_filter_module` might lead to request hang due to duplicate header filter invocations. thanks Antony Dovgal for the report.
    * bugfix: we should never automatically set `Content-Type` on 304 responses. thanks Simon Eskildsen for the patch.
    * bugfix: raw downstream cosockets did not support full-deplexing. thanks aviramc for the bug report and the original patch. this issue affected WebSockets too.
    * bugfix: we did not always discard the request body if the user Lua handlers didn't, which might cause 400 error pages for keep-alive or pipelined requests. thanks Shuxin Yang for the original patch.
    * bugfix: [ngx.resp.get_headers()](https://github.com/openresty/lua-nginx-module#ngxrespget_headers): some built-in headers were not accessible via lower-case. thanks Nick Muerdter for the patch.
    * bugfix: we might still pick up Lua/[LuaJIT](luajit.html) headers/libraries in the paths specified by nginx ./configure's `--with-cc-opt=OPTS` and `--with-ld-opt=OPTS` optons even when the LUAJIT_INC/LUAJIT_LIB or LUA_INC/LUA_LIB environments were explicitly specified.
    * bugfix: config: we might miss the linker option `-ldl` when we shouldn't. this might lead to build failures.
    * bugfix: access nonexistent fields in the "ngx" table in [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) could lead to the exception "no request object found" because of the overreacting `__index` metamethod of the "ngx" table.
    * bugfix: fixed compilation failures with very old versions of PCRE, like 4.5.
    * doc: fixed a bug in an example where both [rewrite_by_lua](https://github.com/openresty/lua-nginx-module#rewrite_by_lua) and [content_by_lua](https://github.com/openresty/lua-nginx-module#content_by_lua) produce response outputs. thanks fengidri for the report.
    * doc: fixed the context for the [lua_need_request_body](https://github.com/openresty/lua-nginx-module#lua_need_request_body) directive. thanks Tatsuhiko Kubo for the patch.
    * doc: fixed the code sample for [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect) to reflect recent changes there. thanks Zi Lin for the report.
    * doc: added a note on possible uninitialized variables for short-circuited requests. thanks Simon Eskildsen for the patch.
    * tests: fixed nondeterminism due to unordered Lua table iterations. thanks Markus Linnala for the patch.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.26.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads` (this was the only change included in the new `v0.26` release tag as compared to the old `v0.26` release tag).
    * optimize: removed the unused C function `ngx_http_headers_more_rm_header`. thanks Markus Linnala for the catch.
    * doc: made it clear that [more_set_headers](https://github.com/openresty/headers-more-nginx-module#more_set_headers) always override existing headers with the same name.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.29.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * tests: add openssl hmac defensive test. thanks Markus Linnala for the patch.
* upgraded [Lua Upstream Nginx Module](lua-upstream-nginx-module.html) to 0.03.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * doc: README.md: fixed the [get_backup_peers](https://github.com/openresty/lua-upstream-nginx-module#get_backup_peers) example. thanks Jakub Kramarz for the patch.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.30.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.9.
    * feature: fixed compilation errors with nginx 1.9.1+.
    * feature: automatic libdrizzle path discovery for Ubuntu 12.04. thanks Mathew Heard for the patch.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc6.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: use `ngx_abs()` instead of `abs()` to fix one clang warning (`-Wabsolute-value`).
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.06.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: fixed two clang `-Wconditional-uninitialized` warnings.
    * doc: improved the documentation a lot.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.14.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * doc: improved the documentation a lot.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.58.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: we no longer break on subrequests when the `ngx_http_ssi_module` is diasbled. thanks Anthony Ryan for the patch.
    * bugfix: use of `ngx_http_image_filter_module` might lead to request hang due to duplicate header filter invocations.
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.16.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: fixed clang warnings on "unused variables" in the Ragel generated source.
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.12.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: fixed clang warnings on "unused variables" in the Ragel generated source.
    * bugfix: always set the response status code in case of bad statuses like 504. thanks Kaito Sys for the report.
    * doc: typo fixes from Karan Chaudhary.
* upgraded [Encrypted Session Nginx Module](encrypted-session-nginx-module.html) to 0.04.
    * feature: added debugging logs for expiration times during encryption and decription. also adjusted other debug logging messages a bit. thanks Kalpesh Patel for requesting this.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: fixed warnings from the Microsoft C/C++ compiler. thanks Edwin Cleton for the report.
    * doc: improved the documentation a lot.
* upgraded [Iconv Nginx Module](iconv-nginx-module.html) to 0.11.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
* upgraded [Array Var Nginx Module](array-var-nginx-module.html) to 0.04.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * doc: improved the documentation a lot.
* upgraded [Xss Nginx Module](xss-nginx-module.html) to 0.05.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
    * bugfix: fixed clang warnings on "unused variables" in the Ragel generated source.
    * doc: improved the documentation a lot.
* upgraded [Form Input Nginx Module](form-input-nginx-module.html) to 0.11.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
* upgraded [Coolkit Nginx Module](coolkit-nginx-module.html) to 0.2rc3.
    * feature: fixed compilation failures with nginx 1.7.11+ configured with `--with-threads`.
* upgraded [LuaJIT](luajit.html) to v2.1-20150622: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * Add Xbox One port.
        * Fix narrowing of TOBIT.
        * x64: Allow building without external unwinder.
        * x86/x64: Fix argument check for bit shifts.
        * x64: Add LJ_GC64 mode interpreter. Enable this mode with: make `XCFLAGS=-DLUAJIT_ENABLE_GC64`
        * Disable trace stitching (for now) due to a design mistake.
        * Fix stack check in narrowing optimization.
        * ARM64: Fix math.floor/math.ceil for string args.
        * DynASM/PPC: Add sub/shift/rotate/clear instruction aliases.
        * DynASM/PPC: Add support for parameterized shifts/masks.
        * PPC: Fix cross-endian builds.
        * PPC: Fix write barrier in BC_TSETR.
        * Fix Lua/C API typecheck error for special indexes.
        * FFI: Fix FOLD rule for TOBIT + CONV num.u32.
        * ARM: Handle more arch defines.
        * Properly fail unsupported cross-compile to MIPS64.

#  Version 1.7.10.1 - 28 February 2015
* upgraded the [Nginx](nginx.html) core to 1.7.10.
    * see the changes here: http://nginx.org/en/CHANGES
* bugfix: applied the upstream_filter_finalize patch to the nginx core to fix
corrupted `$upstream_response_time` variable values when `filter_finalize` and
[error_page](http://nginx.org/r/error_page) are both used. thanks Daniel Bento
for the report and Maxim Dounin for the patch.
* bugfix: ./configure: added `--without-http_upstream_least_conn_module` and
`--without-http_upstream_keepalive_module` to the usage text (for `--help`)
to reflect recent changes in the nginx core. thanks Seyhun Cavus for the report.
* bugfix: ./configure: renamed the `--without-http_limit_zone_module` option
to `--without-http_limit_conn_module` to reflect the change in recent nginx
cores. thanks Seyhun Cavus for the report.
* upgraded [LuaJIT](luajit.html) to v2.1-20150223: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * x86/x64: fix code generation for fused test/arith ops. thanks to Alexander Nasonov and AFL.
        * fix string to number conversion. thanks to Lesley De Cruz.
        * fix lexer error for chunks without tokens.
        * LJ_FR2: fix bytecode generation for method lookups.
        * FFI: Prevent DSE across `ffi.string()`.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.15.
    * bugfix: the value of the Location response header set by [ngx.redirect()](https://github.com/openresty/lua-nginx-module#ngxredirect) or the [ngx.header.HEADER](https://github.com/openresty/lua-nginx-module#ngxheaderheader) API might get overwritten by nginx's header filter to the fully qualified form (with the scheme and host parts).
    * bugfix: [lua_shared_dict](https://github.com/openresty/lua-nginx-module#lua_shared_dict): use of Lua numbers as the value in shared dict might lead to unaligned accesses which could lead to crashes on architectures requiring data alignment (like ARMv6). thanks Shuxin Yang for the fix and thanks Stefan Parvu and Brandon B for the report.
    * bugfix: using error codes (`ngx.ERROR` or >=300) in [ngx.exit()](https://github.com/openresty/lua-nginx-module#ngxexit) in [header_filter_by_lua*](https://github.com/openresty/lua-nginx-module#header_filter_by_lua) might lead to Lua stack overflow.
    * feature: improved the debugging event logging for timers created by [ngx.timer.at()](https://github.com/openresty/lua-nginx-module#ngxtimerat).
    * optimize: fixed padding holes in our struct memory layouts for 64-bit systems to save a little memory.
    * optimize: [header_filter_by_lua*](https://github.com/openresty/lua-nginx-module#header_filter_by_lua): removed a piece of useless code. thanks Zi Lin for the report.
    * doc: emphasized the capability of using nginx variables in the Lua file path in [content_by_lua_file](https://github.com/openresty/lua-nginx-module#content_by_lua_file)/[rewrite_by_lua_file](https://github.com/openresty/lua-nginx-module#content_by_lua_file)/[access_by_lua_file](https://github.com/openresty/lua-nginx-module#access_by_lua).
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.29.
    * bugfix: upon cache hits, we might let the nginx core's header filter module overwrite the `Location` response header's values like "/foo/bar" to the fully-qualified form (like "http://test.com/foo/bar"). thanks AlexClineBB for the report.
* upgraded [Resty CLI](resty-cli.html) to 0.02.
    * bugfix: we did not explicitly specify the pid file path, which may conflict with the default pid path if the user compiles nginx with the `--pid-path=PATH` ./configure option. thanks fancyrabbit for the report.
See [ChangeLog 1.7.7](changelog-1007007.html) for change log for [OpenResty](openresty.html) 1.7.7.x.
