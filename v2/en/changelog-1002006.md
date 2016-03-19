<!---
    @title         ChangeLog 1.2.6
    @creator       Yichun Zhang
    @created       2013-01-05 07:04 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-02-18 03:06 GMT
    @changes       65
--->


#  Mainline Version 1.2.6.6 - 17 February 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.15.
    * bugfix: the original Lua VM error messages might get lost in case of Lua code crashes when user coroutines were used. thanks Dirk Feytons for the report.
    * diagnose: added more info about `r->main->count` to the debugging logs.
    * style: massive coding style fixes according to the [Nginx](nginx.html) coding style.
The following components are bundled:
* LuaJIT-2.0.0
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.4
* echo-nginx-module-0.42
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07
* headers-more-nginx-module-0.19
* iconv-nginx-module-0.10rc7
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.10
* lua-resty-dns-0.09
* lua-resty-memcached-0.10
* lua-resty-mysql-0.12
* lua-resty-redis-0.15
* lua-resty-string-0.08
* lua-resty-upload-0.07
* memc-nginx-module-0.13rc3
* nginx-1.2.6
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.18
* ngx_lua-0.7.15
* ngx_postgres-1.0rc2
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.09
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.19
* xss-nginx-module-0.03rc9

#  Mainline Version 1.2.6.5 - 8 February 2013
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.19.
    * bugfix: HEAD and conditional GET requests would still fall back to content handler execution (leading to backend accesses) even in case of a cache hit. thanks Wang Lichao for reporting this issue.
    * style: massive coding style fixes.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.07.
    * bugfix: the boundary string could not be parsed if no space was present before the `boundary=xxx` parameter in the `Content-Type` request header. thanks chenshu for reporting this issue.

