<!---
    @title         ChangeLog 1.2.3
    @creator       Yichun Zhang
    @created       2012-08-22 19:16 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-10-08 21:56 GMT
    @changes       108
--->


#  Stable Release 1.2.3.8 - 8 October 2012
This release is essentially the same as the development version 1.2.3.7.

The following components are bundled:
* LuaJIT-2.0.0-beta10
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.4
* echo-nginx-module-0.41
* encrypted-session-nginx-module-0.02
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.18
* iconv-nginx-module-0.10rc7
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.10
* lua-resty-dns-0.08
* lua-resty-memcached-0.08
* lua-resty-mysql-0.10
* lua-resty-redis-0.14
* lua-resty-string-0.06
* lua-resty-upload-0.03
* memc-nginx-module-0.13rc3
* nginx-1.2.3
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.17
* ngx_lua-0.6.10
* ngx_postgres-1.0rc2
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.09
* set-misc-nginx-module-0.22rc8
* srcache-nginx-module-0.16
* xss-nginx-module-0.03rc9

#  Mainline Version 1.2.3.7 - 6 October 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.6.10.
    * feature: now [ngx.req.get_headers()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers) returns a Lua table with keys in the all-lower-case form by default. thanks James Hurst and Matthieu Tourne for the feature request.
    * feature: now [ngx.req.get_headers()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers) adds an `__index` metamethod to the resulting Lua table by default, which will automatically normalize the lookup key by converting upper-case letters and underscores in case of a lookup miss. thanks James Hurst and Matthieu Tourne for suggesting this feature.
    * feature: now [ngx.req.get_headers()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers) accepts a second (optional) argument, `raw`, for controlling whether to return the original form of the header names (that is, the original letter-case).
    * feature: added public C API functions `ngx_http_shared_dict_get` and `ngx_http_lua_find_zone` to allow other [Nginx](nginx.html) C modules or a patched [Nginx](nginx.html) core to directly access the [shared memory dictionaries](http://wiki.nginx.org/HttpLuaModule#lua_shared_dict) created by [Lua Nginx Module](lua-nginx-module.html). thanks Piotr Sikora for requesting this feature.
    * bugfix: fixed a compilation warning in the TCP/stream cosocket codebase when using (at least) gcc 3.4.6 for MIPS. thanks Dirk Feytons for reporting this as [GitHub issue #162](https://github.com/chaoslawful/lua-nginx-module/issues/162).

#  Mainline Version 1.2.3.5 - 1 October 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.6.8.
    * bugfix: [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) might loop infinitely when the pattern matches an empty string. thanks Lance Li and xingxing for tracking this issue down.
    * bugfix: pattern matching an empty substring in [ngx.re.gmatch](http://wiki.nginx.org/HttpLuaModule#ngx.re.gmatch) did not match at the end of the subject string.
    * bugfix: [ngx.re.gsub](http://wiki.nginx.org/HttpLuaModule#ngx.re.gsub) might enter infinite loops because it could not handle patterns matching empty strings properly.
    * bugfix: [ngx.re.gsub](http://wiki.nginx.org/HttpLuaModule#ngx.re.gsub) incorrectly skipped matching altogether when the subject string was empty.

#  Mainline Version 1.2.3.3 - 26 September 2012
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.6.7.
    * feature: implemented the [shdict:flush_expired(max_count?)](http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT.flush_expired) method for flushing out and removing expired items up to `max_count` (or unlimited when `max_count == 0`). thanks Brian Akins for the patch.
    * optimize: [tcpsock:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) now calls `c->send()` instead of `ngx_output_chain()`, which gives about 4% ~ 5% performance boost for a simple test case accessing Redis for several times.
    * optimize: we now skip processing in the default write event handler when the write event is not ready.
    * refactor: the I/O scheduler has been rewritten to keep track of the coroutine associated with each (non-blocking) I/O operation automatically, which paves a way to the upcoming `ngx.thread` API (aka the "lightweight thread" API).
    * refactor: now we use a new [Nginx](nginx.html) subrequest model that bypasses `ngx_http_postpone_filter_module` completely, which paves a way for arbitrary order of outputting among subrequests and their parents when the `ngx.thread API` lands in the near future.
    * bugfix: the "http finalize non-active request" alerts might happen when subrequests were used. thanks Lance Li for reporting this issue.
    * bugfix: reset the subrequest status code when the `ngx_http_upstream` request in the subrequest fails due to timeout errors or premature connection close and etc. this fix also requires the [nonbuffered-upstream-truncation patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-nonbuffered-upstream-truncation.patch) for the [Nginx](nginx.html) core to cancel a limitation in `ngx_http_upstream`.
    * bugfix: fixed the gcc error `-Werror=strict-aliasing` in the Lua/[LuaJIT](luajit.html) bytecode loader when `-O2` or above is used. thanks jinglong for the patch.
    * bugfix: the main request might be prematurely terminated if a subrequest issued by [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) (or its friends) was finalized with error codes.
    * bugfix: the [Nginx](nginx.html) built-in resolver might not be destroyed in time when it was used by [ngx.socket.tcp](http://wiki.nginx.org/HttpLuaModule#ngx.socket.tcp) and [ngx.socket.udp](http://wiki.nginx.org/HttpLuaModule#ngx.socket.udp).
    * bugfix: [coroutine.status()](http://wiki.nginx.org/HttpLuaModule#coroutine.status) returned `suspended` for `normal` coroutines.
    * bugfix: [coroutine.resume()](http://wiki.nginx.org/HttpLuaModule#coroutine.resume) did not return an error immediately when operating on `normal` coroutines.
    * bugfix: when the entry coroutine was yielded by [coroutine.yield()](http://wiki.nginx.org/HttpLuaModule#coroutine.yield) then after it was resumed automatically its status would still be `suspended`.
    * bugfix: the write event timer might not be removed in time in [ngx.flush(true)](http://wiki.nginx.org/HttpLuaModule#ngx.flush) when `ngx_handle_write_event` failed.
    * bugfix: always remove the read event timer during downstream cosocket finalization if it is not removed yet.
    * bugfix: [ngx.flush(true)](http://wiki.nginx.org/HttpLuaModule#ngx.flush) might not return immediately when it should.
    * bugfix: the `resume_handler` field of the subrequest `ctx` was not properly initialized.
    * feature: added new dtrace static probes `http-lua-user-coroutine-yield` and `http-lua-entry-coroutine-yield`.
    * docs: fixed the documentation for [ngx.req.set_header](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) and made it clear that the modified request headers will be inherited by the subrequests by default. thanks James Hurst for reporting this issue.
    * docs: documented the trick for doing background asynchronous jobs by using [ngx.eof()](http://wiki.nginx.org/HttpLuaModule#ngx.eof) + `keepalive_timeout 0`. thanks Lance Li for the suggestion.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to 0.10.
    * bugfix: Lua stack overflow would happen when too many Redis arguments were passed into the [build_query](http://wiki.nginx.org/LuaRedisParser#build_query) method. thanks Guo Yin for reporting this issue.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.08.
    * feature: added new method [tcp_query](https://github.com/agentzh/lua-resty-dns#tcp_query) to enforce pure TCP transportation for the DNS queries.
    * feature: added support for TCP retries when the UDP reply gets truncated.
    * feature: added support for `PTR` queries and records.
    * feature: added support for `TXT` queries and records.
    * feature: added support for `NS` queries and records.
    * bugfix: the udp resolver did not discard DNS replies with unmatched IDs for 128 times as originally designed.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.14.
    * optimize: now we do the string concatenation for Redis queries on the Lua land instead of on the C land, which gives 6% ~ 7% over-all performance boost when using [LuaJIT](luajit.html) 2.0 beta10.
    * docs: fixed a typo in the sample code. thanks xingxing for reporting it.
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.08.
    * feature: added new option `key_transform` to the [new method](https://github.com/agentzh/lua-resty-memcached#new) to allow the user to override the default escaping and unescaping methods for Memcached keys. thanks Matthieu Tourne for the patch.
    * bugfix: now the [new method](https://github.com/agentzh/lua-resty-memcached#new) will return a string describing the error as the second return value in case of failures.
    * docs: added more documentation for the [set_keepalive](https://github.com/agentzh/lua-resty-memcached#set_keepalive) method.
    * docs: documented that this library cannot be used in those contexts where the [Lua Nginx Module](lua-nginx-module.html) cosocket API is unavailable.
    * docs: documented that storing the object instance into Lua module-level variables will result in failures for concurrent requests.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.16.
    * bugfix: [srcache_fetch](http://wiki.nginx.org/HttpSRCacheModule#srcache_fetch) would use truncated responses from [Memc Nginx Module](memc-nginx-module.html) or other upstream modules. this usually happened when the upstream read timer was expired or the upstream prematurely closed the connection. this fix also requires the [nonbuffered-upsteram-truncation patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-nonbuffered-upstream-truncation.patch) to cancel a limitation in the [Nginx](nginx.html) core. thanks Bryan Alger for reporting the issue.
    * bugfix: the main request response was not discarded by [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) when there was an error in the last minute (like a read-timeout error or premature connection close happens when `ngx_http_upstream` reads the upstream response body). this fix also requires the [nonbuffered-upstream-truncation patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-nonbuffered-upstream-truncation.patch) for the [Nginx](nginx.html) core to cancel a limitation in `ngx_http_upstream`.
    * bugfix: the main request might prematurely terminate if the [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) subrequest was finalized with error codes.
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.09.
    * bugfix: directives [redis2_query](http://wiki.nginx.org/HttpRedis2Module#redis2_query), [redis2_literal_raw_query](http://wiki.nginx.org/HttpRedis2Module#redis2_literal_raw_query), and [redis2_raw_queries](http://wiki.nginx.org/HttpRedis2Module#redis2_raw_queries) could not be inherited automatically by the `location if` blocks, resulting in the "no redis2 query specified or the query is empty" error. thanks Tomasz Prus for the patch.
* feature: updated the [dtrace patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-dtrace.patch) to
add new static probe `create-pool-done`.
* feature: updated the [dtrace patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-dtrace.patch) to
include new tapset functions `ngx_indent`, `ngx_http_subreq_depth`, and `ngx_http_req_parent`.
* bugfix: added the [nonbuffered-upstream-truncation patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-nonbuffered-upstream-truncation.patch) for
the [Nginx](nginx.html) core to make `ngx_http_upstream` provide a way in the
context of a subrequest to signal the parent of errors when upstream data truncation
happens. thanks Bryan Alger for reporting this issue. (This is a temporary solution
and I'll work on a new patch as per Maxim Dounin's suggestions.)
* bugfix: applied the [channel-uninit-params patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-channel-uninit-params.patch) for
the [Nginx](nginx.html) core to fix Valgrind/Memcheck warnings about unitialized
bytes in the parameters of `sendmsg`.
* feature: updated the [allow_request_body_updating patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.3-allow_request_body_updating.patch) to
define the `HAVE_ALLOW_REQUEST_BODY_UPDATING_PATCH` macro.

#  Mainline Version 1.2.3.1 - 22 August 2012
* upgraded the [Nginx](nginx.html) core to 1.2.3.
    * see http://nginx.org/en/CHANGES-1.2 for changes.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.6.2.
    * feature: (re)implemented the standard Lua [coroutine API](http://wiki.nginx.org/HttpLuaModule#coroutine.create), which means that the user is now free to create and run their own coroutines within the boilerplate coroutine created automatically by [Lua Nginx Module](lua-nginx-module.html). thanks chaoslawful and jinglong for the design and implementation.
    * feature: added new dtrace static probes for the user coroutine mechanism: `http-lua-coroutine-create` and `http-lua-coroutine-resume`.
    * feature: added new dtrace static probes for the cosocket mechanism: `http-lua-socket-tcp-send-start`, `http-lua-socket-tcp-receive-done`, and `http-lua-socket-tcp-setkeepalive-buf-unread`.
    * bugfix: the send timeout timer for downstream output was not deleted in time in our write event handler, which might result in request abortion for long running requests. thanks Demiao Lin (ldmiao) for reporting this issue.
    * bugfix: [tcpsock:send()](http://wiki.nginx.org/HttpLuaModule#tcpsock:send) might send garbage if it was not the first call: we did not properly initialize the chain writer ctx for every `send()` call. thanks Zhu Dejiang for reporting this issue.
    * bugfix: the `ngx_http_lua_probe.h` header file was not listed in the `NGX_ADDON_DEPS` list in the `config` file.
    * optimize: removed unnecessary code that was for the old coroutine abortion mechanism based on Lua exceptions. we no longer need that at all because we have switched to using coroutine yield to abort the current coroutine for `ngx.exec`, `ngx.exit`, `ngx.redirect`, and `ngx.req.set_uri(uri, true)`.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.06.
    * feature: added support for MX type resource records.
    * feature: unrecognized types of resource records will return their raw resource data (RDATA) as the `rdata` Lua table field.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.13.
    * feature: added new method [read_reply](https://github.com/agentzh/lua-resty-redis#read_reply), mostly for using the [Redis Pub/Sub API](http://redis.io/topics/pubsub/).
    * feature: added new class method [add_commands](https://github.com/agentzh/lua-resty-redis#add_commands) to allow adding support for new Redis commands on-the-fly. thanks Praveen Saxena for requesting this feature.
    * docs: added a code sample for using the [Redis transactions](https://github.com/agentzh/lua-resty-redis#redis-transactions).
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.4.
    * bugfix: the `open socket #N left in connection` alerts would appear in the nginx error log file when the MySQL/Drizzle connection pool was used and the worker process was shutting down.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc2.
    * bugfix: the `open socket #N left in connection` alerts would appear in the nginx error log file when the PostgreSQL connection pool was used and the worker process was shutting down.
    * bugfix: removed the useless http-cache related code from `ngx_postgres_upstream_finalize_request` to suppress clang warnings.
* added more dtrace static probes to the [Nginx](nginx.html) core: `timer-add`,
`timer-del`, and `timer-expire`.
* added more [systemtap](http://sourceware.org/systemtap/) tapset functions:
`ngx_chain_next`, `ngx_chain_writer_ctx_out`, `ngx_chain_dump`, and `ngx_iovec_dump`.

See [ChangeLog 1.2.1](changelog-1002001.html) for change log for [OpenResty](openresty.html) 1.2.1.x.
