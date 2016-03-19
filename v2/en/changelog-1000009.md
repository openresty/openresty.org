<!---
    @title         ChangeLog 1.0.9
    @creator       Yichun Zhang
    @created       2011-11-08 01:01 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-16 03:14 GMT
    @changes       23
--->


#  Stable Release 1.0.9.10 - 16 November 2011
* bugfix: fixed the error message length while the `./configure` script fails.

[Components](components.html) bundled in this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc4
* echo-nginx-module-0.37rc7
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.16rc4
* iconv-nginx-module-0.10rc5
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.04
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.13rc1
* nginx-1.0.9
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.1rc28
* ngx_postgres-0.9rc2
* rds-csv-nginx-module-0.04
* rds-json-nginx-module-0.12rc6
* redis2-nginx-module-0.08rc1
* set-misc-nginx-module-0.22rc3
* srcache-nginx-module-0.13rc2
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc5

#  Mainline Version 1.0.9.9 - 13 November 2011
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2rc4.
    * bugfix: it might prematurly remove a write event when still busily connecting to the database from the event model.

#  Mainline Version 1.0.9.7 - 10 November 2011
* applied [a patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.9-log_escape_non_ascii.patch) to
add new directives `log_escape_non_ascii` to prevent escaping non-ascii bytes
in access log variable values. requested by [@姜大炮](http://weibo.com/egis).
It can be turned `on` and `off`, and default to `on` just as the standard [Nginx](nginx.html) version.

#  Mainline Version 1.0.9.5 - 9 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc28.
    * bugfix: `Cache-Control` header modification might introduce empty value headers when using with the standard [ngx_headers](http://wiki.nginx.org/HttpHeadersModule) module.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.16rc4.
    * bugfix: `Cache-Control` header modification might introduce empty value headers when using with the standard [ngx_headers](http://wiki.nginx.org/HttpHeadersModule) module.

#  Mainline Version 1.0.9.3 - 9 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc27.
    * feature: added the [ngx.encode_args](http://wiki.nginx.org/HttpLuaModule#ngx.encode_args) method to encode a Lua code to a URI query string. thanks 郭颖 ([0597虾](http://weibo.com/shrimp0597)).
    * feature: [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and [ngx.exec](http://wiki.nginx.org/HttpLuaModule#ngx.exec) now supports the same Lua args table format as in [ngx.encode_args](http://wiki.nginx.org/HttpLuaModule#ngx.encode_args). thanks 郭颖 ([0597虾](http://weibo.com/shrimp0597)).
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2rc3.
    * bugfix: fixed issues with `poll`, `rtsig`, and `select` used by the [Nginx](nginx.html) event model by eliminating the `poll` syscall performed by `libdrizzle`. This also gives rise to a nice speedup (about 10% in simple cases).
* bugfix: [nginx-1.0.9-variable_header_ignore_no_hash.patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.9-variable_header_ignore_no_hash.patch) might
introduce a memory overflow issue in multi-header variables. thanks Markus Linnala.

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
