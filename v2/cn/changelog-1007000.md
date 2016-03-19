<!---
    @title         ChangeLog 1.7.0
    @creator       Yichun Zhang
    @created       2014-06-07 22:52 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      
    @changes       1
--->


#  Version 1.7.0.1 - 7 June 2014
* upgraded the [Nginx](nginx.html) core to 1.7.0.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: bundled new Lua library, [Lua Resty Lrucache Library](lua-resty-lrucache-library.html),
which is also enabled by default. see https://github.com/openresty/lua-resty-lrucache#readme
for more details. thanks Shuxin Yang for the help.
* upgraded [LuaJIT](luajit.html) to v2.1-20140531: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest bug fixes and other changes:
        * Fix frame traversal while searching for error function.
        * Fix FOLD rule for STRREF of SNEW.
        * FFI: Fix recording of indexing a struct pointer ctype object itself.
        * FFI: Another fix for cdata equality comparisons.
        * Fix FOLD rule for `string.sub(s, ...) == k`.
        * x86: Fix code generation for unused result of `math.random()`.
        * x64: Workaround for MSVC build issue.
        * PPC: Fix red zone overflow in machine code generation.
        * Fix compatibility issues with Illumos. Thanks to Theo Schlossnagle.
        * Add PS Vita port. Thanks to Anton Stenmark.
    * disabled trace stitching by default for now since it may trigger random lua stack corruptions when using with ngx_lua.
    * feature: jit.dump: output Lua source location after every BC.
    * feature: added internal memory-buffer-based trace entry/exit/start-recording event logging, mainly for debugging bugs in the JIT compiler. it requires `-DLUA_USE_TRACE_LOGS` when building.
    * feature: save `g->jit_base` to `g->saved_jit_base` before `lj_err_throw` clears `g->jit_base` which makes it impossible to get Lua backtrace in such states.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.7.
    * feature: implemented [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module/#ngxreqset_header) (partial: table-typed values not yet supported) and [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module/#ngxreqclear_header) with FFI in the [resty.core.request](https://github.com/openresty/lua-resty-core#restycorerequest) module.
    * feature: implemented [shdict:flush_all()](https://github.com/openresty/lua-nginx-module/#ngxshareddictflush_all) with FFI in the [resty.core.shdict](https://github.com/openresty/lua-resty-core#restycoreshdict).
    * feature: implemented [ngx.req.set_method()](https://github.com/openresty/lua-nginx-module/#ngxreqset_method) with FFI in [resty.core.request](https://github.com/openresty/lua-resty-core#restycorerequest).
    * feature: implemented [ngx.req.get_method()](https://github.com/openresty/lua-nginx-module/#ngxreqget_method) with FFI in [resty.core.request](https://github.com/openresty/lua-resty-core#restycorerequest).
    * feature: implemented [ngx.time()](https://github.com/openresty/lua-nginx-module/#ngxtime) with FFI in [resty.core.time](https://github.com/openresty/lua-resty-core#restycoretime).
    * feature: implemented [ngx.req.start_time](https://github.com/openresty/lua-nginx-module/#ngxreqstart_time) with FFI in [rest.core.request](https://github.com/openresty/lua-resty-core#restycorerequest).
    * feature: implemented [ngx.now()](https://github.com/openresty/lua-nginx-module/#ngxnow) with FFI in [resty.core.time](https://github.com/openresty/lua-resty-core#restycoretime).
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.8.
    * bugfix: the [ngx.ctx](https://github.com/openresty/lua-nginx-module/#ngxctx) table might be released prematurely when [ngx.exit()](https://github.com/openresty/lua-nginx-module/#ngxexit) was used to generate the response header. thanks Monkey Zhang for the report. now we always release [ngx.ctx](https://github.com/openresty/lua-nginx-module/#ngxctx) in our request pool cleanup handler.
    * bugfix: we did not call our coroutine cleanup handlers right after our coroutine completes (either successfully or unsuccessfully) otherwise segmentation fault might happen when the Lua VM throws out unexpected exceptions like "attempt to yield across C-call boundary". thanks Lipin Dmitriy for the report.
    * bugfix: nginx does not guarentee the parent pointer of the rbtree root is meaningful, which could lead to inifinite loops when [Lua Nginx Module](lua-nginx-module.html) tried to abort pending timers prematurely (upon worker exit). thanks pengqi for the report.
    * bugfix: [ngx.req.set_method()](https://github.com/openresty/lua-nginx-module/#ngxreqset_method): we incorrectly modified `r->method` when the method ID was wrong.
    * bugfix: [rewrite_by_lua*](https://github.com/openresty/lua-nginx-module/#rewrite_by_lua) and [access_by_lua*](https://github.com/openresty/lua-nginx-module/#access_by_lua) will now terminate the current request if the response header has already been sent (via calls like [ngx.say](https://github.com/openresty/lua-nginx-module/#ngxsay) and [ngx.send_headers](https://github.com/openresty/lua-nginx-module/#ngxsend_headers)) at that point. thanks yaronli and Sophos for the report.
    * bugfix: issues in the error handling for pure C API functions for shared dict. thanks Xiaochen Wang.
    * feature: now we save the original pattern string pointer value into our `ngx_http_lua_regex_t` C struct, to help runtime regex profiling and debugging.
    * feature: allow use of 3rd-party pcre bindings in [init_by_lua*](https://github.com/openresty/lua-nginx-module/#init_by_lua). thanks ikokostya for the feature request.
    * feature: added pure C API functions to support the new FFI-based Lua API implemented in [Lua Resty Core Library](lua-resty-core-library.html).
    * feature: make use of the new shm API in nginx 1.5.13+ to suppress the "no memory" error logging when the shared dictionaries run out of memory.
    * feature: added C macro `NGX_LUA_ABORT_AT_PANIC` to allow generating a core dump when the Lua VM panics.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.27.
    * bugfix: we used to skip all the output header and body filters run before our filters (which unfortunately bypassed the standard ngx_http_not_modified_filter_module, for example). thanks Lloyd Zhou for the report.
    * feature: added new config directive [srcache_store_ranges](https://github.com/openresty/srcache-nginx-module#srcache_store_ranges) for storing 206 Partial Content responses generated by the standard ngx_http_range_filter_module.
* bugfix: updated the dtrace patch because systemtap 2.5 no longer accepts the
`-xnolib` option in its dtrace utility.
* removed our bundled version of `ngx_http_auth_request_module` because recent
versions of the nginx core already have it. thanks LazyZhu for the report.
* bugfix: applied our patch for the nginx core to fix the long standing memory
fragmentation issue for blocks larger than the page size in the nginx slab allocator:
http://mailman.nginx.org/pipermail/nginx-devel/2014-May/005316.html thanks Shuxin
Yang for the help.
See [ChangeLog 1.5.12](changelog-1005012.html) for change log for [OpenResty](openresty.html) 1.5.12.x.
