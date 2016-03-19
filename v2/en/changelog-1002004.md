<!---
    @title         ChangeLog 1.2.4
    @creator       Yichun Zhang
    @created       2012-10-14 19:13 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-12-23 22:52 GMT
    @changes       101
--->


#  Stable Release 1.2.4.14 - 23 December 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.9.
    * bugfix: assignment to [ngx.status](http://wiki.nginx.org/HttpLuaModule#ngx.status) would always be overridden by the later [ngx.exit()](http://wiki.nginx.org/HttpLuaModule#ngx.exit) calls for HTTP 1.0 requests if [lua_http10_buffering](http://wiki.nginx.org/HttpLuaModule#lua_http10_buffering) is on (the default setting). thanks chenshu for reporting this issue.
    * bugfix: there was a typo in the error message when accessing an [Nginx](nginx.html) variable that has not been defined.
    * docs: documented the request body automatic inheritance behaviour in [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture).
    * docs: fixed incorrect dates shown in the code samples for [ngx.http_time](http://wiki.nginx.org/HttpLuaModule#ngx.http_time) and [ngx.parse_http_time](http://wiki.nginx.org/HttpLuaModule#ngx.parse_http_time). thanks Gosuke Miyashita for the patch.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.05.
    * bugfix: unexpected runtime exceptions would be thrown when `resty.upload` met a in-part header field line or a terminating boundary line that was too long. this bug had appeared in [Lua Resty Upload Library](lua-resty-upload-library.html) 0.04 and [OpenResty](openresty.html) 1.2.4.7.
    * bugfix: `resty.upload` could not parse `Content-Type` request header values like `boundary="simple boundary"`, that is, with double quotes around the boundary value.
    * optimize: marked internal auxiliary functions as Lua `local` functions.
The following components are bundled:
* LuaJIT-2.0.0
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.4
* echo-nginx-module-0.41
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
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
* lua-resty-upload-0.05
* memc-nginx-module-0.13rc3
* nginx-1.2.4
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.17
* ngx_lua-0.7.9
* ngx_postgres-1.0rc2
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.09
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.16
* xss-nginx-module-0.03rc9

#  Mainline Version 1.2.4.13 - 11 December 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.8.
    * bugfix: [ngx.req.set_body_file()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file) might lead to memory issues because it directly used the storage of Lua strings allocated by the Lua GC (we should have allocated a new memory block on the [Nginx](nginx.html) side and copy the string data over).
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.12.
    * feature: convert the MySQL `newdecimal` typed fields to Lua numbers by default as requested by shedar.
    * optimize: marked the internal Lua function `_recv_packet` as a `local` function.

#  Mainline Version 1.2.4.11 - 8 December 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.7.
    * feature: added [ngx.req.start_time()](http://wiki.nginx.org/HttpLuaModule#ngx.req.start_time) to return the request starting time in seconds (the milliseconds part is the decimal part just as in [ngx.now](http://wiki.nginx.org/HttpLuaModule#ngx.now)). thanks Matthieu Tourne for the patch.
    * feature: setting [ngx.status](http://wiki.nginx.org/HttpLuaModule#ngx.status) or calling [ngx.exit(N)](http://wiki.nginx.org/HttpLuaModule#ngx.exit) (where `N >= 300`) after sending out response headers no longer yields a Lua exception but only leaves an error message in the error.log file, which is useful for Lua land debugging. thanks Matthieu Tourne for requesting this.
    * feature: the user can now call [ngx.exit(444)](http://wiki.nginx.org/HttpLuaModule#ngx.exit) to abort pending subrequests in other "light threads" from within a "light thread".
    * feature: added new dtrace static probe `http-lua-user-thread-wait`.
    * bugfix: [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and [ngx.location.capture_multi](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi) might hang infinitely because the parent request might not be waken up right after the first time the `post_subrequest` callback was called.
    * bugfix: the "light thread" object created by [ngx.thread.spawn()](http://wiki.nginx.org/HttpLuaModule#ngx.thread.spawn) or [ngx.on_abort()](http://wiki.nginx.org/HttpLuaModule#ngx.on_abort) might be prematurely collected by the Lua GC because we did not correctly register its coroutine object into the Lua registry table. this bug may crash the Lua VM and [Nginx](nginx.html) workers under load. thanks Zhu Dejiang for reporting this issue.
    * bugfix: [ngx.thread.wait()](http://wiki.nginx.org/HttpLuaModule#ngx.thread.wait) might hang infinitely when more than 4 user "light threads" are created in the same request handler due to the incorrect use of `ngx_array_t` for `ngx_list_t`. thanks Junwei Shi for reporting this issue.
    * bugfix: when a user coroutine or user "light thread" dies with an error, our Lua backtrace dumper written in C may access one of its dead parent threads (if any) which could lead to segmentation faults.
    * bugfix: [ngx.exit(N)](http://wiki.nginx.org/HttpLuaModule#ngx.exit) incorrectly threw out Lua exceptions when `N` was 408, 499, or 444 and the response header was already sent. thanks Kindy Lin for reporting this issue.
    * bugfix: when the user callback function registered by [ngx.on_abort()](http://wiki.nginx.org/HttpLuaModule#ngx.on_abort) discarded the client abort event, the request would be aborted by force when the next client abort event happened.
    * bugfix: an English typo in the error message for [init_by_lua*](http://wiki.nginx.org/HttpLuaModule#init_by_lua).
* applied [slab_alloc_no_memory_as_info.patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.4-slab_alloc_no_memory_as_info.patch) to
lower the log level of the error message "ngx_slab_alloc() failed: no memory"
from "crit" to "info".
* bugfix: the [upstream_pipelining patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.4-upstream_pipelining.patch) introduced
a regression that when `upstream_next` is in action, [Nginx](nginx.html) might
hang. thanks Kindy Lin for reporting this issue.
* bugfix: include the latest changes in the [LuaJIT](luajit.html) 2.0 git repository
(up to git commit 2ad9834d).

#  Mainline Version 1.2.4.9 - 20 November 2012
* upgraded [LuaJIT](luajit.html) to 2.0.0 final.
    * change logs: http://luajit.org/changes.html
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.5.
    * bugfix: [ngx.req.clear_header()](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) would result in memory invalid reads when removing the 21st, 41st, 61st (and etc) request headers. thanks Umesh Sirsiwal for reporting this issue.
    * bugfix: [ngx.log()](http://wiki.nginx.org/HttpLuaModule#ngx.log) would truncate the log messages which have null characters (`\0`) in it. thanks Wang Xi for reporting this issue.
    * docs: eliminated the use of `package.seeall` in code samples and also explicitly discouraged the use of it.
    * docs: documented the special case that client closes the connection before [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) finishes reading the whole body.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.19.
    *  bugfix: [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) would result in memory invalid reads when removing the 21st, 41st, 61st (and etc.) request headers. thanks Umesh Sirsiwal for reporting this issue.
    * docs: fixed an issue in the sample code that tried to clear `Transfer-Encoding` which cannot actually be cleared. thanks koukou73gr.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.08.
    * bugfix: the `new()` method in the `resty.aes` module might use a random key when the `method` option is omitted in the `hash` table argument. thanks wsser for the patch.
    * feature: we now return a second string describing the error when either `iv` or `key` is bad.
* bugfix: `./configure --with-pcre=PATH` did not accept relative paths as `PATH`.
thanks smallfish for reporting this issue.

#  Mainline Version 1.2.4.7 - 11 November 2012
* upgraded [LuaJIT](luajit.html) to 2.0.0rc3.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.4.
    * feature: added new directive [lua_check_client_abort](http://wiki.nginx.org/HttpLuaModule#lua_check_client_abort) (default to `off`) for monitoring and processing the event that the client closes the (downstream) connection prematurely. thanks Zhu Dejiang for request this feature.
    * feature: added new Lua API [ngx.on_abort()](http://wiki.nginx.org/HttpLuaModule#ngx.on_abort) which is used to register user Lua function callback for the event that the client closes the (downstream) connection prematurely. thanks Matthieu Tourne for suggesting this feature.
    * feature: [ngx.exit](http://wiki.nginx.org/HttpLuaModule#ngx.exit)(N) can now abort pending subrequests when `N = 408` (request time out) or `N = 499` (client closed request) or `N = -1` (error).
    * bugfix: The TCP/stream cosocket's [connect()](http://wiki.nginx.org/HttpLuaModule#tcpsock:connect) method could not detect errors like "connection refused" when kqueue was used (on FreeBSD or Mac OS X, for example). thanks smallfish for reporting this issue.
    * bugfix: reading operations on [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) did not return any errors when the request body got truncated; now we return the "client aborted" error.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.09.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
    * bugfix: a debugging output might be sent to stdout unexpectedly in some code path.
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.10.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
    * docs: fixed typos in README. thanks cyberty for the patch.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.15.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
    * optimize: avoided using `ipairs()` which is slower than plain `for i=1,N` loops.
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.11.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
    * feature: now the [new()](https://github.com/agentzh/lua-resty-mysql#new) method will return a string describing the error as the second return value in case of failures.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.04.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.07.
    * refactor: avoided using `package.seeall` in Lua module definitions, which improves performance and also prevents subtle bad side-effects.
    * docs: typo-fixes in the code samples from Bearnard Hibbins.
* bugfix: nginx upstream modules could not detect the "connection refused" error
in time if kqueue was used; now we apply the [upstream_test_connect_kqueue patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.4-upstream_test_connect_kqueue.patch) for
the [Nginx](nginx.html) core.

#  Mainline Version 1.2.4.5 - 30 October 2012
* applied the official [hotfix #1 patch](http://luajit.org/download/beta11_hotfix1.patch) to
[LuaJIT](luajit.html) 2.0.0 beta11.
    * see details here: http://www.freelists.org/post/luajit/Hotfix1-for-LuaJIT200beta11
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.3.
    * feature: added the [get_keys](http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT.get_keys) method for the shared memory dictionaries for fetching all the (or the specified number of) keys (default to 1024 keys). thanks Brian Akins for the patch.

#  Mainline Version 1.2.4.3 - 17 October 2012
* upgraded [LuaJIT](luajit.html) to 2.0.0 beta11.
    * made [Lua Resty Redis Library](lua-resty-redis-library.html) 27% faster, [Lua Resty Memcached Library](lua-resty-memcached-library.html) 22% faster, and [Lua Resty MySQL Library](lua-resty-mysql-library.html) 15% faster, all for simple test cases loaded by ab, tested on Linux x86_64.
    * all Lua APIs involved with I/O in [Lua Nginx Module](lua-nginx-module.html) are faster in general.
    * complete change log: http://luajit.org/changes.html
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.09.
    * optimize: we now use Lua's own `table.concat()` to do string concatenation for all the memcached requests instead of relying on the [cosocket API](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) (on the C level) because calling the Lua C API is much slower especially when [LuaJIT](luajit.html) is in use. now for simple test cases loaded by `ab -k -c10`, we get 11.3% overall performance boost.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.2.
    * feature: now we can automatically detect the vendor-provided LuaJIT-2.0 package on Gentoo. thanks Il'ya V. Yesin for the patch. it is still recommended, however, to explicitly set the environments `LUAJIT_INC` and `LUAJIT_LIB`.

#  Mainline Version 1.2.4.1 - 14 October 2012
* upgraded the [Nginx](nginx.html) core to 1.2.4.
    * see http://nginx.org/en/CHANGES-1.2 for changes.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.7.1.
    * feature: implemented the "light threads" API, which allows asynchronous concurrent processing within a single [Nginx](nginx.html) request handler, based on automatically-scheduled Lua coroutines. thanks Lee Holloway for requesting this feature.
        * http://wiki.nginx.org/HttpLuaModule#ngx.thread.spawn
        * http://wiki.nginx.org/HttpLuaModule#ngx.thread.wait
    * bugfix: [ngx.re.gsub()](http://wiki.nginx.org/HttpLuaModule#ngx.re.gsub) might throw out the exception `attempt to call a string value` when the `replace` argument was a Lua function and the subject string was large. thanks Zhu Maohai for reporting this issue.
    * bugfix: older gcc versions might issue warnings like `variable 'nrets' might be clobbered by 'longjmp' or 'vfork'`, like gcc 3.4.3 (for Solaris 11) and gcc 4.1.2 (for Red Hat Linux). thanks Wenhua Zhang for reporting this issue.
    * docs: added a warning for [ngx.var.VARIABLE](http://wiki.nginx.org/HttpLuaModule#ngx.var.VARIABLE) that memory is allocated in the per-request memory pool. thanks lilydjwg.
    * docs: made it clear why `return` is recommended to be used with [ngx.exit()](http://wiki.nginx.org/HttpLuaModule#ngx.exit). thanks Antoine.
    * docs: massive wording improvements from Dayo.
* now we add [Srcache Nginx Module](srcache-nginx-module.html) before both [Lua Nginx Module](lua-nginx-module.html) and [Headers More Nginx Module](headers-more-nginx-module.html) so that the former's output filter runs *after* those
of the latter.

See [ChangeLog 1.2.3](changelog-1002003.html) for change log for [OpenResty](openresty.html) 1.2.3.x.
