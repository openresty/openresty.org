<!---
    @title         ChangeLog 1.0.11
    @creator       Yichun Zhang
    @created       2012-02-02 04:53 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-03-25 07:25 GMT
    @changes       56
--->


#  Stable Release 1.0.11.28 - 25 March 2012
Same as the devel release 1.0.11.27.

[Components](components.html) bundled with this release:
* LuaJIT-2.0.0-beta9 (hotfix #1)
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc6
* echo-nginx-module-0.38rc2
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.17rc1
* iconv-nginx-module-0.10rc7
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.04
* lua-redis-parser-0.09rc7
* lua-resty-memcached-0.06
* lua-resty-mysql-0.06
* lua-resty-redis-0.08
* lua-resty-string-0.05
* lua-resty-upload-0.02
* memc-nginx-module-0.13rc3
* nginx-1.0.11
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.17
* ngx_lua-0.5.0rc21
* ngx_postgres-0.9
* rds-csv-nginx-module-0.05rc1
* rds-json-nginx-module-0.12rc7
* redis2-nginx-module-0.08rc4
* set-misc-nginx-module-0.22rc5
* srcache-nginx-module-0.13rc6
* upstream-keepalive-nginx-module-0.7
* xss-nginx-module-0.03rc9

#  Mainline Version 1.0.11.27 - 22 March 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc21.
    * bugfix: made the sha1 library (or OpenSSL) an optional dependency, as suggested by runner-mei in [github issue #94](https://github.com/openresty/lua-nginx-module/issues/94).
    * bugfix: we did not declare C variables at the beginning of the current code block in `ngx_http_lua_del_thread`, reported by runner-mei in [github issue #93](https://github.com/openresty/lua-nginx-module/issues/93).
    * bugfix: incorrectly used `ngx_conf_log_error` by feeding `NGX_ERROR` as the first argument, as reported by runner-mei in [github issue #92](https://github.com/openresty/lua-nginx-module/issues/92).
    * bugfix: spelling errors in Lua exception message text.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.38rc2.
    * bugfix: [$echo_request_body](http://wiki.nginx.org/HttpEchoModule#.24echo_request_body) variable was not able to work on arbitrary request body chains (i.e., more than 2 chain links), just like the standard [$request_body](http://wiki.nginx.org/HttpCoreModule#.24request_body) variable that only processes the first two chain links. now [$echo_request_body](http://wiki.nginx.org/HttpEchoModule#.24echo_request_body) no longer has this limitation.
* applied the upstream_pipelining patch to the nginx core, as discussed here:
http://mailman.nginx.org/pipermail/nginx-devel/2012-March/002040.html this patch
is required at least for the pipelined requests support in nginx upstream modules.

#  Mainline Version 1.0.11.25 - 16 March 2012
* applied the null-character-fixes patch from the mainstream. The bug did result
in a disclosure of previously freed memory if upstream server returned specially
crafted response, potentially exposing sensitive information.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc6.
    * bugfix: fixed a typo in an error message text for response truncation check in [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store).

#  Mainline Version 1.0.11.23 - 15 March 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc19.
    * feature: added new directive [lua_http10_buffering](http://wiki.nginx.org/HttpLuaModule#lua_http10_buffering) which is `on` by default.
    * feature: added new constant `ngx.DECLINED`.
    * bugfix: [access_by_lua](http://wiki.nginx.org/HttpLuaModule#access_by_lua) could not work with the `satisfy any` configuration.
    * bugfix: now we recycle the special flush buffer and chain link for [ngx.flush](http://wiki.nginx.org/HttpLuaModule#ngx.flush) to prevent request-scoped memory leaks when emitting long data streams to the downstream.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc5.
    * feature: now [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) discards responses that are obviously truncated when the actual output data is shorter than what is declared in its `Content-Length` response header. thanks Greg Grensteiner.
    * bugfix: the access phase handler actually ran in a phase later than the `access` phase.
    * bugfix: HTTP HEAD requests that lead to a cache hits would cause memory issues like invalid reads.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.08.
    * feature: implemened redis pipelining API by adding new methods `init_pipeline`, `commit_pipeline`, and `cancel_pipeline`.

#  Mainline Version 1.0.11.21 - 7 March 2012
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.07.
    * feature: added the [evalsha](http://redis.io/commands/eval) command to the redis command table. thanks Chris Love.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.05.
    * feature: added new modules `resty.sha224`, `resty.sha256`, `resty.sha384`, and `resty.sha512` to exposes the OpenSSL API for the complete `SHA-2` hash function set. thanks @lhmwzy.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc17.
    * bugfix: time stamps could overflow on 32-bit systems in the shared dict API; now we explicitly use 64-bit integers.
    * feature: added new method `flush_all` to the shared dict. thanks Weiqiang Li.
    * docs: documented the max concurrent subrequest count limitation and max error log line size limit.

#  Mainline Version 1.0.11.19 - 1 March 2012
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.08rc4.
    * bugfix: redis "nil multi bulk replies" did not parse at all. thanks 郭颖 for reporting this issue.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to 0.09rc7.
    * bugfix: redis "nil multi bulk replies" did not parse at all. thanks 郭颖 for reporting this issue.

#  Mainline Version 1.0.11.17 - 29 February 2012
* feature: bundle [Lua Resty MySQL Library](lua-resty-mysql-library.html) 0.06,
which is enabled by default.
* feature: bundle [Lua Resty Redis Library](lua-resty-redis-library.html) 0.06,
which is enabled by default.
* feature: bundle [Lua Resty Memcached Library](lua-resty-memcached-library.html) 0.06,
which is enabled by default.
* feature: bundle [Lua Resty Upload Library](lua-resty-upload-library.html) 0.02,
which is enabled by default.
* feature: bundle [Lua Resty String Library](lua-resty-string-library.html) 0.04,
which is enabled by default.
* bugfix: no longer enable `-DLUAJIT_USE_VALGRIND` for [LuaJIT](luajit.html) when
`--with-debug` option is specified.
* bugfix: applied the official [hotfix #1 patch](http://luajit.org/download/beta9_hotfix1.patch) for
[LuaJIT](luajit.html) 2.0.0 beta9.
* feature: raised the default `NGX_HTTP_MAX_SUBREQUESTS` to 200, in sync with
the official repository.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc16.
    * bugfix: the shared dict storage might leak memory in the store: `ngx_http_lua_shdict_lookup` incorrectly assumed that nodes with identical keys are linked together, which might not be true after tree re-balancing. thanks the patch from Lanshun Zhou.
    * optimize: removed a redundant piece of code for subrequest `headers_in` fixes in `ngx_http_lua_adjust_subrequest`.

#  Mainline Version 1.0.11.15 - 24 February 2012
* now we enable the `-DLUAJIT_USE_VALGRIND -DLUA_USE_APICHECK -DLUA_USE_ASSERT` flags
for [LuaJIT](luajit.html) when the `--with-debug` option is specified.
* apply the [max_subrequests patch](https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.11-max_subrequests.patch) to
allow the `NGX_HTTP_MAX_SUBREQUESTS` macro to be overridden from the outside
and adjusted the default value from 50 to 100 because 50 is a little too conservative.
* upgraded [Xss Nginx Module](xss-nginx-module.html) to 0.03rc9, [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.05rc1,
and [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.08rc3, allowing enabling
`DDEBUG=1` globally.
* upgraded [Iconv Nginx Module](iconv-nginx-module.html) to 0.10rc7.
    * bugfix: enabling `DDEBUG=1` globally lead to compilation errors.
    * bugfix: could not work with HTTP 1.0 requests.
    * optimize: only register output filters when the `iconv_filter` is actually used in the config file.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc15.
    * bugfix: the `exptime` argument to `shdict:set/add/etc` methods was incorrectly ignored when the `flags` argument is also specified. thanks the patch from Brian Akins.
    * docs: fixed various typos in docs. thanks 王斌.
    * bugfix: for big input data, the cosocket reading methods could result in crashes due to incorrect use of `luaL_Buffer`. now we eliminate `luaL_Buffer` altogether by managing the recv buffers ourselves. the recv buffers can also be recycled.
    * bugfix: now we avoid using `luaL_checkstring` which could do another `long jump` on its own. thanks 王斌.
    * bugfix: `tcpsocket:setkeepalive()` did not return errors when the current connection has readable data or there is still unread data in the [Lua Nginx Module](lua-nginx-module.html) upstream buffer.
    * bugfix: cosocket methods no longer explicitly return `nil` error strings upon success.
    * bugfix: when the parent request takes a request body, the subrequest does not take any bodies, and the subrequest's method is neither `PUT` nor `POST`, then the subrequest will no longer inherit the parent request's request body. thanks 欧远宁 for reporting this issue.
    * bugfix: data might be accidentally read into the Lua space on idle sockets when the last operation is a read operation *and* a read event suddenly arrives for edge-triggered event models. the same might also apply to write operations too.
    * bugfix: invalid reads might happen in the reading iterators returned by the `receiveuntil()` method which could lead to segfaults. this was a bug in the DFA minimizer's optimized code path.
    * bugfix: the `closed` error would occur for long-running requests that hold the idle cosocket object for a period of time that is longer than the read timeout setting: we should delete the read event timer in time when the `receive` call has already got a read event. thanks 欧远宁 for reporting this issue.
    * logs: added error logs for cosocket timeout errors.
    * logs: added detailed error logs for cosocket `closed` errors.
    * optimize: introduced a minor optimization that we can save one `recv` call when the read event is active *and* the read event is not ready.
    * optimize: now we recycle the downstream output buffers to save memory and dynamic allocation times for long-running requests with huge outputs.
    * bugfix: C macro directives were used inside a C macro argument which made (at least) gcc 3.2.3 unhappy. thanks Feng Bin.

#  Mainline Version 1.0.11.11 - 14 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc7.
    * bugfix: cosocket API could not be used before [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and its friends for fast network access: [tcpsock:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) method did not reset `u->waiting` properly. thanks 欧远宁.

#  Mainline Version 1.0.11.9 - 13 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc6.
    * bugfix: could not compile with nginx 0.8.x. thanks 欧远宁. this bug had appeared in [Lua Nginx Module](lua-nginx-module.html) v0.5.0rc1.
    * feature: added the [ngx.sha1_bin](http://wiki.nginx.org/HttpLuaModule#ngx.sha1_bin) method which returns the binary form of the `SHA-1` digest.
    * bugfix: we incorrectly allowed `ngx.null` in the string table argument to [cosocket:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) method.
    * feature: allow use of ngx.null in [ngx.log()](http://wiki.nginx.org/HttpLuaModule#ngx.log) and [print()](http://wiki.nginx.org/HttpLuaModule#print) arguments.
* added Piotr Sikora's [Coolkit Nginx Module](coolkit-nginx-module.html) 0.2rc1
to the bundle, which is also enabled by default.

#  Mainline Version 1.0.11.7 - 7 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc5.
    * feature: added constant `ngx.null` which is a `NULL` light userdata to represent `nil` values in Lua tables and etc. this is compatible with at least [lua-cjson](http://www.kyne.com.au/~mark/software/lua-cjson.php) library's `cjson.null` constant.

#  Mainline Version 1.0.11.5 - 7 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc4.
    * bugfix: setting `ngx.header.last_modified` was not implemented fully. thanks Brian Akins.

#  Mainline Version 1.0.11.3 - 6 February 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc3.
    * feature: now [tcpsocket:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) method supports lua tables of string fragments which can save unnecessary string concatenation operations on the Lua land that are usually quite expensive.
    * bugfix: fixed issues in debugging logs for the cosocket API.
    * feature: added user flags support to the [shared dictionary API](http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT). thanks Brian Akins.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to 0.09rc6.
    * bugfix: remove unneeded string push operations. thanks Brian Akins.

#  Mainline Version 1.0.11.1 - 2 February 2012
* upgraded the [Nginx](nginx.html) core to 1.0.11.
    * see the changes here: http://nginx.org/en/CHANGES-1.0
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc1.
    * feature: implemented the coroutine-based TCP and Unix Domain client socket API (aka the "cosocket" API) that is mostly compatible with the [LuaSocket](http://w3.impa.br/~diego/software/luasocket/tcp.html) library.
    * feature: implemented built-in connection pool support for the cosocket API.
    * feature: added new function [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) to return a cosocket object for the downstream connection so as to do streaming request body reading. thanks Taylor Weibley for sponsoring the development work.
    * optimization: optimized the chain-link and buf recycle logic for the subrequest API and make it share free buffers with the cosocket API.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 0.9.
    * bugfix: Fix compatibility with poll, select and /dev/poll event models.
    * bugfix: Fix compatibility with PostgreSQL 9.x.
    * bugfix: Fix compatibility with nginx-1.1.4+.

See [ChangeLog 1.0.10](changelog-1000010.html) for change log for ngx_openresty 1.0.10.x.
