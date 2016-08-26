<!---
    @title         ChangeLog 1.11.2
--->

#  Version 1.11.2.1 - 24 August 2016

* upgraded the [Nginx](nginx.html) core to 1.11.2.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: bundled the sess_set_get_cb_yield patch for OpenSSL to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) directives of [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* win32: we now use pcre 8.39 and openssl 1.0.2h in our official build.
* feature: applied the `ssl_pending_session.patch` to the [nginx](nginx.html) core to support the [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
* feature: added `<openresty-prefix>/site/lualib/` to the default Lua module search paths used by OpenResty. This location is for 3rd-party Lua modules so that the users will not pollute the `<openresty-prefix>/lualib/` directory with non-standard Lua module files.
* feature: now we create the `<openresty-prefix>/bin/openresty` symlink which points to `<openresty-prefix>/nginx/sbin/nginx` to avoid polluting the `PATH` environment with the name "nginx".
* feature: added the `upstream_timeout_fields` patch to the [nginx](nginx.html) core to allow efficient per-request connect/send/read timeout settings for individual upstream requests and retries.
* feature: added the official LuaJIT documentation from LuaJIT 2.1 to our `restydoc` indexes.
* feature: added the Lua 5.1 reference manual from lua 5.1.5 to our restydoc indexes.
* bugfix: special characters like spaces in [nginx](nginx.html) configure option values (like `--with-pcre-opt` and `--with-openssl-opt`)  were not passed correctly. thanks Andreas Lubbe for the report.
* change: now we use our own version of default `index.html` and `50x.html` pages.
* upgraded [ngx_lua](https://github.com/openresty/lua-nginx-module#readme) to 0.10.6.
    * feature: added new shdict methods: [lpush](https://github.com/openresty/lua-nginx-module#ngxshareddictlpush),
[lpop](https://github.com/openresty/lua-nginx-module#ngxshareddictlpop),
[rpush](https://github.com/openresty/lua-nginx-module#ngxshareddictrpush),
[rpop](https://github.com/openresty/lua-nginx-module#ngxshareddictrpop),
[llen](https://github.com/openresty/lua-nginx-module#ngxshareddictllen)
for manipulating list-typed values. these methods can
be used in the same way as the redis commands of the same names. Essentially we now have shared memory based queues now. each queue is indexed by a key. thanks
Dejiang Zhu for the patch.
    * feature: implemented [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block) configuration directives for doing (distributed) caching of SSL sessions (via SSL session IDs) for downstream connections. thanks Zi Lin for the patches.
    * feature: added pure C API for setting upstream request connect/send/read timeouts in [balancer_by_lua*](https://github.com/openresty/lua-nginx-module#balancer_by_lua_block) on a per session basis. thanks Jianhao Dai for the original patch.
    * feature: ssl: add [FFI](http://luajit.org/ext_ffi.html) functions to parse certs and private keys to cdata. With the current [FFI](http://luajit.org/ext_ffi.html) functions the certificate chain and the private key are parsed from DER every time they are set into the SSL state. Now we can cache the parsed certs and private keys as cdata objects directly. These new functions make it possible to avoid the DER -> OpenSSL parsing. Thanks Alessandro Ghedini for the patch.
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: allow [tcpsock:setkeepalive()](https://github.com/openresty/lua-nginx-module#tcpsocksetkeepalive) to receive nil args. thanks Thibault Charbonnier for the patch.
    * bugfix: `*_by_lua_file`: did not support absolute file paths on non-UNIX systems like Win32. thanks Someguynamedpie for the report and the original patch.
    * bugfix: fake connections did not carry a proper connection number. thanks Piotr Sikora for the patch.
    * bugfix: "lua_check_client_abort on" broke HTTP/2 requests.
    * bugfix: `ngx_http_lua_ffi_ssl_create_ocsp_request`: we did not clear the openssl stack errors in the right place.
    * bugfix: [ngx.sha1_bin()](https://github.com/openresty/lua-nginx-module#ngxsha1_bin) was always disabled with [nginx](nginx.html) 1.11.2+ due to incompatible changes in [nginx](nginx.html) 1.11.2+. thanks manwe for the report.
    * bugfix: segfaults might happen when calling [ngx.log()](https://github.com/openresty/lua-nginx-module#ngxlog) in [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block) and error_log was configured with syslog. thanks Jonathan Serafini and Greg Karékinian for the report.
    * bugfix: fixed a typo in the error handling of the `SSL_get_ex_new_index()` call for our ssl ctx index. thanks Jie Chen for the report.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [ngx.req.set_header()](https://github.com/openresty/lua-nginx-module#ngxreqset_header) and [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module#ngxreqclear_header) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed crashes in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) for HTTP/2 requests. now we always throw out a Lua exception in [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) when being called in HTTP/2 requests.
    * bugfix: specifying the C macro `NGX_LUA_NO_FFI_API` broke the build. thanks jsopenrb for the report.
    * doc: [ngx.worker.count()](https://github.com/openresty/lua-nginx-module#ngxworkercount) is available in the [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua) context.
    * doc: documented that [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) does not work in HTTP/2 requests.
    * doc: typo fixes from Otto Kekäläinen and Nick Galbreath.
* upgraded [lua-resty-core](https://github.com/openresty/lua-resty-core#readme) to 0.1.8.
    * updated the `resty.core.shdict` Lua module to reflect the recent addition of list-typed shdict values in [ngx_lua](https://github.com/openresty/lua-nginx-module#readme).
    * feature: [shdict:incr()](https://github.com/openresty/lua-nginx-module#ngxshareddictincr): added the optional `init` argument to allow intializing nonexistent keys with an initial value.
    * feature: added the [ngx.ssl.session](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl/session.md#readme) module for the contexts [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block) and [ssl_session_store_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_store_by_lua_block). thanks Zi Lin for the patches.
    * feature: [ngx.balancer](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#readme): added new API functions [set_timeouts()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/balancer.md#set_timeouts) for setting per-session connect/send/read timeouts for the current upstream request and subsequent retries. thanks Jianhao Dai for the patch.
    * feature: [ngx.ssl](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#readme): add new API functions [parse_pem_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_cert), [parse_pem_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#parse_pem_priv_key), [set_cert()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_cert), and [set_priv_key()](https://github.com/openresty/lua-resty-core/blob/master/lib/ngx/ssl.md#set_priv_key). thanks Alessandro Ghedini for the patch.
* upgraded [lua-resty-dns](https://github.com/openresty/lua-resty-dns#readme) to 0.17.
    * feature: now we support parsing answer records in all the answer sections (`AN`, `NS`, and `AR`). thanks Zekai Zheng for the patch.
    * optimize: commented out 3 lines of useless Lua code in `parse_response()`.
* upgraded [lua-resty-redis](https://github.com/openresty/lua-resty-redis#readme) to 0.25.
    * feature: now this module automatically generate Lua methods for *any* Redis commands the caller attempts to use.
The lazily generated Lua methods are cached in the Lua module table for faster subsequent uses.
In theory, any Redis commands in existing Redis or even future Redis servers can work out of the box. thanks spacewander for the patch.
* upgraded [ngx_lua_upstream](https://github.com/openresty/lua-upstream-nginx-module#readme) to 0.06.
    *  feature: added [upstream.current_upstream_name()](https://github.com/openresty/lua-upstream-nginx-module#current_upstream_name) to return the proxy target used in the current request. thanks Justin Li for the patch.
    * minor Lua table initialization optimizations from Scott Francis.
* upgraded [resty-cli](https://github.com/openresty/resty-cli#readme) to 0.13.
    * bugfix: restydoc: pod2man from older perl versions (like 5.8) does not support `-u` option. we should be smarter here.
    * bugfix: when resty/restydoc/restydoc-index were invoked through symlinks, they might fail to locate the [nginx](nginx.html) executable of openresty.
    * bugfix: POD errors might get displayed in pod2man with older versions of perl (like perl 5.20.2). thanks Dominic for the patch.
    * bugfix: pod2man might abort with a "Can't open file" error with perl 5.24+.
    * bugfix: restydoc-index: improved the seciton name normalization for the documentation indexes.
* upgraded [ngx_echo](https://github.com/openresty/echo-nginx-module#readme) to 0.60.
    * bugfix: fixed compilation failures when specifying the C compiler option `-DDDEBUG=2`. thanks amdei for the report.
    * bugfix: fixed crashes in `$echo_client_request_headers` for HTTP/2 requests. thanks dilyanpalauzov for the report.
Now $echo_client_request_headers always evaluates to an empty value (not found) in HTTP/2 requests.
    * doc: make it clearer when to use the `--` form.
* upgraded [ngx_headers_more](https://github.com/openresty/headers-more-nginx-module#readme) to 0.31.
    * bugfix: when the [nginx](nginx.html) core does not properly initialize `r->headers_in.headers` (due to 400 bad requests and etc), [more_set_input_headers](https://github.com/openresty/headers-more-nginx-module#more_set_input_headers) might lead to crashes. thanks Marcin Teodorczyk for the report.
    * bugfix: fixed a typo in an error message. thanks Albert Strasheim for the patch.
* upgraded [ngx_set_misc](https://github.com/openresty/set-misc-nginx-module#readme) to 0.31.
    * bugfix: the [set_sha1](https://github.com/openresty/set-misc-nginx-module#set_sha1) directive is always disabled when working with [nginx](nginx.html) 1.11.2+ due to recent changes in the new [nginx](nginx.html) cores.
* upgraded [ngx_encrypted_session](https://github.com/openresty/encrypted-session-nginx-module#readme) to 0.06.
    * doc: we do require [ngx_http_ssl_module](http://nginx.org/en/docs/http/ngx_http_ssl_module.html) to work properly.

See [ChangeLog 1.9.15](changelog-1009015.html) for change log for [OpenResty](openresty.html) 1.9.15.x.
