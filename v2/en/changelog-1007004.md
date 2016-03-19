<!---
    @title         ChangeLog 1.7.4
    @creator       Yichun Zhang
    @created       2014-08-16 21:45 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2014-10-10 00:00 GMT
    @changes       57
--->


#  Version 1.7.4.1 - 9 October 2014
* upgraded the [Nginx](nginx.html) core to 1.7.4.
    * see the changes here: http://nginx.org/en/CHANGES
* feature: added a new command-line utility, `resty`, to run Lua code or Lua
files (for [OpenResty](openresty.html)) directly from the command-line. it is
installed into the "<prefix>/bin" directory. prodded by Vitaly Kosenko. This
tool is currently experimental.
* bugfix: `./configure`: we might misuse the homebrew version of [LuaJIT](luajit.html) on
Mac OS X when the user specified the `--with-ld-opt="-L/usr/local/lib"` option.
thanks Aapo Talvensaari for the report.
* bugfix: `util/install`: remove the target file before overwriting to prevent
running processes (if any) from crashing.
* bugfix: `./configure`: call "sh" explicitly for nginx's `./configure` script
to prevent potential file permission issues.
* optimize: now we use the C compiler option `-O2` for everything by default
(we used to use `-O1` which is too conservative).
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc4.
    * bugfix: segmentation fault might happen in `ngx_destroy_pool` when debug logging was enabled in the nginx build. thanks buddy-ekb for the report.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.56.
    *  bugfix: our `create_loc_conf` callback did not return NULL on error. thanks Markus Linnala for the patch.
    * bugfix: reading [$echo_client_request_headers](https://github.com/openresty/echo-nginx-module#echo_client_request_headers) would return garbled data when LF instead of CRLF is used as the line terminator in the original header.
    * bugfix: reading [$echo_client_request_headers](https://github.com/openresty/echo-nginx-module#echo_client_request_headers) could lead to buffer overflow due to misuse of `r->header_end` while modules like ngx_fastcgi and ngx_proxy can change `r->header_end` to point to buffers of their own.
* upgraded [Form Input Nginx Module](form-input-nginx-module.html) to 0.10.
    * bugfix: "pcre_exec -2" error might happen when the standard "if" directive is used to test the empty value nginx variables set by this module with a regex. (Jiale)
    * bugfix: we incorrectly overrode `r->read_event_handler` with `ngx_http_request_empty_handler` in our "post read" callback for client request body reading, which could waste CPU time in level-triggered event models like poll and select. thanks chen for the catch.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) 0.26.
    * change: [set_escape_uri](https://github.com/openresty/set-misc-nginx-module#set_escape_uri): use uppercase hexadecimal digits for percent-encoding as per RFC 3986. thanks splitice for the original patch.
    *  bugfix: our `create_loc_conf` callback did not return NULL on error. thanks Markus Linnala for the patch.
    * bugfix: fixed source and test files' permission. they should not be executable at all. thanks Christos Kontas for the report.
* upgraded [LuaJIT](luajit.html) to v2.1-20140805: https://github.com/openresty/luajit2/tags
    * imported Mike Pall's latest bug fixes:
        * FFI: Fix `__index`/`__newindex` metamethod resolution for ctypes.
        * Invalidate backpropagation cache after DCE.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.9.12.
    * feature: implemented the SSL/TLS cosocket API.
        * added new method [sslhandshake()](https://github.com/openresty/lua-nginx-module#tcpsocksslhandshake) to the [stream-typed cosocket](https://github.com/openresty/lua-nginx-module#ngxsockettcp) objects.
        * added new configuration directives [lua_ssl_trusted_certificate](https://github.com/openresty/lua-nginx-module#lua_ssl_trusted_certificate), [lua_ssl_verify_depth](https://github.com/openresty/lua-nginx-module#lua_ssl_verify_depth), [lua_ssl_crl](https://github.com/openresty/lua-nginx-module#lua_ssl_crl), [lua_ssl_protocols](https://github.com/openresty/lua-nginx-module#lua_ssl_protocols), and [lua_ssl_ciphers](https://github.com/openresty/lua-nginx-module#lua_ssl_ciphers). thanks aviramc for the original patch.
    * feature: the standard coroutine API is now enabled in the context of [header_filter_by_lua*](https://github.com/openresty/lua-nginx-module#header_filter_by_lua) and [body_filter_by_lua*](https://github.com/openresty/lua-nginx-module#body_filter_by_lua). thanks ngo for the request.
    * feature: for content/rewrite/access_by_lua_file directives, we now return 404 status code instead of 500 in case that the specified .lua file cannot be opened. thanks Sam Lee for the suggestion.
    * feature: added pure C API function for FFI-based implementation of reading [ngx.header.HEADER](https://github.com/openresty/lua-nginx-module#ngxheaderheader).
    * feature: now we also explicitly check the Lua ABI/language version in our feature test of the `./configure` phase for a usable Lua lib.
    * feature: added pure C API functions for FFI-based implementations of [ngx.worker.pid()](https://github.com/openresty/lua-nginx-module#ngxworkerpid) and [ngx.worker.exiting()](https://github.com/openresty/lua-nginx-module#ngxworkerexiting).
    * bugfix: [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) could lead to buffer overflow and the "userdata length overflow" error due to misuse of `r->header_end` while modules like ngx_fastcgi and ngx_proxy can change `r->header_end` to point to buffers of their own. thanks sadmedved for the report.
    * bugfix: [ngx.req.raw_header()](https://github.com/openresty/lua-nginx-module#ngxreqraw_header) would return garbled data when LF instead of CRLF is used as the line terminator in the original header.
    * bugfix: [body_filter_by_lua*](https://github.com/openresty/lua-nginx-module#body_filter_by_lua): reading `ngx.arg[1]` after clearing `ngx.arg[1]` (by assigning nil or "") could lead to segmentation faults. this regression had appeared in v0.9.10. thanks Jason Stangroome for the report.
    * bugfix: [init_worker_by_lua*](https://github.com/openresty/lua-nginx-module#init_worker_by_lua_file) would conflict with some other nginx C modules (like ngx_proxy) when their `merge_loc_conf` callbacks (or alike) produce side-effects in `cf->cycle`. thanks Ruoshan Huang for the report.
    * bugfix: [stream-typed cosocket](https://github.com/openresty/lua-nginx-module#ngxsockettcp) might read uninitialized memory bytes when logging errors due to sending to or receiving from a closed socket.
    * bugfix: the stream-typed and datagram-typed cosockets' resolver handler did not handle some special errors correctly.
    * bugfix: [ngx.resp.get_headers()](https://github.com/openresty/lua-nginx-module#ngxrespget_headers): sometimes we might omit the builtin-headers Content-Type, Content-Length, Connection, and Transfer-Encoding. thanks Jon Keys for the report.
    * bugfix: [ngx.req.socket(true)](https://github.com/openresty/lua-nginx-module#ngxreqsocket): it incrrectly returned the error "chunked request bodies not supported yet" for raw request sockets with chunked request bodies. thanks Xiaofei Yang for the report.
    * bugfix: we did not check allocation failures while compiling the pattern for [tcpsock:receiveuntil()](https://github.com/openresty/lua-nginx-module#tcpsockreceiveuntil). thanks Tatsuhiko Kubo for the patch.
    * bugfix: we did not use `lua_checkstack()` to prevent Lua stack overflow in our own C-land Lua backtrace generator.
    * bugfix: fixed an incorrect error message. thanks aviramc for the patch.
    * bugfix: for statically linked [LuaJIT](luajit.html), we need to pass `-ldl` to the linker. thanks cf2012 for the report.
    * bugfix: the [tcp_nodelay](http://nginx.org/en/docs/http/ngx_http_core_module.html#tcp_nodelay) directive configuration was not honored by upstream TCP cosockets, which could lead to extra delays for small messages. thanks Shun Zhang for reporting this issue.
    * bugfix: fixed build failures with OpenSSL older than 0.9.8f. thanks FFCZ for the report.
    * bugfix: compilation failed with nginx 1.3.6 or older. this regression had appeared in the v0.9.11 release.
    * bugfix: compilation failed with nginx 0.9.x.
    * bugfix: our `create_loc_conf` callback did not return NULL on error.
    * bugfix: added allocation failure check for `ngx_array_init()` on the C land. thanks Tatsuhiko Kubo for the patch.
    * optimize: we now cache the userdata metatable (for the `__gc` metamethod) in the lua registry for both the stream-typed datagram-typed cosockets.
    * optimize: reading [ngx.header.HEADER](https://github.com/openresty/lua-nginx-module#ngxheaderheader): eliminated dynamic allocations and data copying when there is no need to ransform "_" to "-" in the header name.
    * change: [ngx.escape_uri()](https://github.com/openresty/lua-nginx-module#ngxescape_uri) now uses uppercase hexadecimal digits for percent-encoding according to the recommendation in RFC 3986. thanks Piotr Sikora for the suggestion.
    * change: use the type `ngx_http_lua_ffi_str_t` instead of `ngx_str_t` in the pure C API function `ngx_http_lua_ffi_req_get_headers`.
    * change: renamed the C macro `NGX_HTTP_LUA_NO_FFI_API` to `NGX_LUA_NO_FFI_API`.
    * style: various coding style fixes and minor optimizations from Tatsuhiko Kubo.
    * doc: documented the behavior of [init_by_lua*](https://github.com/openresty/lua-nginx-module#init_by_lua) when [lua_code_cache](https://github.com/openresty/lua-nginx-module#lua_code_cache) is off.
    * doc: fixed a wrong statement regarding `require()` in the "Lua Variable Scope" section. thanks Hungpu DU for the report.
    * doc: more clarification in the docs for the "res.truncated" flag returned by [ngx.location.capture()](https://github.com/openresty/lua-nginx-module#ngxlocationcapture). thanks Jon Keys for asking.
    * doc: added missing method name "get_keys" under "ngx.shared.DICT" and also fixed the method order. thanks George Bashi for the patch.
    * doc: markdown: fixed the "Back to TOC" links for the sections ("Nginx API for Lua" and "Directives") with inlined TOC. thanks Pierre-Yves Gérardy and Simon Eskildsen for the reports.
    * doc: improved the wording in the "Lua Coroutine Yielding/Resuming" section. thanks Hungpu DU for the report.
    * doc: improved the wording of the documentation for [ngx.req.clear_header()](https://github.com/openresty/lua-nginx-module#ngxreqclear_header) to prevent ambiguity. thanks Christophe-Marie Duquesne for the report.
* upgraded [Lua Resty Core Library](lua-resty-core-library.html) to 0.0.9.
    * feature: implemented the reading part of [ngx.header.HEADER](https://github.com/openresty/lua-nginx-module#ngxheaderheader) with FFI.
    * feature: implemented [ngx.worker.pid()](https://github.com/openresty/lua-nginx-module#ngxworkerpid) and [ngx.worker.exiting()](https://github.com/openresty/lua-nginx-module#ngxworkerexiting) with FFI.
* upgraded [Lua Resty Upstream Healthcheck Library](lua-resty-upstream-healthcheck-library.html) to 0.03.
    * optimize: timers in different nginx worker processes can go out of phase as time goes, resulting in duplicate test requests from different workers in the same check interval. thanks fancyrabbit for the report and fix.
* upgraded [Lua Resty Web Socket Library](lua-resty-web-socket-library.html) to 0.04.
    * feature: [resty.websocket.client](https://github.com/openresty/lua-resty-websocket#restywebsocketclient): added support for the "origin" option to specify the value of the `Origin` request header. thanks woo for the original patch.
    * bugfix: [resty.websocket.client](https://github.com/openresty/lua-resty-websocket#restywebsocketclient): connection pooling was broken due to duplicate websocket handshakes. thanks woo for the patch.
    * bugfix: fixed the `Sec-WebSocket-Protocol` header when the secondary protocols are specified. thanks woo for the report.
    * doc: typo fixes from Laurent Arnoud.
* upgraded [Lua Resty DNS Library](lua-resty-dns-library.html) to 0.13.
    * bugfix: we did not parse the character-strings in the "TXT" record data. thanks Kevin Ingersoll for the report.
* upgraded [Lua Resty MySQL Library](lua-resty-mysql-library.html) to 0.15.
    * feature: added new boolean-value options "ssl" and "ssl_verify" to the [connect()](https://github.com/openresty/lua-resty-mysql#connect) method connecting to MySQL via SSL.
* upgraded [Lua Cjson Library](lua-cjson-library.html) to 2.1.0.2.
    * bugfix: the Makefile had a bug that overwrites the existing `cjson.so` file in place which could cause already running processes with this `.so` file loaded to crash. thanks ywsample for the report.
See [ChangeLog 1.7.2](changelog-1007002.html) for change log for [OpenResty](openresty.html) 1.7.2.x.
