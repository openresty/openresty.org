<!---
    @title         ChangeLog 1.4.2
    @creator       Yichun Zhang
    @created       2013-08-12 04:13 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-09-30 07:24 GMT
    @changes       70
--->


#  Mainline Version 1.4.2.9 - 29 September 2013
* bundled the new [Lua Resty Web Socket Library](lua-resty-web-socket-library.html) 0.01.
    * this Lua library implements both a nonblocking WebSocket server and a nonblocking WebSocket client based on [Lua Nginx Module](lua-nginx-module.html)'s cosocket API. thanks Hendrik Schumacher.
* bundled the new [Lua Resty Lock Library](lua-resty-lock-library.html) 0.01.
    * this Lua library implements a simple nonblocking mutex lock API based on [Lua Nginx Module](lua-nginx-module.html)'s shared memory dictionaries. Mostly useful for eliminating "dog-pile effects" and etc. thanks Sri Rao for the suggestion.
* upgraded [Lua Resty Redis Library](lua-resty-redis-library.html) to 0.16.
    * feature: added new redis commands bitcount, bitop, client, dump, hincrbyfloat, incrbyfloat, migrate, pexpire, pexpireat, psetex, pubsub, pttl, restore, and time. thanks alex-yam for the patch.
    * optimize: eliminated the [table.insert()](http://www.lua.org/manual/5.1/manual.html#pdf-table.insert) calls because they are slower than `tb[#tb + 1] = val`. thanks alex-yam for the patch. this gives 1.9% speed up for trivial set and get examples when [LuaJIT](luajit.html) 2.0.2 is used and 4.9% speed up when [LuaJIT](luajit.html)'s v2.1 git branch is used.
    * refactor: avoided using Lua 5.1's [module() function](http://www.lua.org/manual/5.1/manual.html#pdf-module) for defining our Lua modules because it has bad side effects.
    * docs: do not use 0 (i.e., unlimited) max idle time in the [set_keepalive()](https://github.com/agentzh/lua-resty-redis#set_keepalive) call in the code sample.
    * docs: added code samples for the redis commands `hmget` and `hmset`. this has already become a FAQ.
    * docs: added the [Redis Authentication](https://github.com/agentzh/lua-resty-redis#redis-authentication) section because it is already an FAQ.
    * docs: documented the `options` table argument for the [connect() method](https://github.com/agentzh/lua-resty-redis#connect).
    * docs: added a missing `local` keyword to the code sample. thanks Wendal Chen for the patch.
* upgraded [Lua Resty Memcached Library](lua-resty-memcached-library.html) to 0.12.
    * optimize: no longer use Lua tables and [table.concat()](http://www.lua.org/manual/5.1/manual.html#pdf-table.concat) to construct simple Memcached query strings. this gives 6.75% overall speed up for trivial `set` and `get` examples when [LuaJIT](luajit.html) 2.0.2 is used.
    * optimize: eliminated [table.insert()](http://www.lua.org/manual/5.1/manual.html#pdf-table.insert) because it is slower than `tb[#tb + 1] = val`.
    * refactor: avoided using Lua's [module() function](http://www.lua.org/manual/5.1/manual.html#pdf-module) for defining our Lua modules because it has bad side effects.
    * docs: use limited (10 sec) max idel timeout for in-pool connections in the code sample.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.0.
    * feature: added support for raw downstream cosocket via the [ngx.req.socket(true)](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket) API, upon which http upgrading protocols like WebSocket can be implemented with pure Lua (see [Lua Resty Web Socket Library](lua-resty-web-socket-library.html)). This API can also be used to bypass the [Nginx](nginx.html) output filters and emit raw HTTP response headers and/or HTTP response bodies. thanks Hendrik Schumacher and aviramc.
    * bugfix: memory invalid reads might happen when [ngx.flush(true)](http://wiki.nginx.org/HttpLuaModule#ngx.flush) was used: the "ctx" struct could get freed in the middle of processing and we should save the state explicitly on the C stack.
    * bugfix: the standard Lua coroutine API was not available in the context of [init_by_lua*](http://wiki.nginx.org/HttpLuaModule#init_by_lua) and threw out the "no request found" error. thanks Wolf Tivy for the report.
    * bugfix: massive compatibility fixes for the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report and jinglong for the patch for the [LuaJIT](luajit.html)/Lua bytecode loader.
    * bugfix: Lua VM might run out of memory when `lua_code_cache` is off; now we always enforce a full Lua GC cycle right after unloading most of the loaded Lua modules when the Lua code cache is turned off.
    * change: raised the "lua_code_cache is off" warning to an alert.
* upgraded [Nginx Devel Kit](nginx-devel-kit.html) to 0.2.19.
    * bugfix: fixed warnings from the Microsoft Visual C++ compiler. thanks Edwin Cleton for the report.

#  Stable Version 1.4.2.8 - 22 September 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.10.
    * bugfix: we did not declare the "level" local variable of `ngx_http_lua_ngx_log` at the beginning of the code block. thanks Edwin Cleton for the report.
    * docs: documented more limitations in the current implementation.
    * docs: avoided using [module()](http://www.lua.org/manual/5.1/manual.html#pdf-module) and also recommended the [lua-releng tool](https://github.com/agentzh/nginx-devel-utils/blob/master/lua-releng) to locate misuse of Lua globals.
The following components are bundled in this release:
* LuaJIT-2.0.2
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.6
* echo-nginx-module-0.48
* encrypted-session-nginx-module-0.03
* form-input-nginx-module-0.07
* headers-more-nginx-module-0.22
* iconv-nginx-module-0.10
* lua-5.1.5
* lua-cjson-1.0.3
* lua-rds-parser-0.05
* lua-redis-parser-0.10
* lua-resty-dns-0.10
* lua-resty-memcached-0.11
* lua-resty-mysql-0.13
* lua-resty-redis-0.15
* lua-resty-string-0.08
* lua-resty-upload-0.08
* memc-nginx-module-0.13
* nginx-1.4.2
* ngx_coolkit-0.2rc1
* ngx_devel_kit-0.2.18
* ngx_lua-0.8.10
* ngx_postgres-1.0rc3
* rds-csv-nginx-module-0.05rc2
* rds-json-nginx-module-0.12rc10
* redis-nginx-module-0.3.6
* redis2-nginx-module-0.10
* set-misc-nginx-module-0.22
* srcache-nginx-module-0.22
* xss-nginx-module-0.03rc9

#  Mainline Version 1.4.2.7 - 15 September 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.9.
    * bugfix: the [Nginx](nginx.html) core does not send a default status line for the 101 status code. now we construct one ourselves in this case.
    * bugfix: nil "pool" option values led to errors in [tcpsock:connect()](http://wiki.nginx.org/HttpLuaModule#tcpsock:connect).
    * bugfix: [tcpsock:receive(0)](http://wiki.nginx.org/HttpLuaModule#tcpsock:receive) could hang until new data arrived or the timeout error happened; now it always returns an empty string immediately. this new behaviour diverges from the [LuaSocket library](http://w3.impa.br/~diego/software/luasocket/) though.
    * bugfix: for SPDY requests, we (temporarily) disable the Lua API functions [ngx.location.capture](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture), [ngx.location.capture_multi](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi), and [ngx.req.socket](http://wiki.nginx.org/HttpLuaModule#ngx.req.socket), which are known to have problems in SPDY mode. The SPDY compatibility issue will eventually get fixed in the near future.
    * refactor: removed our own `ctx->headers_sent` field because we should use [Nginx](nginx.html) core's `r->header_sent` instead.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.48.
    * refactor: removed our own `ctx->headers_sent` field because we should use [Nginx](nginx.html) core's `r->header_sent` instead.
* bugfix: `./configure` now always removes existing Makefile before trying to
generate a new one.

#  Mainline Version 1.4.2.5 - 8 September 2013
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to 0.22.
    * bugfix: we did not escape `\0`, `\z`, `\b`, and `\t` properly in set_quote_sql_str according to the MySQL quoting rules. thanks Siddon Tang for the report.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.8.
    * feature: added new option "always_forward_body" to [ngx.location.capture()](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture) and [ngx.location.capture_multi()](http://wiki.nginx.org/HttpLuaModule#ngx.location.capture_multi), which controls whether to always forward the parent request's request body to the subrequest (even when the subrequest is not of the POST or PUT request method). thanks Matthieu Tourne for the request.
    * feature: now timeout errors in [tcpsock:receive()](http://wiki.nginx.org/HttpLuaModule#tcpsock:receive) and [tcpsock:receiveuntil()](http://wiki.nginx.org/HttpLuaModule#tcpsock:receiveuntil) no longer automatically close the current cosocket object (for both upstream and downstream connections). thanks Aviram Cohen for the original patch.
    * bugfix: we did not escape `\0`, `\z`, `\t`, and `\b` properly in [ngx.quote_sql_str()](http://wiki.nginx.org/HttpLuaModule#ngx.quote_sql_str). thanks Siddon Tang for the report.
    * bugfix: Lua backtrace dumps upon uncaught Lua exceptions did not work with the standard Lua 5.1 interpreter when the backtrace was deeper than 22 levels.
    * change: now we just dump the top 22 levels in the backtrace for uncaught Lua exceptions for the sake of simplicity.
    * change: we now limit the number of nested coroutines in the backtrace dump for uncaught Lua exceptions by 5.
    * optimize: grouped the Lua string concatenation operations when constructing the backtrace string for uncaught Lua exceptions.

#  Mainline Version 1.4.2.3 - 2 September 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.7.
    * feature: [log_by_lua*](http://wiki.nginx.org/HttpLuaModule#log_by_lua) now always runs before the standard [ngx_http_log_module](http://nginx.org/en/docs/http/ngx_http_log_module.html) (for access logging). thanks Calin Don for the suggestion.
    * feature: added new API [ngx.config.debug](http://wiki.nginx.org/HttpLuaModule#ngx.config.debug) to indicate whether this is a debug build of [Nginx](nginx.html) (that is, being built by the `./configure` option `--with-debug`).
    * bugfix: the global Lua state's `_G` table was cleared when [lua_code_cache](http://wiki.nginx.org/HttpLuaModule#lua_code_cache) was off, which could confuse the setup in [init_by_lua*](http://wiki.nginx.org/HttpLuaModule#init_by_lua). thanks Robert Andrew Ditthardt for the report.
    * bugfix: [ngx.flush()](http://wiki.nginx.org/HttpLuaModule#ngx.flush) triggered response header sending when the header was not sent yet. now it just returned the error string "nothing to flush" for this case. thanks linbo liao for the report.
    * bugfix: when a Lua line comment was used in the last line of the inlined Lua code chunk, a bogus Lua syntax error would be thrown.
    * bugfix: [ngx.exit](http://wiki.nginx.org/HttpLuaModule#ngx.exit)(204) could try to send the response header twice. [Nginx](nginx.html) 1.5.4 caught this issue.
    * bugfix: the error message for failures in loading inlined Lua code was misleading.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.47.
    * bugfix: use of C global variables at configuration time could lead to issues when HUP reload failed in the middle.
    * bugfix: we might send the response header twice when an error happens. this issue is exposed by [Nginx](nginx.html) 1.5.4. thanks Markus Linnala for the report.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.6.
    * bugfix: compilation error happened with nginx 1.5.3+ because [Nginx](nginx.html) changes the `ngx_sock_ntop` API.
    * docs: typo fixes from smallfish.
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.13.
    * bugfix: fixed compatibility issues with the new upstream C API in [Nginx](nginx.html) 1.5.3+. thanks Markus Linnala for the patch.
    * bugfix: use of C global variables at configuration time could cause issues when HUP reload failed in the middle.
    * docs: now we recommend [Lua Resty Memcached Library](lua-resty-memcached-library.html) instead when being used with [Lua Nginx Module](lua-nginx-module.html).
* applied the [unix_socket_accept_over_read patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.2-unix_socket_accept_over_read.patch) the
[Nginx](nginx.html) core to fix a memory over-read issue when [Nginx](nginx.html) was
accepting a unix domain socket.

#  Mainline Version 1.4.2.1 - 11 August 2013
* upgraded the [Nginx](nginx.html) core to 1.4.2.
    * see http://nginx.org/en/CHANGES-1.4 for changes.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.10.
    * feature: now we return all the answer records even when the DNS server returns a non-zero error code, in which case the error code and error string are now set as the "errcode" and "errstr" fields in the Lua table returned. thanks Matthieu Tourne for requesting this.
See [ChangeLog 1.4.1](changelog-1004001.html) for change log for [OpenResty](openresty.html) 1.4.1.x.
