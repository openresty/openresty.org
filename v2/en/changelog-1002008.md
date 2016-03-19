<!---
    @title         ChangeLog 1.2.8
    @creator       Yichun Zhang
    @created       2013-04-26 23:02 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-06-10 18:54 GMT
    @changes       60
--->


#  Stable Release 1.2.8.6 - 10 June 2013
* upgraded [LuaJIT](luajit.html) to 2.0.2.
    * changes: http://luajit.org/changes.html
The following components are bundled:
* LuaJIT-2.0.2
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.5
* echo-nginx-module-0.45
* encrypted-session-nginx-module-0.03
* form-input-nginx-module-0.07
* headers-more-nginx-module-0.20
* iconv-nginx-module-0.10
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.10
* lua-resty-dns-0.09
* lua-resty-memcached-0.11
* lua-resty-mysql-0.13
* lua-resty-redis-0.15
* lua-resty-string-0.08
* lua-resty-upload-0.08
* memc-nginx-module-0.13rc3
* nginx-1.2.8
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.18
* ngx_lua-0.8.2
* ngx_postgres-1.0rc2
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.10
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.21
* xss-nginx-module-0.03rc9

#  Mainline Version 1.2.8.5 - 23 May 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.2.
    * feature: added `ngx.HTTP_MKCOL`, `ngx.HTTP_COPY`, `ngx.HTTP_MOVE`, and other WebDAV request method constants; also added corresponding support to [ngx.req.set_method](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_method) and [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture). thanks Adallom Roy for the patch.
    * feature: allow injecting new user Lua APIs (and overriding existing Lua APIs) in the "ngx" table.
    * bugfix: [ngx.req.set_body_file()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file) always enabled Direct I/O which caused the alert message "fcntl(O_DIRECT) ... Invalid argument" in error logs on file systems lacking the Direct I/O support.  thanks Matthieu Tourne for reporting this issue.
    * bugfix: buffer corruption might happen in [ngx.req.set_body_file()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file) when [Nginx](nginx.html) upstream modules were used later because [ngx.req.set_body_file()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file) incorrectly set `r->request_body->buf` to the in-file buffer which could get reused by `ngx_http_upstream` for its own purposes.
    * bugfix: no longer automatically turn underscores (_) to dashes (-) in header names for [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) and [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header). thanks aviramc for the report.
    * bugfix: segmentation fault might happen in nginx 1.4.x when calling [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) on the `Cookie` request headers because recent versions of [Nginx](nginx.html) no longer always initialize `r->headers_in.cookies`. thanks Rob W for reporting this issue.
    * bugfix: fixed the C compiler warning "argument 'nret' might be clobbered by 'longjmp' or 'vfork'" when compiling with Ubuntu 13.04's gcc 4.7.3. thanks jacky and Rajeev's reports.
    * bugfix: temporary memory leaks might happen when using [ngx.escape_uri](http://wiki.nginx.org/HttpLuaModule#ngx.escape_uri), [ngx.unescape_uri](http://wiki.nginx.org/HttpLuaModule#ngx.unescape_uri), [ngx.quote_sql_str](http://wiki.nginx.org/HttpLuaModule#ngx.quote_sql_str), [ngx.decode_base64](http://wiki.nginx.org/HttpLuaModule#ngx.decode_base64), and [ngx.encode_base64](http://wiki.nginx.org/HttpLuaModule#ngx.encode_base64) in tight Lua loops because we allocated memory in nginx's request memory pool for these methods.
    * optimize: [ngx.escape_uri](http://wiki.nginx.org/HttpLuaModule#ngx.escape_uri) now runs faster when the input string contains no special bytes to be escaped.
    * testing: added custom test scaffold t::TestNginxLua which subclasses [Test::Nginx::Socket](http://search.cpan.org/perldoc?Test%3A%3ANginx%3A%3ASocket). it supports the environment `TEST_NGINX_INIT_BY_LUA` which can be used to add more custom Lua code to the value of the [init_by_lua](http://wiki.nginx.org/HttpLuaModule#init_by_lua) directive in the [Nginx](nginx.html) configuration.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.21.
    * bugfix: responses with a status code smaller than all the status codes specified in the [srcache_store_statuses](http://wiki.nginx.org/HttpSRCacheModule#srcache_store_statuses) directive were not skipped as expected. thanks Lanshun Zhou for the patch.
* feature: applied the [invalid_referer_hash patch](https://raw.github.com/agentzh/ngx_openresty/master/patches/nginx-1.2.8-invalid_referer_hash.patch) to
the [Nginx](nginx.html) core to make the `$invalid_referer` variable accessible
in embedded dynamic languages like Perl and Lua. thanks Fry-kun for requesting
this.
* updated the [dtrace patch](https://raw.github.com/agentzh/ngx_openresty/master/patches/nginx-1.2.8-dtrace.patch) for
the [Nginx](nginx.html) core.
    * print out more info about the [Nginx](nginx.html) in-file bufs in the tapset function `ngx_chain_dump`.

#  Mainline Version 1.2.8.3 - 13 May 2013
* applied the official patch for the nginx core to address the recent nginx
security vulnerability CVE-2013-2070.

#  Mainline Version 1.2.8.1 - 26 April 2013
* upgraded the [Nginx](nginx.html) core to 1.2.8.
    * see http://nginx.org/en/CHANGES-1.2 for changes.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.1.
    * feature: implemented the new timer API: the [ngx.timer.at](http://wiki.nginx.org/HttpLuaModule#ngx.timer.at) Lua function and two configure directives [lua_max_pending_timers](http://wiki.nginx.org/HttpLuaModule#lua_max_pending_timers) and [lua_max_running_timers](http://wiki.nginx.org/HttpLuaModule#lua_max_running_timers). thanks Matthieu Tourne for requesting this feature.
    * feature: added the "U" regex option to the [ngx.re API](http://wiki.nginx.org/HttpLuaModule#ngx.re.match) to mean enabling the UTF-8 matching mode but disabling UTF-8 validity check on the subject strings. thanks Lance Li for the patch.
    * bugfix: setting [ngx.header.etag](http://wiki.nginx.org/HttpLuaModule#ngx.header.HEADER) could not affect other things reading the `ETag` response header (like the [etag](http://nginx.org/en/docs/http/ngx_http_core_module.html#etag) directive introduced in [Nginx](nginx.html) 1.3.3+). thanks Brian Akins for the patch.
    * bugfix: when [lua_http10_buffering](http://wiki.nginx.org/HttpLuaModule#lua_http10_buffering) is on, for HTTP 1.0 requests, [ngx.exit](http://wiki.nginx.org/HttpLuaModule#ngx.exit)(N) would always trigger the [Nginx](nginx.html)'s own error pages when N >= 300. thanks Matthieu Tourne for reporting this issue.
    * bugfix: modifying the `Cookie` request headers via [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) or [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not update the [Nginx](nginx.html) internal data structure, `r->headers_in.cookies`, at the same time, which might cause issues when reading variables [$cookie_COOKIE](http://wiki.nginx.org/HttpCoreModule#.24cookie_COOKIE), for example. thanks Matthieu Tourne for the patch.
    * bugfix: modifying the `Via` request header with [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) or [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not update the special field `r->headers_in.via` when the [ngx_gzip](http://wiki.nginx.org/HttpGzipModule) module was enabled.
    * bugfix: modifying the `X-Real-IP` request header with [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) or [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not update the special field `r->headers_in.x_real_ip` when the [ngx_realip](http://wiki.nginx.org/HttpRealipModule) module was enabled. thanks Matthieu Tourne for the patch.
    * bugfix: modifying the `Connection` request header via [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) or [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not update the special internal field in the [Nginx](nginx.html) core, `r->headers_in.connection_type`. Thanks Matthieu Tourne for the patch.
    * bugfix: modifying the `User-Agent` request header via [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) or [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not update those special internal flags in the [Nginx](nginx.html) core, like `r->headers_in.msie6` and `r->headers_in.opera`. Thanks Matthieu Tourne for the patch.
    * bugfix: fixed several places in the header API where we should return `NGX_ERROR` instead of `NGX_HTTP_INTERNAL_SERVER_ERROR`.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.20.
    * bugfix: use of C global variables at the configuration phase would cause troubles when `HUP` reload failed.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.20.
    * bugfix: modifying the `Cookie` request headers via [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) or [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not update the [Nginx](nginx.html) internal data structure, `r->headers_in.cookies`, at the same time, which might cause issues when reading variable [$cookie_COOKIE](http://wiki.nginx.org/HttpCoreModule#.24cookie_COOKIE), for example.
    * bugfix: modifying the `Via` request header via [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) or [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not update the special internal field in the [Nginx](nginx.html) core, `r->headers_in.via`, when the [ngx_gzip](http://wiki.nginx.org/HttpGzipModule) module was enabled.
    * bugfix: modifying the `X-Real-IP` request header via [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) or [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not update the special internal field in the [Nginx](nginx.html) core, `r->headers_in.x_real_ip`, when the [ngx_realip](http://wiki.nginx.org/HttpRealipModule) module was enabled.
    * bugfix: modifying the `Connection` request header via [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) or [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not update the special internal field in the [Nginx](nginx.html) core, `r->headers_in.connection_type`.
    * bugfix: modifying the `User-Agent` request header via [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) or [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not update those special internal flags in the [Nginx](nginx.html) core, like `r->headers_in.msie6` and `r->headers_in.opera`.
    * bugfix: fixed places where we should return `NGX_ERROR` instead of `NGX_HTTP_INTERNAL_SERVER_ERROR`.
* feature: always enable debuginfo in the bundled [LuaJIT](luajit.html) 2.0.1
build and Lua 5.1.5 build to support [Nginx Systemtap Toolkit](https://github.com/agentzh/nginx-systemtap-toolkit).
* bugfix: no longer pass `-O0` to gcc when the `--with-debug` configure option
is specified because gcc often generates bogus DWARF info when optimization
is turned off.
See [ChangeLog 1.2.7](changelog-1002007.html) for change log for [OpenResty](openresty.html) 1.2.7.x.
