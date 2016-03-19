<!---
    @title         ChangeLog 1.7.7
    @creator       Yichun Zhang
    @created       2014-11-22 05:19 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-02-04 21:24 GMT
    @changes       46
--->


#  Version 1.7.7.2 - 4 February 2015
* bundled the "resty" command-line utility (version 0.01)  from the resty-cli
project: https://github.com/openresty/resty-cli
    * bugfix: the resty utility could not start when the nginx was built with `./configure --conf-path=PATH` where `PATH` was not `conf/nginx.conf`. thanks Zhengyi Lai for the report.
    * feature: added support for user-supplied arguments which the user Lua scripts can access via the global Lua table "arg", just as in the "lua" and "luajit" command-line utilities. thanks Guanlan Dai for the patch.
    * feature: added new command-line option `--nginx=PATH` to allow the user to explicitly specify the underlying nginx executable being invoked by this script. thanks Guanlan Dai for the patch.
    * feature: added support for multiple `-I` options to specify more than one user library search paths. thanks Guanlan Dai for the patch.
    * feature: print out resty's own version number when the -V option is specified.
    * feature: resty: added new options `--valgrind` and `--valgrind-opts=OPTS`.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.28.
    * feature: added the [set_base32_alphabet](https://github.com/openresty/set-misc-nginx-module#set_base32_alphabet) config directive to allow the user to specify the alphabet used for base32 encoding/decoding. thanks Vladislav Manchev for the patch.
    * bugfix: [set_quote_sql_str](https://github.com/openresty/set-misc-nginx-module#set_quote_sql_str): we incorrectly escaped 0x1a to `\z` instead of `\Z`.
    * change: the old [set_misc_base32_padding](https://github.com/openresty/set-misc-nginx-module#set_misc_base32_padding) directive is now deprecated; use [set_base32_padding](https://github.com/openresty/set-misc-nginx-module#set_base32_padding) instead.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.14.
    * bugfix: [ngx.re.gsub](https://github.com/openresty/lua-nginx-module#ngxregsub)/[ngx.re.sub](https://github.com/openresty/lua-nginx-module#ngxresub) incorrectly swallowed the character right after a 0-width match that happens to be the last match. thanks Guanlan Dai for the patch.
    * bugfix: [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive): we did not check `NULL` connection pointers properly, which might lead to segmentation faults. thanks Yang Yue for the report.
    * bugfix: [ngx.quote_str_str()](https://github.com/openresty/lua-nginx-module#ngxquote_sql_str) incorrectly escaped "\026" to "\z" while "\Z" is expected. thanks laodouya for the original patch.
    * bugfix: [ngx.timer.at](https://github.com/openresty/lua-nginx-module#ngxtimerat): fixed a small memory leak in case of running out of memory (which should be extremely rare though).
    * optimize: minor optimizations in timers.
    * feature: added the Lua global variable `__ngx_cycle` which is a lightuserdata holding the current `ngx_cycle_t` pointer, which may simplify some FFI-based Lua extensions.
    * doc: added a warning for the "share_all_vars" option for [ngx.location.capture*](https://github.com/openresty/lua-nginx-module#ngxlocationcapture).
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.1.0.
    * bugfix: resty.core.regex: data corruptions might happen when recursively calling [ngx.re.gsub](https://github.com/openresty/lua-nginx-module#ngxregsub) via the user replacement function argument because of incorrect reusing a globally shared captures Lua table. thanks James Hurst for the report.
    * bugfix: [ngx.re.gsub](https://github.com/openresty/lua-nginx-module#ngxregsub): garbage might get injected into gsub result when `ngx.*` API functions are called inside the user callback function for the replacement. thanks James Hurst for the report.
    * feature: resty.core.base: added the `FFI_BUSY` constant for `NGX_BUSY`.
* upgraded [Lua Resty Lrucache Library](lua-resty-lrucache-library.html) to 0.04.
    * bugfix: resty.lrucache.pureffi: set(): it did not update to the new value at all if the key had an existing value (either stale or not). thanks Shuxin Yang for the patch.
* upgraded [Lua Resty Web Socket Library](lua-resty-web-socket-library.html) to 0.05.
    * feature: [resty.websocket.client](https://github.com/openresty/lua-resty-websocket#restywebsocketclient): added support for SSL/TLS connections (i.e., the `wss://` scheme). thanks Vladislav Manchev for the patch.
    * doc: mentioned the [bitop](http://bitop.luajit.org/index.html) library dependency when using the standard Lua 5.1 interpreter (this is not needed for [LuaJIT](luajit.html) because it is already built in). thanks Laurent Arnoud for the patch.
* upgraded [LuaJIT](luajit.html) to v2.1-20150120:  https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * bugfix: don't compile `IR_RETF` after `CALLT` to ff with side effects.
        * bugfix: fix `BC_UCLO`/`BC_JMP` join optimization in Lua parser.
        * bugfix: fix corner case in string to number conversion.
        * bugfix: x86: fix argument checks for `ipairs()` iterator.
        * bugfix: gracefully handle `lua_error()` for a suspended coroutine.
        * x86/x64: Drop internal x87 math functions. Use libm functions.
        * x86/x64: Call external symbols directly from interpreter code. (except for ELF/x86 PIC, where it's easier to use wrappers.)
        * ARM: Minor interpreter optimization.
        * x86: Minor interpreter optimization.
        * PPC/e500: Drop support for this architecture.
        * MIPS: Fix excess stack growth in interpreter.
        * PPC: Fix excess stack growth in interpreter.
        * ARM: Fix excess stack growth in interpreter.
        * ARM: Fix write barrier check in `BC_USETS`.
        * ARM64: Add build infrastructure and initial port of interpreter.
        * OpenBSD/x86: Better executable memory allocation for W^X mode.
* bugfix: the `ngx_http_redis` module failed to compile when the `ngx_gzip` module
was disabled. thanks anod221 for the report.

#  Version 1.7.7.1 - 6 December 2014
* upgraded the [Nginx](nginx.html) core to 1.7.7.
    * see the changes here: http://nginx.org/en/CHANGES
* bugfix: applied a patch to the nginx core to fix the memory invalid reads
when exceeding the pre-configured limits in an `ngx_hash_t` hash table.
* bugfix: applied a patch to the nginx core to fix a memory invalid read regression
introduced in nginx 1.7.5+'s resolver.
* ./configure: usage text: renamed `--with-luajit=PATH` to `--with-luajit=DIR`.
thanks Dominic for the suggestion.
* feature: ./configure: added the default prefix value to the usage text.
* upgraded [LuaJIT](luajit.html) to v2.1-20141128:  https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest changes:
        * feature: FFI: added `ffi.typeinfo()`. thanks to Peter Colberg.
        * bugfix: fixed snapshot #0 handling for traces with a stack check on entry. this bug might lead to bad register overwrites (and eventually segmentation faults in GC upon trace exits, at least).
        * bugfix: FFI: no meta fallback when indexing pointer to incomplete struct.
        * bugfix: fixed fused constant loads under high register pressure.
        * bugfix: fixed DragonFly build (unsupported). thanks to Robin Hahling, Alex Hornung, and Joris Giovannangeli.
        * bugfix: FFI: fixed initialization of unions of subtypes. thanks to Peter Colberg.
        * bugfix: FFI: Fix for cdata vs. non-cdata arithmetic and comparisons. thanks to Roman Tsisyk.
        * optimize: eliminated hmask guard for forwarded HREFK.
    * debugging: added an (expensive) assertion to check GC objects in current stack upon trace exiting. thanks Mike Pall. only enabled when building with `-DLUA_USE_ASSERT`.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.13.
    * optimize: reduced the pool size of a fake connection from the default pool size (16KB) to 128B, affecting [init_worker_by_lua](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) and [ngx.timer.at](https://github.com/openresty/lua-nginx-module#ngxtimerat).
    * optimize: made fake requests share their connection pools, affecting [init_worker_by_lua](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) and [ngx.timer.at](https://github.com/openresty/lua-nginx-module#ngxtimerat).
    * feature: the error logger used by ngx.timer.at handlers now outputs the "client: xxx, server: xxx" context info for the original (true) request creating the timer.
    * feature: added nginx configuration file names and line numbers to the rewrite/access/content/log_by_lua directives' Lua chunk names in order to simplify debugging.
    * feature: [ngx.flush(true)](https://github.com/openresty/lua-nginx-module#ngxflush) now returns the "timeout" and "client aborted" errors to the Lua land for the cases that writing to the client is timed out or the client closes the connection prematurely, respectively.
    * feature: [ngx.flush(true)](https://github.com/openresty/lua-nginx-module#ngxflush) can now wait on delayed events due to nginx's [limit_rate](http://nginx.org/en/docs/http/ngx_http_core_module.html#limit_rate) config directive or [$limit_rate](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_limit_rate) variable settings. thanks Shafreeck Sea for the original patch.
    * bugfix: [ngx.flush()](https://github.com/openresty/lua-nginx-module#ngxflush), [ngx.eof()](https://github.com/openresty/lua-nginx-module#ngxeof), and some other things did not update busy/free chains after calling the output filters.
    * bugfix: ngx_gzip/ngx_gunzip module filters might cause [ngx.flush(true)](https://github.com/openresty/lua-nginx-module#ngxflush) to hang until timeout for nginx 1.7.7+ (and some other old versions of nginx). thanks Maxim Dounin for the help.
    * bugfix: [ngx.get_phase()](https://github.com/openresty/lua-nginx-module#ngxget_phase) did not work in the context of [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua).
    * bugfix: use of [ngx.flush(true)](https://github.com/openresty/lua-nginx-module#ngxflush) with the [limit_rate](http://nginx.org/en/docs/http/ngx_http_core_module.html#limit_rate) config directive or the [$limit_rate](http://nginx.org/en/docs/http/ngx_http_core_module.html#var_limit_rate) variable may hang the request forever for large volumn of output data. thanks Shafreeck Sea for the report.
    * bugfix: compilation error when PCRE is disabled in the nginx build. thanks Ivan Cekov for the report.
    * bugfix: when syslog was enabled in the [error_log](http://nginx.org/en/docs/ngx_core_module.html#error_log) directive for nginx 1.7.1+, use of [init_worker_by_lua](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) or [ngx.timer.at()](https://github.com/openresty/lua-nginx-module#ngxtimerat) would lead to segmentation faults. thanks shun.zhang for the report.
    * bugfix: fixed compilation error with nginx 1.7.5+ because nginx 1.7.5+ changes the API in the events subsystem. thanks Charles R. Portwood II and Mathieu Le Marec for the report.
    * bugfix: [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header): buffer overflow and the "buffer error" exception might happen for massively pipelined downstream requests. thanks Dane Knecht for the report.
    * bugfix: [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header): we might change nginx's internal buffer pointers, which might cause bad side-effects.
    * doc: added a new section, [Cocockets Not Available Everywhere](https://github.com/openresty/lua-nginx-module#cocockets-not-available-everywhere), under the [Known Issues](https://github.com/openresty/lua-nginx-module#known-issues) section.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.14.
    * feature: added support for the SPF record type specified by RFC 4408. thanks Tom Fitzhenry for the patch.
* upgraded [Lua Resty Lrucache Library](lua-resty-lrucache-library.html) to 0.03.
    * feature: the [get()](https://github.com/openresty/lua-resty-lrucache#get) method now also returns the stale value as the second returned value if available.
* upgraded [Lua Resty Lock Library](lua-resty-lock-library.html) to 0.04.
    * bugfix: the shared dictionary would incorrectly get unref'd for multiple times when the [lock()](https://github.com/openresty/lua-resty-lock#lock) and/or [unlock()](https://github.com/openresty/lua-resty-lock#unlock) methods are called more than once. thanks Peng Wu for the report and Dejiang Zhu for the patch.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.57.
    * bugfix: [$echo_client_request_headers](https://github.com/openresty/echo-nginx-module#echo_client_request_headers): buffer overflow and the "buffer error" exception might happen for massively pipelined downstream requests.
    * bugfix: [$echo_client_request_headers](https://github.com/openresty/echo-nginx-module#echo_client_request_headers): we might change nginx's internal buffer pointers, which might cause bad side-effects.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.8.
    * bugfix: fixed compilation error with nginx 1.7.5+ because nginx 1.7.5+ changes the API in the events subsystem.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc5.
    * bugfix: fixed compilation error with nginx 1.7.5+ because nginx 1.7.5+ changes the API in the events subsystem.
* upgraded [Coolkit Nginx Module](coolkit-nginx-module.html) to 0.2rc2.
    * bugfix: compilation failed when PCRE was disabled in the nginx build.
    * feature: added the "$location" variable, by Piotr Sikora.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.27.
    * bugfix: bugfix: fixed build failure when `--with-mail_ssl_module` is specified while `--with-http_ssl_module` is not. thanks Xiaochen Wang for the report.
See [ChangeLog 1.7.4](changelog-1007004.html) for change log for [OpenResty](openresty.html) 1.7.4.x.
