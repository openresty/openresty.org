<!---
    @title         ChangeLog 1.0.15
    @creator       Yichun Zhang
    @created       2012-05-13 13:45 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2012-05-16 10:50 GMT
    @changes       2
--->


#  Mainline Version 1.0.15.5 - 16 May 2012
* upgraded [LuaJIT](luajit.html) to 2.0.0beta10.
    * see changes here: http://luajit.org/changes.html
* feature: added the `--with-luajit-xcflags=FLAGS` option to `./configure` to
add more C compiler options to [LuaJIT](luajit.html)'s build system.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc28.
    * bugfix: [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) did not honor the `Expect: 100-continue` request header and could hang. thanks Matthieu Tourne for the patch in [pull request #107](https://github.com/chaoslawful/lua-nginx-module/pull/107).
    * bugfix: the [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) object (i.e., the downstream cosocket object) did not work with HTTP 1.1 pipelined requests at all.
    * bugfix: the [ngx.req.socket()](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) object might lose the last part of the request body when receiving data. this regression had appeared in v0.5.0rc25. thanks Matthieu Tourne for reporting it.
    * feature: detailed backtraces (Lua callstack) will be automatically printed to `error.log` when the user Lua code is interrupted by Lua exceptions. thanks Matthieu Tourne for the patch in [pull request #107](https://github.com/chaoslawful/lua-nginx-module/pull/107).
    * optimize: removed dead code found by Simon Liu via scan-build.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.05rc2.
    * bugfix: the output buffer size would get wrong when the `affected_rows` field is larger than a single-digit number. thanks Wendal Chen for reporting this by using clang.
* upgraded [Lua Resty String Library](lua-resty-string-library.html) to 0.06.
    * added new Lua module `resty.random` that implements secure random and pseudo-random string generators. thanks Chase Colman for the patch.
    * added new Lua module `resty.aes` that exposes the AES submodule of OpenSSL via [LuaJIT](luajit.html) FFI. thanks Chase Colman for the patch.

#  Mainline Version 1.0.15.3 - 13 May 2012
* now we bundle Sergey A. Osokin's [Redis Nginx Module](redis-nginx-module.html), 0.3.6,
which is also enabled by default. thanks Zhu Feng for requesting this.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc27.
    * bugfix: nginx could crash on request finalization when running the cosocket cleanup handle due to the lack of check of the `ctx` pointer. thanks shaneeb for reporting this in [github issue #110](https://github.com/chaoslawful/lua-nginx-module/issues/110).
    * bugfix: [ngx.req.get_body_data()](http://wiki.nginx.org/HttpLuaModule#ngx.req.get_body_data) could not handle multi-buffer request bodies and discarded the body data after the first buffer.
    * bugfix: [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) was not accessible at all in `set_by_lua*`. thanks Pierre.
    * bugfix: fixed typo "on-array", which should be "non-array", in an error message.
    * optimize: now [ngx.log](http://wiki.nginx.org/HttpLuaModule#ngx.log) is much faster when the log level argument is lower than the actual [error_log](http://wiki.nginx.org/CoreModule#error_log) level specified in nginx.conf. thanks Matthieu Tourne for providing the patch.
    * optimize: now we call `ngx_http_lua_socket_finalize` in `cosocket:setkeepalive()` to help buffer reuse.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22rc8.
    * feature: added new directives [set_secure_random_alphanum](http://wiki.nginx.org/HttpSetMiscModule#set_secure_random_alphanum) and [set_secure_random_lcalpha|http://wiki.nginx.org/HttpSetMiscModule#set_secure_random_lcalpha]() for generating cryptographically strong random strings based on the `/dev/urandom` device. thanks Jeremy Wohl for the patch.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc8.
    * bugfix: the `Content-Length` response header for HEAD requests should leave intact when cache hits happen.
    * bugfix: the [srcache_store](http://wiki.nginx.org/HttpSRCacheModule#srcache_store) subrequest did not set the `Content-Length` request header properly for multi-buffer request bodies. thanks Feibo Lee for submitting the patch.
    * feature: HTTP conditional GET requests are now supported (both `If-Modified-Since` and `If-Unmodified-Since` request headers are properly handled). thanks Nginx_User777.
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to v0.09.
    * feature: added `redis.parser._VERSION`.
    * bugfix: now we use Lua userdata to allocate memory used on the C side to prevent potential leaks caused by malloc/free, as discussed in [github issue #6](https://github.com/agentzh/lua-redis-parser/issues/6).
* upgraded [Lua Rds Parser Library](lua-rds-parser-library.html) to 0.05.
    * feature: added `redis.parser._VERSION`.
    * bugfix: now we use Lua userdata to allocate memory used on the C side to prevent potential leaks caused by malloc/free, as discussed in [github issue #6](https://github.com/agentzh/lua-redis-parser/issues/6).
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.07.
    * feature: now the methods for the Memcached storage commands now accept Lua tables as the `value` argument. thanks Brian Akins for the patch.
* upgraded [Lua Resty Upload Library](lua-resty-upload-library.html) to 0.03.
    * feature: now the raw headers for each part are also returned, as suggested by zou2062 in [github issue #1](https://github.com/agentzh/lua-resty-upload/issues/1).
* applied the patch for a bug in `ngx_http_named_location` to the nginx core:
http://mailman.nginx.org/pipermail/nginx-devel/2012-May/002166.html
* applied the patch for a bug in the filter finalizer to the nginx core: http://mailman.nginx.org/pipermail/nginx-devel/2012-May/002190.html

#  Mainline Version 1.0.15.1 - 29 April 2012
* upgraded the [Nginx](nginx.html) core to 1.0.15.
* bugfix: now we also add `<openresty_prefix>/lualib/?/init.lua` to the default
`package.path` search list. thanks bigplum for reporting this issue.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.0rc25.
    * bugfix: cosocket connections from the connection pool might lead to segfaults if it is not used immediately. thanks xukaifu for reporting this as [github issue #108](https://github.com/chaoslawful/lua-nginx-module/issues/108).
    * bugfix: debug logging in the cosocket receive line method could lead to invalid memory reads under extreme network conditions. this issue was caught by [mockeagain](https://github.com/agentzh/mockeagain) in reading mode.
    * bugfix: downstream cosockets might hang on the receive(size) method call for slow connections. [mockeagain](https://github.com/agentzh/mockeagain) in reading mode caught this issue.
    * bugfix: we no longer forcibly quit the lua threads by clearing out its environment and running it blindly to the end because Lua GC will collect all those unfinished coroutines anyway.
    * bugfix: improved the longjmp handling when Lua panic happens.
    * bugfix: certain compilers might complain about missing declarations for types like `int8_t`. now we explicitly included `stdint.h`. thanks runner-mei for reporting it in [github issue #98](https://github.com/chaoslawful/lua-nginx-module/issues/98).
    * feature: added new constant `ngx.HTTP_OPTIONS` for the HTTP OPTIONS method.
    * feature: added support for OPTIONS method in the subrequest capture APIs. thanks Jónas Tryggvi Jóhannsson for requesting this in [github issue #102](https://github.com/chaoslawful/lua-nginx-module/issues/102).
    * feature: added publich C functions `ngx_http_lua_add_package_preload`, `ngx_http_lua_get_global_state`, and `ngx_http_lua_get_request` to help other [Nginx](nginx.html) C modules expose new functionalities to [Lua Nginx Module](lua-nginx-module.html). thanks Brian Akins for suggesting them in [github pull request #101](https://github.com/chaoslawful/lua-nginx-module/pull/101).
    * feature: made `ngx_http_lua_api.h` visible to other [Nginx](nginx.html) modules by adding `src/api/` to the `CORE_INCS` config variable value in the config file. thanks Brian Akins for suggesting this in [github pull request #105](https://github.com/chaoslawful/lua-nginx-module/pull/105).
    * feature: add the `gdbinit` script to ease Lua user code debugging (Wang Xiaozhe).
    * optimize: various optimizations in cosocket's timeout handling. this gives about 2.5+% performance boost in some benchmarks using [Lua Resty Redis Library](lua-resty-redis-library.html) and [Lua Resty MySQL Library](lua-resty-mysql-library.html).
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to v0.12rc8.
    * bugfix: Microsoft C compilers complained about missing declarations of the type `int8_t`. now we explicitly include `stdint.h`. thanks runner-mei for reporting this issue in [github issue #3](https://github.com/agentzh/rds-json-nginx-module/issues/3).
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22rc7.
    * bugfix: we should omit the [set_sha1](http://wiki.nginx.org/HttpSetMiscModule#set_sha1) directive when we do not have any SHA1 libraries (including OpenSSL) installed. thanks runner-mei for reporting this in [github issue #9](https://github.com/agentzh/set-misc-nginx-module/issues/9).
    * feature: added new config directive [set_rotate](http://wiki.nginx.org/HttpSetMiscModule#set_rotate).
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2rc7.
    * bugfix: reading data on a reused MySQL connection (coming from the connection pool) could hang due to the inactive read event when `poll` event API is used in nginx.
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.07.
    * fixed a typo in error messages.
    * skipped parsing those column fields that we do not use (yet). this makes things noticeably faster.

See [ChangeLog 1.0.11](changelog-1000011.html) for change log for ngx_openresty 1.0.11.x.
