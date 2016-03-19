<!---
    @title         ChangeLog 1.0.10
    @creator       Yichun Zhang
    @created       2011-11-16 07:21 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-02-02 04:52 GMT
    @changes       72
--->


#  Stable Release 1.0.10.48 - 1 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.4.1.

[Components](components.html) bundled with this release:
* LuaJIT-2.0.0-beta9
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc6
* echo-nginx-module-0.38rc1
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.17rc1
* iconv-nginx-module-0.10rc5
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.04
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.13rc3
* nginx-1.0.10
* ngx_devel_kit-0.2.17
* ngx_lua-0.4.1
* ngx_postgres-0.9rc2
* rds-csv-nginx-module-0.04
* rds-json-nginx-module-0.12rc7
* redis2-nginx-module-0.08rc2
* set-misc-nginx-module-0.22rc5
* srcache-nginx-module-0.13rc3
* upstream-keepalive-nginx-module-0.7
* xss-nginx-module-0.03rc8

#  Mainline Version 1.0.10.47 - 29 January 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.4.1rc4.
    * bugfix: `ngx_http_lua_header_filter_init` was called with an argument which actually accepts none. this could cause compilation errors at least with gcc 4.3.4 as reported in github [issue #80](http://github.com/openresty/lua-nginx-module/issues/80). thanks bigplum (Simon).

#  Mainline Version 1.0.10.45 - 19 January 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.4.1rc3.
    * bugfix: fixed all the warnings from the `clang` static analyzer.
    * bugfix: [ngx.exit](http://wiki.nginx.org/HttpLuaModule#ngx.exit), [ngx.redirect](http://wiki.nginx.org/HttpLuaModule#ngx.redirect), [ngx.exec](http://wiki.nginx.org/HttpLuaModule#ngx.exec), and [ngx.req.set_uri(uri, true)](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_uri) could return (they should never return as per the documentation). this bug had appeared in ngx_lua v0.3.1rc4 and ngx_openresty 1.0.6.13. thanks [@cyberty](http://weibo.com/cyberty) for reporting it.
    * feature: allow use of the `DDEBUG` macro from the outside (via the `-D DDEBUG=1` cc opton).
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to v0.1.2rc6.
    * bugfix: fixed all the warnings from the `clang` static analyzer.
    * feature: allow use of the `DDEBUG` macro from the outside (via the `-D DDEBUG=1` cc opton).
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.38rc1, [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22rc5,
[Headers More Nginx Module](headers-more-nginx-module.html) to 0.17rc1, and
[Memc Nginx Module](memc-nginx-module.html) to 0.13rc3, to allow use of the
`DDEBUG` macro from the outside (via the `-D DDEBUG=1` cc opton).

#  Stable Release 1.0.10.44 - 16 January 2012
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.16.
* bugfix: fixed compatibility of the packaging scripts on Darwin and *BSD. thanks
nightsailer and Piotr Sikora.

[Components](components.html) bundled with this release:
* LuaJIT-2.0.0-beta9
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc4
* echo-nginx-module-0.37
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.16
* iconv-nginx-module-0.10rc5
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.04
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.13rc2
* nginx-1.0.10
* ngx_devel_kit-0.2.17
* ngx_lua-0.4.0
* ngx_postgres-0.9rc2
* rds-csv-nginx-module-0.04
* rds-json-nginx-module-0.12rc7
* redis2-nginx-module-0.08rc2
* set-misc-nginx-module-0.22rc4
* srcache-nginx-module-0.13rc3
* upstream-keepalive-nginx-module-0.7
* xss-nginx-module-0.03rc8

#  Mainline Version 1.0.10.43 - 12 January 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.4.0.
* upgraded [Encrypted Session Nginx Module](encrypted-session-nginx-module.html) to 0.02.
    * bugfix: the `-lssl` option broke nginx linking when `--with-openssl=DIR` is specified. thanks charlieyang for reporting this issue.
* bugfix: fixed issues with relative path DIR in the `--with-openssl=DIR` option
for `./configure`.

#  Mainline Version 1.0.10.41 - 9 January 2012
* upgraded [Upstream Keepalive Nginx Module](upstream-keepalive-nginx-module.html) to 0.7.
    * Bugfix: unbuffered connection might not be kept alive under Linux.
    * Bugfix: module could not be built on Windows.
    * Bugfix: module could not be built without the ngx_http_ssl_module.
    * Feature: https connections support (requires patches).
    * Bugfix: invalid connections might be cached.
    * Bugfix: the "[alert] ... open socket ... left in connection ..." messages were logged on nginx worker process gracefull exit for each cached connection; the bug had appeared in version 0.3.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc8.
    * bugfix: fixed two spots that we did not check null pointers returned by the memory allocator.
    * bugfix: attempt to fix places where `ngx_time_update` might not be compiled properly.

#  Mainline Version 1.0.10.39 - 4 January 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc45.
    * bugfix: [ngx.req.get_uri_args](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_uri_args) and [ngx.req.get_post_args](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_post_args) now only parse up to 100 arguments by default. but one can specify the optional argument to these two methods to specify a custom maximum number of args. thanks Tzury Bar Yochay for reporting this.
    * bugfix:  [ngx.req.get_headers](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers) now only parse up to 100 request headers by default. but one can specify the optional argument to this method to specify a custom maximum number of headers.

#  Mainline Version 1.0.10.37 - 30 December 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc43.
    * bugfix: removing builtin headers via [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) and its equivalent in huge request headers with 20+ entries could result in data loss. thanks Chris Dumoulin for the patch in [github issue #6](https://github.com/openresty/headers-more-nginx-module/issues/6).
    * bugfix: could not compile with [Nginx](nginx.html) 1.1.12+ because [Nginx](nginx.html) 1.1.12 changed its regex API. now we call PCRE API directly and require at least PCRE 8.21 for the PCRE JIT support in our `ngx.re` API (since PCRE 8.20 had a bug in its JIT engine that it did not honor `pcre_malloc` and `pcre_free` at all).

#  Mainline Version 1.0.10.35 - 30 December 2011
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to v0.16rc7.
    * bugfix: removing builtin headers in huge request headers with 20+ entries could result in data loss. thanks Chris Dumoulin for the patch in [github issue #6](https://github.com/openresty/headers-more-nginx-module/issues/6).
* bugfix: the `install` phony target did not depend on the `all` phony target
in the Makefile generated by `./configure`. thanks [姚伟斌](http://weibo.com/yaoweibin) for
reporting this issue.

#  Mainline Version 1.0.10.33 - 29 December 2011
* bugfix: the `./configure` script's  `--add-module` option did not accept relative
path values. thanks [姚伟斌](http://weibo.com/yaoweibin) for the patch.

#  Mainline Version 1.0.10.31 - 25 December 2011
* upgraded [LuaJIT](luajit.html) to 2.0.0beta9.
    * changes: http://luajit.org/changes.html
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc42.
    * bugfix: [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) might cause invalid memory reads because [Nginx](nginx.html) request header values must be null terminated. thanks Maxim Dounin.
    * bugfix: `ngx.var.VARIABLE` might evaluate to nil even if there is a valid value because the [Nginx](nginx.html) variable value's `valid` flag might not be initialized properly. this bad had appeared in v0.3.1rc40.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to v0.16rc6.
    * bugfix: the [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_headers) directive might cause invalid memory reads because [Nginx](nginx.html) request header values must be null terminated. thanks Maxim Dounin.

#  Mainline Version 1.0.10.29 - 17 December 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc41.
    * bugfix: [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) and [ngx.req.clear_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) did not handle the `Accept-Encoding` request headers properly. thanks 天街夜色.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.16rc5.
    * bugfix: [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) and [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) did not handle the `Accept-Encoding` request headers properly. thanks 天街夜色.

#  Mainline Version 1.0.10.27 - 16 December 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc40.
    * bugfix: `ngx.flush(true)` could not be used before I/O calls like [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture). this bug had appeared in v0.3.1rc34.
    * bugfix: `ngx.var.VARIABLE` did not evaluate to `nil` when the [Nginx](nginx.html) variable's `valid` flag is `0`.
    * docs: various documentation improvements. thanks [Nginx](nginx.html) User.
    * bugfix: there were various places where we did not check the pointer returned by the memory allocator.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to v0.22rc4.
    * bugfix: fixed one place that does not check the pointer returned by the memory allocator.
    * src: converted `CRLF` in the source files and test files to `LF`.
* bugfix: some old version of shell `cp` command does not support trailing slashes
in the destination argument and could break our `./configure` script. thanks
[姚伟斌](http://weibo.com/yaoweibin) for reporting it.

#  Mainline Version 1.0.10.25 - 14 December 2011
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to v0.13rc3.
    * bugfix: fixed a regression with [Xss Nginx Module](xss-nginx-module.html) for cache hits. this bug had appeared in v0.13rc1. thanks [万珣新](http://weibo.com/liseen).
    * bugfix: we did not cache the `Location` response header at all for `301`/`302` responses.
    * bugfix: we should not blindly cache the `Accept-Ranges: bytes` response headers regardless of the actual current requests.
* upgraded [Xss Nginx Module](xss-nginx-module.html) to v0.03rc8.
    * bugfix: fixed a few debug-level log messages; the old text was misleading.

#  Stable Release 1.0.10.24 - 11 December 2011
Same as the devel version 1.0.10.23.

[Components](components.html) bundled with this release:
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
* memc-nginx-module-0.13rc2
* nginx-1.0.10
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.1rc38
* ngx_postgres-0.9rc2
* rds-csv-nginx-module-0.04
* rds-json-nginx-module-0.12rc7
* redis2-nginx-module-0.08rc2
* set-misc-nginx-module-0.22rc3
* srcache-nginx-module-0.13rc2
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc7

#  Mainline Version 1.0.10.23 - 5 December 2011
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to v0.12rc7.
    * added more debug level error log outputs to ease debugging (as discussed in [github issue #2](https://github.com/openresty/rds-json-nginx-module/issues/2)).
* upgraded [Xss Nginx Module](xss-nginx-module.html) to v0.03rc7.
    * now we use the `ngx_log_debugN` macros to emit debugging outputs instead of `info` level error logging because the latter is costly in production.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc38.
    * added constant `ngx.HTTP_GATEWAY_TIMEOUT` (504) per Fry-kun in [github issue #73](https://github.com/openresty/lua-nginx-module/issues/73).

#  Mainline Version 1.0.10.21 - 30 November 2011
* fixed a serious regression for Linux AIO in [nginx-1.0.10-epoll_check_stale_wev.patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.10-epoll_check_stale_wev.patch),
thanks Maxim Dounin for the patch's patch.

#  Mainline Version 1.0.10.19 - 29 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc37.
    * bugfix: use of the ngx.re API might lead to errors like `pcre_compile() failed: failed to get memory in ...` due to incorrect `pcre_malloc` and `pcre_free` handling. thanks Vittly for reporting this as [github issue #72](https://github.com/openresty/lua-nginx-module/issues/72).
    * docs: massive documentation improvements. thanks [Nginx](nginx.html) User.

#  Mainline Version 1.0.10.17 - 26 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc36.
    * bugfix: fixed the `ngx_log_debugN` macros which failed to compile without `--with-debug`. thanks [@ldmiao](http://weibo.com/ldmiao) for reporting it.

#  Mainline Version 1.0.10.15 - 26 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc35.
    * bugfix: now we check timed out downstream connections in our write event handler.

#  Mainline Version 1.0.10.13 - 25 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc34.
    * feature: added `wait` boolean argument to [ngx.flush()](http://wiki.nginx.org/HttpLuaModule#ngx.flush) to support synchronous flushing; `ngx.flush(true)` will not return until all the data has been flushed into the system send buffer or the send timeout has expired.

#  Mainline Version 1.0.10.11 - 24 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc33.
    * feature: added new Lua API [ngx.now](http://wiki.nginx.org/HttpLuaModule#ngx.now) to return the current time (including the ms part as the decimal part). thanks 林青.
    * feature: added new Lua API [ngx.update_time](http://wiki.nginx.org/HttpLuaModule#ngx.update_time) to forcibly updating nginx's time cache.
    * docs: massive documentation improvement done by [Nginx](nginx.html) User.

#  Mainline Version 1.0.10.9 - 24 November 2011
* upgraded [Xss Nginx Module](xss-nginx-module.html) to 0.03rc6.
    * bugfix: now we use `signed char` explicitly instead of the vague `char` type which could be unsigned by default in certain systems like PowerPC. thanks Dmitry E. Oboukhov.
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.13rc2.
    * bugfix: now we use `signed char` explicitly instead of the vague `char` type which could be unsigned by default in certain systems like PowerPC. thanks Dmitry E. Oboukhov.
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.08rc2.
    * bugfix: when `char` defaults to `unsigned char`, the Ragel-based Redis response parser could not accept non-ascci bytes. thanks Dmitry E. Oboukhov.

#  Mainline Version 1.0.10.7 - 23 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc31.
    * feature: added opions `copy_all_vars` and `vars` to [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and [ngx.location.capture_multi](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi). thanks Marcus Clyne for the patch.
    * bugfix: fixed a bad regression in [ngx.location.capture_multi](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi) when the request option table is specified. this bug had appeared in ngx_lua 0.3.1rc26 and ngx_openresty 1.0.9.1.

#  Mainline Version 1.0.10.5 - 21 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc30.
    * feature: added new regex options `"j"` and `"d"` to [ngx.re.match](http://wiki.nginx.org/HttpLuaModule#ngx.re.match), [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch), [ngx.re.sub](http://wiki.nginx.org/HttpLuaModule#ngx.re.sub), and [ngx.re.gsub](http://wiki.nginx.org/HttpLuaModule#ngx.re.gsub)  so as to enable the PCRE [JIT mode](http://www.manpagez.com/man/3/pcrejit/) and DFA mode, respectively. thanks [@姜大炮](http://weibo.com/egis) for providing the patch.

#  Mainline Version 1.0.10.3 - 17 November 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc29.
    * feature: added [ngx.hmac_sha1](http://wiki.nginx.org/HttpLuaModule#ngx.hmac_sha1). thanks [drdrxp](http://weibo.com/drdrxp).
    * docs: documented the long-existent [ngx.md5](http://wiki.nginx.org/HttpLuaModule#ngx.md5) and [ngx.md5_bin](http://wiki.nginx.org/HttpLuaModule#ngx.md5_bin) APIs.
    * docs: massive documentation improvements. thanks [Nginx](nginx.html) User.

#  Mainline Version 1.0.10.1 - 16 November 2011
* upgraded the [Nginx](nginx.html) core to 1.0.10.

See [ChangeLog1000009](changelog-1000009.html) for change log for ngx_openresty 1.0.9.x.
