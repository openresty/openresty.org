<!---
    @title         ChangeLog 1.7.2
    @creator       Yichun Zhang
    @created       2014-07-13 03:21 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->


#  Version 1.7.2.1 - 12 July 2014
* upgraded the [Nginx](nginx.html) core to 1.7.2.
    * see the changes here: http://nginx.org/en/CHANGES
* upgraded [LuaJIT](luajit.html) to v2.1-20140707: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest bug fixes and other changes:
        * feature: compile debug.getmetatable(). Thanks to Karel Tuma.
        * bugfix: Fix ABC elimination (for negative table indexes, for example).
        * bugfix: FFI: Fix compilation of reference field access.
        * bugfix: FFI: fixed frame traversal for backtraces with FFI callbacks.
        * bugfix: x86: lj_math_random_step() clobbers XMM regs on OSX Clang.
        * bugfix: fixed debug info for main chunk of stripped bytecode.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.8.
    * feature: [resty.core.regex](https://github.com/openresty/lua-resty-core#restycoreregex): use `resty.lrucache` for the compiled regex cache for [ngx.re.find](https://github.com/openresty/lua-nginx-module#ngxrefind) and [ngx.re.match](https://github.com/openresty/lua-nginx-module#ngxrematch) in order to prevent pathalogical performance when the number of regexes has exceeded [lua_regex_cache_max_entries](https://github.com/openresty/lua-nginx-module/#lua_regex_cache_max_entries).
    * optimize: [resty.core.regex](https://github.com/openresty/lua-resty-core#restycoreregex): removed one obsolete assertion that was for a [LuaJIT](luajit.html) bug (already fixed).
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.12.
    * feature: added support for the SRV resource record type (see [RFC 2782](http://www.ietf.org/rfc/rfc2782.txt)). thanks Torbjörn Norinder for the patch.
* upgraded [Lua Resty Upstream Healthcheck Library](lua-resty-upstream-healthcheck-library.html) to 0.02.
    * bugfix: for bad status lines, we could throw out the "bad argument #2 to 'sub'" error, reported by George Bashi.
    * doc: avoided using the `\r\n` sequence in Lua long brackets because Lua would squeeze it to `\n`, unfortunately. thanks George Bashi for the report.
    * doc: made it clear that multiple `upstream {} ` blocks' checkers can share a single shm zone. thanks Robert Paprocki for asking.
    * doc: now we need to turn off [lua_socket_log_errors](https://github.com/openresty/lua-nginx-module/#lua_socket_log_errors) explicitly in code examples.
* upgraded [Lua Resty Lrucache Library](lua-resty-lrucache-library.html) to 0.02.
    * feature: added an alternative implementation using FFI-based hash-table in the form of the new class `resty.lrucache.pureffi`, which is much faster than the default `resty.lrucache` class when there are a lot of key variations. thanks Shuxin Yang for the patch.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.10.
    * feature: [stream-typed cosockets](https://github.com/openresty/lua-nginx-module#ngxsockettcp) are now full-duplex: a reader "[light thread](https://github.com/openresty/lua-nginx-module#ngxthreadspawn)" and a writer "light thread" can operate on the same cosocket simultaneously. thanks shun zhang and aviramc for the original patches.
    * feature: added new API function [ngx.thread.kill()](https://github.com/openresty/lua-nginx-module/#ngxthreadkill) for killing a user "light thread". thanks aviramc for the original patch.
    * bugfix: the "coroutine" module table introduced by `require('coroutine')` was not working in our Lua context. thanks Paul K and Pierre-Yves Gérardy for the report.
    * bugfix: fixed the initial size of the ngx.worker table and the misleading comment due to a copy&paste mistake. thanks Suraj Jaiswal for the report.
    * bugfix: the "coctx cleanup" handler might not be called before being overidden by other operations. this could happen when failing to yield in an error handler (for [xpcall](http://www.lua.org/manual/5.1/manual.html#pdf-xpcall)).
    * bugfix: fixed an incorrect error message. thanks doujiang for the patch.
    * bugfix: fixed a compilation error regression when using the Microsoft Visual C/C++ compiler. thanks itpp16 for the patch.
    * bugfix: we should use `c->buffered & NGX_HTTP_LOWLEVEL_BUFFERED` instead of `c->buffered` for testing if the downstream connection is busy writing.
    * bugfix: we did not handle an out-of-memory case in [ngx.req.set_body_data()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_data).
    * bugfix: ngx_http_lua_chain_get_free_buf(): avoided returning zero-sized memory bufs.
    * bugfix: [body_filter_by_lua*](https://github.com/openresty/lua-nginx-module#body_filter_by_lua): we might incorrectly pass zero-size bufs (in the form of "special sync bufs") at the beginning of a chain, which could get stuck in the buffer of `ngx_http_writer_filter_module` (or in other words, being "busy") while could still get recycled in the content handler (like [content_by_lua](https://github.com/openresty/lua-nginx-module#content_by_lua)), leading to buffer corruptions. thanks westhood for the report and patch.
    * bugfix: we did not clear all the fields in the `ngx_buf_t` C struct when recycling chain link buffers.
    * bugfix: the `*_by_lua_file` directives failed to load .lua files of exactly the size `n*LUAL_BUFFERSIZE` bytes with the error "'end' expected (to close 'function' at line 1) near '<eof>'". thanks kworr for the report.
    * change: now we always iterate through all the user light threads to ensure all threads are de-anchored even when the "uthreads" counter gets out of sync. also added an assertion on the "uthreads" counter.
    * change: now we turn off our C-land assertions by default unless the user explicitly specifies the C compiler option `-DNGX_LUA_USE_ASSERT`.
    * change: throw out the "no memory" Lua error consistently (instead of "out of memory") when failing to allocate on the nginx side.
    * change: we now still call `ngx_pfree()` in our own `pcre_free` hook.
    * doc: documented the `NGX_LUA_USE_ASSERT` and `NGX_LUA_ABORT_AT_PANIC` C macros.
    * doc: added performance notes to the sections for the [ngx.var](https://github.com/openresty/lua-nginx-module#ngxvarvariable) and [ngx.ctx](https://github.com/openresty/lua-nginx-module#ngxctx) API.
    * doc: documented the types of Lua values that can be passed to the [ngx.timer](https://github.com/openresty/lua-nginx-module#ngxtimerat) callback functions.
* upgraded [Form Input Nginx Module](form-input-nginx-module.html) to 0.09.
    * bugfix: fixed warnings from the Microsoft Visual C/C++ compiler. thanks itpp16 for the report.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.54.
    * bugfix: the "unknown option for echo_subrequest_async" error was thrown when [Nginx](nginx.html) variables were used in both the "method" argument and URI argument of the [echo_subrequest](https://github.com/openresty/echo-nginx-module#echo_subrequest) directive (and etc). thanks Utkarsh Upadhyay for the report.
    * bugfix: fixed a misleading error message.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.28.
    * feature: log an error message when [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) subrequest has an error or returns a bad HTTP status code. thanks Yann Coleu for the report.
    * doc: typo fix from javasboy.
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.15.
    * bugfix: we did not log error messages for invalid values of `$memc_flags`, `$memc_exptime`, and `$memc_value`, leading to hard-to-debug HTTP 400 status errors. thanks Yann Coleu for the report.
* bugfix: `./configure --without-lua_resty_dns` did not work as declared. thanks
Vitaly for the report.
* bugfix: use `cc` as the default C compiler for [LuaJIT](luajit.html) and Lua
C libraries because modern FreeBSD 10 has no gcc by default and its clang is
already featureful enough to compile everything. thanks Stefan Parvu for the
suggestion.
* change: `./configure --with-debug` now also passes the extra C compiler options
`-DNGX_LUA_USE_ASSERT -DNGX_LUA_ABORT_AT_PANIC` to the [Lua Nginx Module](lua-nginx-module.html) build.
See [ChangeLog 1.7.0](changelog-1007000.html) for change log for [OpenResty](openresty.html) 1.7.0.x.
