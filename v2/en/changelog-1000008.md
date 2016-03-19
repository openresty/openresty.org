<!---
    @title         ChangeLog 1.0.8
    @creator       Yichun Zhang
    @created       2011-10-10 08:46 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-11-03 09:08 GMT
    @changes       46
--->


#  Stable Release 1.0.8.26 - 3 November 2011
* now we require `gmake` (`Gnu make`) for `*BSD` systems even if [LuaJIT](luajit.html) is
not enabled. thanks [@lhmwzy](http://weibo.com/lhmwzy).
* upgraded the official [hotfix patch #4](http://www.lua.org/ftp/patch-lua-5.1.4-4) for
the standard Lua 5.1.4 interpreter.

[Components](components.html) bundled in this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.2rc2
* echo-nginx-module-0.37rc7
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.16rc3
* iconv-nginx-module-0.10rc5
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.03
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.13rc1
* nginx-1.0.8
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.1rc23
* ngx_postgres-0.9rc1
* rds-csv-nginx-module-0.04
* rds-json-nginx-module-0.12rc6
* redis2-nginx-module-0.08rc1
* set-misc-nginx-module-0.22rc3
* srcache-nginx-module-0.13rc2
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.8.25 - 27 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc23.
    * bugfix: `ndk.set_var.DIRECTIVE` had a memory issue and might pass empty argument values to the directive being called. thanks dannynoonan.

#  Mainline Version 1.0.8.23 - 27 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc22.
    * feature: implemented new methods `add`, `replace`, `incr`, and `delete` for `ngx.shared.DICT`.
    * bugfix: made the `set` method of `ngx.shared.DICT` return 3 values: `success`, `err`, and `forcible`.
    * bugfix: fixed spots of `-Werror=unused-but-set-variable` warning issued by gcc 4.6.0.

#  Mainline Version 1.0.8.21 - 26 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc21.
    * feature: added new directive `lua_shared_dict`: http://wiki.nginx.org/HttpLuaModule#lua_shared_dict
    * feature: added Lua API for the shm-based dictionary: http://wiki.nginx.org/HttpLuaModule#ngx.shared.DICT
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc7.
    * bugfix: fixed a memory issue in both `echo_sleep` and `echo_blocking_sleep`: we should not pass `ngx_str_t` strings to `atof()` which expects C strings.

#  Mainline Version 1.0.8.19 - 24 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc20.
    * bugfix: no longer free request body buffers that are not allocated by ourselves.
    * bugfix: now we allow setting `ngx.var.VARIABLE` to `nil`.

#  Mainline Version 1.0.8.17 - 22 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc19.
    * feature: now we apply the patch to the nginx core so as to allow main request body modifications: https://github.com/openresty/ngx_openresty/blob/master/patches/nginx-1.0.8-allow_request_body_updating.patch
    * feature: added new Lua API `ngx.req.set_body_file()`: http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_file
    * feature: added new Lua API `ngx.req.set_body_data()`: http://wiki.nginx.org/HttpLuaModule#ngx.req.set_body_data
    * bugfix: `lua_need_request_body` should not skip requests with methods other than `POST` and `PUT`. thanks [Nginx](nginx.html) User.

#  Mainline Version 1.0.8.15 - 19 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc17.
    * feature: added new Lua functions `ngx.req.read_body()`, `ngx.req.discard_body()`, `ngx.req.get_body_data()`, and `ngx.req.get_body_file()`. see the docs here: http://wiki.nginx.org/HttpLuaModule#ngx.req.read_body
    * bugfix: fixed hanging issues when using `ngx.exec()` within `rewrite_by_lua` and `access_by_lua`. thanks [Nginx](nginx.html) User for reporting it.

#  Mainline Version 1.0.8.13 - 16 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc16.
    * fixed compilation failures when `--with-debug` is turned off.
    * now we prohibit use of `true` jump argument in `ngx.req.set_uri()` in contexts other than `rewrite_by_lua` and `rewrite_by_lua_file`. a lua exception will be thrown if the context is incorrect.

#  Mainline Version 1.0.8.11 - 16 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc14.
    * now we change the `ngx.req.set_uri()` API a bit by changing the optional argument `break_cycle` to `jump`. so now it will not trigger location jump by default (because the `jump` argument is false by default) and in case `jump` is given true, the function will re-search locations and jump to the new location and never return.

#  Mainline Version 1.0.8.9 - 16 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc13.
    * now we implemented `ngx.req.set_uri()` and `ngx.req.set_uri_args()` to emulate `ngx_rewrite`'s `rewrite` directive (without `redirect` or `permanent` modifiers). thanks Vladimir Protasov (utros) and [Nginx](nginx.html) User.
    * now we skip rewrite phase Lua handlers altogether if `ngx_rewrite`'s `rewrite` directive issue a location re-lookup by changing URIs (but not including rewrite ... break). thanks [Nginx](nginx.html) User.
    * added constant `ngx.HTTP_METHOD_NOT_IMPLEMENTED` (501). thanks [Nginx](nginx.html) User.

#  Mainline Version 1.0.8.7 - 15 October 2011
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc2.
    * bugfix: we now only cache 200, 301, and 302 responses by default.
    * feature: implemented new directive `srcache_store_statuses` to allow the user to specify the response status code list that is to be stored into the cache.

#  Mainline Version 1.0.8.5 - 13 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc11.
    * bugfix: now we explicitly clear all the modules' contexts before dump to named location with `ngx.exec`.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc6.
    * bugfix: now we explicitly clear all the modules' contexts before dump to named location with `echo_exec`.
    * bugfix: bugfix: `echo_exec` may hang when running after `echo_sleep` (or other I/O interruption calls): we should have called `ngx_http_finalize_request` on `NGX_DONE` to decrement `r->main->count` anyway.
* applied the patch to the [Nginx](nginx.html) core that always clears all modules'
contexts in `ngx_http_named_location`.

#  Mainline Version 1.0.8.3 - 13 October 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc10.
    * bugfix: calling `ngx.exec()` to jump to a named location did not clear the context object of [Lua Nginx Module](lua-nginx-module.html) properly and might cause evil problems. thanks [Nginx](nginx.html) User.
* upgraded [Iconv Nginx Module](iconv-nginx-module.html) to 0.10rc5.
    * bugfix: fixed `-Wset-but-not-used` warnings issued by gcc 4.6.0. thanks 支家乐 (Calio).

#  Mainline Version 1.0.8.1 - 10 October 2011
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc5.
    * bugfix: now we properly set the `Content-Length` request header for subrequests.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc9.
    * feature: now for HTTP 1.0 requests, we disable the automatic full buffering mode if the user sets the `Content-Length` response header before sending out the headers. this allows streaming output for HTTP 1.0 requests if the content length can be calculated beforehand. thanks 李子义.
    * bugfix: now we properly support setting the `Cache-Control` response header via the `ngx.header.HEADER` interface.
    * bugfix: no longer set header hash to 1. use the `ngx_hash_key_lc` instead.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.16rc3.
    * bugfix: we should set header hash using `ngx_hash_key_lc`, not simply to 1.
    * bugfix: fixed setting `Cache-Control` response headers. we should properly prepare the `r->cache_control` array as well.
* upgraded [Srcache Nginx Module](srcache-nginx-module.html) to 0.13rc1.
    * implemented response status line and general response header caching and added new directives `srcache_store_hide_header` and `srcache_store_pass_header` to control which headers to cache and which not.
    * added new directive `srcache_response_cache_control` to control whether honor response headers `Cache-Control` and `Expires`, default `on`.
    * we disable `srcache_store` automatically by default when `Cache-Control: max-age=0` and `Expires: <date no more recently than now>` are seen.
    * implemented builtin nginx variable `$srcache_expire` for automatic expiration time calculation based on response headers `Cache-Control` (`max-age`) and `Expires`; also added new directives `srcache_max_expire` and `srcache_default_expire`.
    * implemented the `srcache_store_no_cache` directive; now by default, we do not store responses with the header `Cache-Control: no-cache` into the cache.
    * implemented `the srcache_store_no_store directive` (default `off`). Now by default, responses with the header `Cache-Control: no-store` will not be stored into the cache.
    * implemented the `srcache_store_private` directive to control whether to store responses with the header `Cache-Control: private`.
    * implemented the `srcache_request_cache_control` directive to allow request headers `Cache-Control: no-cache` or `Pragma: no-cache` to force bypassing cache lookup. it also honors the request header `Cache-Control: no-store`. this directive is turned off by default.
    * now we check response header `Content-Encoding` by default and a non-empty header value will `skip srcache_store`; also introduced a new directive named `srcache_ignore_content_encoding` to ignore this response header.
    * implemented the `srcache_methods` directive to specify request methods that are cacheable, by default, only `GET` and `HEAD` are cacheable.
    * bugfix: we no longer set header hash to 1; we use `ngx_hash_key_lc` instead.
    * bugfix: when we skip `srcache_fetch` by means of `srcache_fetch_skip`, we should not automatically skip `srcache_store`.
    * bugfix: now we ignore the `Content-Length` header (if any) of the main request for the subrequests.
    * bugfix: there might be a segfault when failing to allocate memory in `ngx_http_srcache_add_copy_chain`. thanks Shaun savage.
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.12rc6.
    * bugfix: fixed compatibility with nginx 1.1.4+.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to 0.04.
    * bugfix: fixed compatibility issues with nginx 1.1.4+.
    * optimization: now we only register our filters when `rds_csv` is actually used in `nginx.conf`.
* upgraded [Redis2 Nginx Module](redis-2-nginx-module.html) to 0.08rc1.
    * bugfix: fixed compatibility with nginx 1.1.4+.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to 0.1.2rc2.
    * bugfix: fixed compatibility with nginx 1.1.4+
* upgraded [Memc Nginx Module](memc-nginx-module.html) to 0.13rc1.
    * bugfix: fixed compatibility with nginx 1.1.4+.
* upgraded [Set Misc Nginx Module](set-misc-nginx-module.html) to v0.22rc3.
    * minor code cleanup.
* applied the patch for the variable-header-ignore-no-hash issue. see http://forum.nginx.org/read.php?29,216062
for details.
* based on [OpenResty](openresty.html) 1.0.6.22 and upgraded the [Nginx](nginx.html) core
to 1.0.8.

See [ChangeLog1000006](changelog-1000006.html) for change log for ngx_openresty 1.0.6.x.
