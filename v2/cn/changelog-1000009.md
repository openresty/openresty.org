<!---
    @title         ChangeLog 1.0.9
    @creator       Yichun Zhang
    @created       2011-11-08 01:01 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-08 01:20 GMT
    @changes       9
--->


#  Mainline Version 1.0.9.1 - 8 November 2011
* upgraded the [Nginx](nginx.html) core to 1.0.9.
* applied the [epoll_check_stale_wev patch](http://mailman.nginx.org/pipermail/nginx-devel/2011-November/001408.html) to
the [Nginx](nginx.html) 1.0.9 core. thanks [@晓旭XX](http://weibo.com/u/1878897190).
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc26.
    * feature: added the `ctx` option to [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture): you can now specify a custom Lua table to pass to the subrequest as its [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx). thanks [@hugozhu](http://weibo.com/hugozhu).
    * bugfix: fixed compatibility with nginx 0.8.54. thanks [@0579虾](http://weibo.com/shrimp0597).
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 0.9rc2
    * bugfix: now we log an error message when the `postgres_pass` target is not found at all and returns 500 in this case instead of returning empty response.
    *  bugfix: we should no longer return `NGX_AGAIN` when the re-polling returns IO WAIT in case of the "connection made" state.
    * feature: added some debugging outputs which be enabled by passing the `--with-debug` option while building [Nginx](nginx.html) or [OpenResty](openresty.html).
    * bugfix: fixed compatibility issues with [Nginx](nginx.html) 1.1.4+: `ngx_chain_update_chains` now requires a pool argument.
* upgraded [Lua Rds Parser Library](lua-rds-parser-library.html) to 0.04.
    * bugfix: fixed a serious memory leak reported by bearnard.
* upgraded [Xss Nginx Module](xss-nginx-module.html) to 0.03rc5.
    * bugfix: the callback argument value parser did not accept JavaScript identifier names started with underscores. thanks Sam Mulube.
See [ChangeLog1000008](changelog-1000008.html) for change log for ngx_openresty 1.0.8.x.
