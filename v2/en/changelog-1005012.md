<!---
    @title         ChangeLog 1.5.12
    @creator       Yichun Zhang
    @created       2014-04-29 20:37 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2014-06-01 05:53 GMT
    @changes       40
--->


#  Version 1.5.12.1 - 29 April 2014
* upgraded the [Nginx](nginx.html) core to 1.5.12.
    * see the changes here: http://nginx.org/en/CHANGES
* upgraded [LuaJIT](luajit.html) to v2.1-20140423 (see https://github.com/openresty/luajit2/releases
).
    * bugfix: prevent adding side traces for stack checks. (Mike pall) this could cause internal assertion failure in the JIT compiler while replaying snapshots in very obscure cases: `lj_snap.c:497: lj_snap_replay: Assertion `ir->o == IR_CONV && ir->op2 == ((IRT_NUM<<5)|IRT_INT)' failed.`
    * bugfix: fixed FOLD of string concatenations. (Mike Pall) this issue was reported by leafo and could lead to invalid string results in special cases while compiling string concatenations.
    * bugfix: FFI: fixed cdata equality comparison against strings and other Lua types. (Mike Pall)
    * bugfix: fixed top slot calculation for snapshots with continuations. (Mike Pall) this was a bug in snapshot generation, but it only surfaced with trace stitching. it could cause Lua stack overwrites in special cases.
    * bugfix: PPC: don't use mcrxr on PPE. (Mike Pall)
    * bugfix: prevent GC estimate miscalculation due to buffer growth. (Mike Pall)
    * bugfix: fixed the regression introduced by the previous fix for "reuse of SCEV results in FORL". (Mike Pall) this could cause internal assertion failure in the JIT compiler: `lj_record.c:68: rec_check_ir: Assertion `op2 >= nk' failed.`
    * bugfix: fixed alias analysis for `table.len` vs. `table.clear`. (Mike Pall) this could cause `table.len` to return incorrect values (nonzero values) after `table.clear` was performed.
    * bugfix: fixed the compatibility with DragonFlyBSD. thanks lhmwzy for the patch.
    * feature: allow non-scalar cdata to be compared for equality by address. (Mike Pall)
* upgraded [Lua Upstream Nginx Module](lua-upstream-nginx-module.html) to 0.02.
    * bugfix: upstream names did not support taking a port number. thanks magicleo for the report.
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.11.
    * change: now we always ignore client aborts for collaborations with other modules like [Srcache Nginx Module](srcache-nginx-module.html). thanks akamatgi for the report.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.7.
    *  bugfix: when [lua_code_cache](https://github.com/openresty/lua-nginx-module#lua_code_cache) was off, [cosocket:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) might lead to segmentation faults. thanks Kelvin Peng for the report.
    * refactor: improved the error handling and logging in the Lua code loader and closure factory.
    * change: added stronger assertions to the stream-typed cosocket implementation.
    * optimize: we no longer call `ngx_pfree()` in our own `pcre_free` hook.
    * optimize: we no longer clear the pointer `ctx->user_co_ctx` in `ngx_http_lua_reset_ctx`.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.53.
    * bugfix: use of empty arguments after the `-n` option of the [echo](https://github.com/openresty/echo-nginx-module#echo) directive (and its friends) might cause subsequent arguments to get discarded. thanks Lice Pan for the report and fix.
* upgraded [Form Input Nginx Module](form-input-nginx-module.html) to 0.08.
    * bugfix: segmentation fault might happen when `set_form_input_multi` was used while no proper `Content-Type` request header was given.
* upgraded [Lua Resty Web Socket Library](lua-resty-web-socket-library.html) to 0.03.
    * optimize: added a minor optimization in the [recv_frame()](https://github.com/openresty/lua-resty-websocket#recv_frame) method. thanks yurnerola for the catch.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.6.
    * optimize: [ngx.re.sub](https://github.com/openresty/lua-nginx-module#ngxresub)/[ngx.re.gsub](https://github.com/openresty/lua-nginx-module#ngxregsub): now we avoid constructing new Lua strings for the regex cache keys, which gives 5% speedup for trivial use cases.
    * optimize: [ngx.re.match](https://github.com/openresty/lua-nginx-module#ngxrematch)/[ngx.re.find](https://github.com/openresty/lua-nginx-module#ngxrefind): avoided constructing a new Lua string for the regex cache key by switching over to a cascaded 2-level hash table, which gives 22% speedup for simple use cases.
* upgraded [Lua Resty Lock Library](lua-resty-lock-library.html) to 0.03.
    * bugfix: prevented using cdata directly as table keys.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.09.
    * bugfix: avoided using the "module" builtin function to define lua modules. thanks lhmwzy for the original patch.
See [ChangeLog 1.5.11](changelog-1005011.html) for change log for [OpenResty](openresty.html) 1.5.11.x.
