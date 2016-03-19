<!---
    @title         ChangeLog 1.4.1
    @creator       Yichun Zhang
    @created       2013-07-18 20:07 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-08-07 00:13 GMT
    @changes       50
--->


#  Mainline Version 1.4.1.3 - 6 August 2013
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.6.
    * feature: added new method [get_stale](http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT.get_stale) to shared dict objects, which returns the value (if not freed yet) even if the key has already expired. thanks Matthieu Tourne for the patch.
    * bugfix: segfaults would happen in [ngx.req.set_header()](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_header) and [ngx.req.clear_header()](http://wiki.nginx.org/HttpLuaModule#ngx.req.clear_header) for HTTP 0.9 requests. thanks Bin Wang for the report.
    * bugfix: segfault might happen when reading or writing to a response header via the [ngx.header.HEADER](http://wiki.nginx.org/HttpLuaModule#ngx.header.HEADER) API in the case that the nginx core initiated a 301 (auto) redirect. this issue was caused by an optimization in the [Nginx](nginx.html) core where `ngx_http_core_find_config_phase`, for example, does not fully initialize the "Location" response header after creating the header. thanks Vladimir Protasov for the report.
    * bugfix: memory leak would happen when using the [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) API before another [Nginx](nginx.html) module (other than [Lua Nginx Module](lua-nginx-module.html)) initiates an internal redirect.
    * bugfix: use of the [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) table in the context of [ngx.timer](http://wiki.nginx.org/HttpLuaModule#ngx.timer.at) callbacks would leak memory.
    * bugfix: the "connect() failed" error message was still logged even when [lua_socket_log_errors](http://wiki.nginx.org/HttpLuaModule#lua_socket_log_errors) was off. thanks Dong Fang Fan for the report.
    * bugfix: we incorrectly returned the 500 error code in our output header filter, body filter, and log-phase handlers upon Lua code loading errors.
    * bugfix: Lua stack overflow might happen when we failed to load Lua code from the code cache.
    * bugfix: the error message was misleading when the `*_by_lua_file` config directives failed to load the Lua file specified.
    * bugfix: give the argument of 'void' to function definitions which has no arguments. thanks Tatsuhiko Kubo for the patch.
    * bugfix: when our `at-panic` handler for Lua VM gets called, the Lua VM is not recoverable for future use. so now we try to quit the current [Nginx](nginx.html) worker gracefully so that the [Nginx](nginx.html) master can spawn a new one.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.22.
    * bugfix: segfaults would happen in [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) and [more_clear_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_input_headers) when processing HTTP 0.9 requests. thanks Bin Wang for the patch.
    * bugfix: segfault might happen when using [more_set_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_headers) or [more_clear_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_clear_headers) in the case that the [Nginx](nginx.html) core initiated a 301 (auto) redirect. this issue was caused by an optimization in the [Nginx](nginx.html) core where `ngx_http_core_find_config_phase`, for example, does not fully initialize the "Location" response header after creating the header. thanks Brian Akins for the report.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.22.
    * bugfix: we did not always read the client request body before initiating [srcache_fetch](http://wiki.nginx.org/HttpSRCacheModule#srcache_fetch) subrequests at the "access phase", which could lead to bad consequences.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.46.
    * bugfix: the request body was not discarded properly in the content handler when the request body was not read yet. thanks Peter Sabaini for the report.
    * bugfix: we did not ensure that the main request body is always read before subrequests are initiated, which could lead to bad consequences.
    * bugfix: [$echo_client_request_headers](http://wiki.nginx.org/HttpEchoModule#.24echo_client_request_headers) may evaluate to an empty value when the default header buffer (`c->buffer`) can hold the request line but not the whole header. thanks KDr2 for reporting this issue.
    * docs: fixed a typo in Synopsis reported by saighost.
    * docs: use https for github links. thanks Olivier Mengué for the patch.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc3.
    * bugfix: compilation error happened with nginx 1.5.3+ because the [Nginx](nginx.html) core changes the `ngx_sock_ntop` API. thanks an0ma1ia for the report.

#  Mainline Version 1.4.1.1 - 18 July 2013
* upgraded the [Nginx](nginx.html) core to 1.4.1.
    * see http://nginx.org/en/CHANGES-1.4 for changes.
* bugfix: ./configure: use of spaces in the `--with-cc` option values resulted
in errors.
* bugfix: applied the [unix_socket_accept_over_read patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.1-unix_socket_accept_over_read.patch) to
fix a buffer over-read issue in  the [Nginx](nginx.html) core when [Nginx](nginx.html) is
configured to listen on a unix domain socket.
* bugfix: applied the [gcc-maybe-uninitialized-warning patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.4.1-gcc-maybe-uninitialized-warning.patch) to
the [Nginx](nginx.html) core to fix a gcc warning with gcc 4.7.3/4.7.2.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.8.5.
    * change: made [ngx.say](http://wiki.nginx.org/HttpLuaModule#ngx.say)/[ngx.print](http://wiki.nginx.org/HttpLuaModule#ngx.print)/[ngx.eof](http://wiki.nginx.org/HttpLuaModule#ngx.eof)/[ngx.flush](http://wiki.nginx.org/HttpLuaModule#ngx.flush)/[ngx.send_headers](http://wiki.nginx.org/HttpLuaModule#ngx.send_headers) return `nil` and a string describing the error in case of most of the common errors (instead of throwing out an exception), and return 1 for success.
    * feature: added new directive [lua_regex_match_limit](http://wiki.nginx.org/HttpLuaModule#lua_regex_match_limit) for setting PCRE's "match_limit" protection for regex execution.
    * feature: now we store the nginx request object as a named Lua global variable `__ngx_req` to help FFI-based Lua code directly access it.
    * bugfix: the [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx) tables would leak memory when [ngx.ctx](http://wiki.nginx.org/HttpLuaModule#ngx.ctx), [ngx.exec()](http://wiki.nginx.org/HttpLuaModule#ngx.exec)/[ngx.req.set_uri](http://wiki.nginx.org/HttpLuaModule#ngx.req.set_uri)(uri, true), and [log_by_lua](http://wiki.nginx.org/HttpLuaModule#log_by_lua) were used together in a single location. thanks Guanlan Dai for writing the gdb utils to catch this.
    * bugfix: setting [ngx.var.VARIABLE](http://wiki.nginx.org/HttpLuaModule#ngx.var.VARIABLE) could lead to buffer over-read in `luaL_error` when an error happened.
    * bugfix: [tcpsock:send](http://wiki.nginx.org/HttpLuaModule#tcpsock:send)("") resulted in the error log alert message "send() returned zero".
    * bugfix: [ngx.flush](http://wiki.nginx.org/HttpLuaModule#ngx.flush)(true) might not return 1 on success.
    * bugfix: when compiling with `-DDDEBUG=1`, there was a compilation error. thanks tigeryang for the report.
    * optimize: avoided use of the nginx request objects in [ngx.escape_uri](http://wiki.nginx.org/HttpLuaModule#ngx.escape_uri), [ngx.unescape_uri](http://wiki.nginx.org/HttpLuaModule#ngx.unescape_uri), [ngx.quote_sql_str](http://wiki.nginx.org/HttpLuaModule#ngx.quote_sql_str), [ngx.decode_base64](http://wiki.nginx.org/HttpLuaModule#ngx.decode_base64), [ngx.encode_base64](http://wiki.nginx.org/HttpLuaModule#ngx.encode_base64), [ngx.encode_args](http://wiki.nginx.org/HttpLuaModule#ngx.encode_args), and [ngx.decode_args](http://wiki.nginx.org/HttpLuaModule#ngx.decode_args).
    * optimize: no longer store `cf->log` into the Lua registry table because we can always directly access the global `ngx_cycle->log` thing.
    * refactor: added inline functions `ngx_http_lua_get_req` and `ngx_http_lua_set_req` to eliminate code duplication when storing or fetching the nginx request object from the lua global variable table.
    * docs: typo fixes in the code sample for [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua). thanks cyberty for the patch.
    * docs: mentioned my [Nginx Systemtap Toolkit](https://github.com/agentzh/nginx-systemtap-toolkit) which is very useful for online debugging on Linux.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.21.
    * bugfix: segmentation fault might happen in [Nginx](nginx.html) 1.4.x when using the [more_set_input_headers](http://wiki.nginx.org/HttpHeadersMoreModule#more_set_input_headers) directive on the Cookie request headers because recent versions of [Nginx](nginx.html) no longer always initialize `r->headers_in.cookies`.
See [ChangeLog 1.2.8](changelog-1002008.html) for change log for [OpenResty](openresty.html) 1.2.8.x.