#  Mainline Version 1.2.6.3 - 3 February 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.14.
    * feature: implemented named subpattern support in [ngx.re.match](http://wiki.nginx.org/HttpLuaModule#ngx.re.match), [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch), [ngx.re.sub](http://wiki.nginx.org/HttpLuaModule#ngx.re.sub), and [ngx.re.gsub](http://wiki.nginx.org/HttpLuaModule#ngx.re.gsub); also added new regex option `D` to allow duplicate named subpattern names. thanks Ray Bejjani for the patch.
    * feature: implemented the `J` regex option for the PCRE Javascript compatible mode in the [ngx.re API](http://wiki.nginx.org/HttpLuaModule#ngx.re.match). thanks lhmwzy for requesting this.
    * feature: setting [ngx.header.HEADER](http://wiki.nginx.org/HttpLuaModule#ngx.header.HEADER) after sending out the response headers now only produced an error message in the [Nginx](nginx.html) error logs and does not throw out a Lua exception. this should be handy for Lua development. thanks Matthieu Tourne for requesting this.
    * feature: automatic Lua 5.1 interpreter detection on OpenBSD 5.2. thanks Ilya Shipitsin for the patch.
    * refactor: when the [Nginx](nginx.html) core fails to send the "100 Continue" response in case of the "Expect: 100-continue" request header (or just running out of memory), [ngx.req.read_body()](http://wiki.nginx.org/HttpLuaModule#ngx.req.read_body) will no longer throw out a "failed to read request body" Lua error but will just terminate the current request and returns the 500 error page immediately, just as what the [Nginx](nginx.html) core currently does in this case.
    * bugfix: because of the recent API behaviour changes in nginx 1.2.6+ and 1.3.9+, the "http request count is zero" alert might happen when [ngx.req.read_body()](http://wiki.nginx.org/HttpLuaModule#ngx.req.read_body) was called to read the request body and [Nginx](nginx.html) failed to send out the "100 Continue" response (like client connection early abortion and etc). thanks stonehuzhan for reporting this issue.
    * bugfix: setting the "eof" argument (i.e., `ngx.arg[2]`) in [body_filter_by_lua*](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua) for a subrequest could truncate the main request's response data stream.
    * bugfix: in [body_filter_by_lua*](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua), the "eof" argument (i.e., `ngx.arg[2]`) was never set in [Nginx](nginx.html) subrequests.
    * bugfix: for nginx 1.3.9+ compatibility, we return an error while using [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) to read the chunked request body (for now), because chunked support in the downstream cosocket API is still a TODO.
    * bugfix: for nginx 1.3.9+ compatibility, [rewrite_by_lua*](http://wiki.nginx.org/HttpLuaModule#rewrite_by_lua) or [access_by_lua*](http://wiki.nginx.org/HttpLuaModule#access_by_lua) handlers might hang if the request body was read there, because the [Nginx](nginx.html) core now overwrites `r->write_event_handler` to `ngx_http_request_empty_handler` in its `ngx_http_read_client_request_body` API.
    * bugfix: for nginx 1.3.9+ compatibility, we now throw an error in [ngx.req.init_body()](http://wiki.nginx.org/HttpLuaModule#ngx.req.init_body), [ngx.req.set_body_data()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_data), and [ngx.req.set_body_file()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file) when calling them without calling [ngx.req.read_body()](http://wiki.nginx.org/HttpLuaModule#ngx.req.read_body) or after calling [ngx.req.discard_body()](http://wiki.nginx.org/HttpLuaModule#ngx.req.discard_body).
    * bugfix: a compilation error would happen when building with an [Nginx](nginx.html) core patched by the SPDY patch 58_1.3.11 because the patch had removed a request field from the [Nginx](nginx.html) core. thanks Chris Lea for reporting this.
    * bugfix: we did not get the request reference counter (i.e., `r->main->count`) right when [lua_need_request_body](http://wiki.nginx.org/HttpLuaModule#lua_need_request_body) was turned on and nginx versions older than 1.2.6 or 1.2.9 were used.
    * optimize: we no longer traverse the captured body chain everytime we append a new link to it in [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and [ngx.location.capture_multi](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi).
    * docs: documented the [ngx.quote_sql_str](http://wiki.nginx.org/HttpLuaModule#ngx.quote_sql_str) API.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.18.
    * bugfix: we might serve a truncated [srcache_fetch](http://wiki.nginx.org/HttpSRCacheModule#srcache_fetch) subrequest's response body as the cached response.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.42.
    * feature: the [echo_after_body](http://wiki.nginx.org/HttpEchoModule#echo_after_body) directive is now enabled in [Nginx](nginx.html) subrequests (again).
    * bugfix: we did not set the "last_in_chain" buffer flag when [echo_after_body](http://wiki.nginx.org/HttpEchoModule#echo_after_body) was used in subrequests.
* upgraded [Form Input Nginx Module](form-input-nginx-module.html) to 0.07.
    * bugfix: [Nginx](nginx.html) might hang when it failed to send the "100 Continue" response for [Nginx](nginx.html) versions older than 1.2.6 (and those older than 1.3.9 in the 1.3.x series).
* upgraded [Nginx Devel Kit](nginx-devel-kit.html) ot 0.2.18.
    * bugfix: various fixes for C89 compliance. also stripped some line-trailing spaces.
    * bugfix: guard macros were missing in the `ndk_set_var.h` header file.
    * bugfix: the `ndk_string` submodule failed to compile with gcc 4.6. thanks Jon Kolb for the patch.
    * bugfix: the `ndk_set_var` example did not use the new way in its `config` file. thanks Amos Wenger for the patch.
    * docs: fixes in README to reflect recent changes. thanks Amos Wenger for the patch.
* applied Ruslan Ermilov's [resolver_wev_handler_segfault_with_poll patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.6-resolver_wev_handler_segfault_with_poll.patch) to
the [Nginx](nginx.html) core bundled. see [the related nginx-devel thread](http://mailman.nginx.org/pipermail/nginx-devel/2013-January/003275.html) for
details.
* excluded the [allow_request_body_updating patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.5-allow_request_body_updating.patch) from
the [Nginx](nginx.html) core bundled.

#  Mainline Version 1.2.6.1 - 4 January 2013
* upgraded the [Nginx](nginx.html) core to 1.2.6.
    * see http://nginx.org/en/CHANGES-1.2 for changes.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.13.
    * bugfix: [ngx.decode_args()](http://wiki.nginx.org/HttpLuaModule#ngx.decode_args) might result in Lua string storage corruption. thanks Xu Jian for the report and Kindy Lin for the patch.
    * bugfix: using a key with underscores in [ngx.header.KEY](http://wiki.nginx.org/HttpLuaModule#ngx.header.HEADER) resulted in Lua string storage corruption. thanks rkearsley for reporting this issue.
    * bugfix: accessing [ngx.var.VARIABLE](http://wiki.nginx.org/HttpLuaModule#ngx.var.VARIABLE) allocated temporary memory buffers in the request memory pool, which could lead to unnecessarily large memory footprint; now it allocates such buffers via Lua GC.
    * feature: automatically detect [LuaJIT](luajit.html) 2.0 on FreeBSD by default. thanks rkearsley for the patch.
    * docs: explained why `local foo = require "foo"` is required for loading a Lua module. thanks rkearsley for asking.
    * docs: fixed a typo in the code sample for [tcpsock:receiveuntil()](http://wiki.nginx.org/HttpLuaModule#tcpsock:receiveuntil). thanks Yecheng Fu for the patch.
    * docs: fixed a typo in the Lua code sample for [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) (we forgot to add `do` there). thanks Guo Yin for reporting this issue.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.06.
    * optimize: use the pure lower-case form of the key `content-type` to index the headers table returned by [ngx.req.get_headers()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers) so as to avoid the overhead of calling the `__index` metamethod.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.17.
    * bugfix: [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) would emit the misleading error message "srcache_store: skipped because response body truncated: N > 0" for HEAD requests (because a HEAD request's response never carries a body); now it just skips such responses silently. thanks Yang Jin for reporting this issue.
* bugfix: when relative paths were used in `--with-zlib=DIR`, `--with-libatomic=DIR`,
`--with-md5=DIR`, and `--with-sha1=DIR`, the build system of [Nginx](nginx.html) could
not find `DIR` at all. thanks LazyZhu for reporting this issue.

See [ChangeLog 1.2.4](changelog-1002004.html) for change log for [OpenResty](openresty.html) 1.2.4.x.
