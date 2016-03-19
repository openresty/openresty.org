<!---
    @title         ChangeLog 1.2.1
    @creator       Zoom Quiet
    @created       2012-06-25 06:49 GMT
    @modifier      Zoom Quiet
    @modifier_link 
    @modified      
    @changes       1
--->


#  Mainline Version 1.2.1.3 - 25 June 2012
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.40.
    * feature: added new directive [echo_status](http://wiki.nginx.org/HttpEchoModule#echo_status) which can be used to specify a different default response status code other than 200. thanks Maxime Corbeau for requesting this.
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.3.
    * bugfix: [ngx.say](http://wiki.nginx.org/HttpLuaModule#ngx.say) and [ngx.print](http://wiki.nginx.org/HttpLuaModule#ngx.print) might cause nginx to crash when table-typed arguments were given. thanks sztanpet for reporting this in [github issue #54](https://github.com/chaoslawful/lua-nginx-module/issues/54#issuecomment-6527745).
* applied [location_if_inherits_proxy.patch](https://github.com/agentzh/ngx_openresty/blob/master/patches/nginx-1.2.1-location_if_inherits_proxy.patch) to
the nginx core. see http://mailman.nginx.org/pipermail/nginx-devel/2012-June/002374.html
for details.

#  Mainline Version 1.2.1.1 - 22 June 2012
* upgraded the [Nginx](nginx.html) core to 1.2.1.
    * see the change log: http://nginx.org/en/CHANGES-1.2
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.5.2.
    * bugfix: [header_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua)* did not run at all when [body_filter_by_lua](http://wiki.nginx.org/HttpLuaModule#body_filter_by_lua)* was defined at the same time. thanks Tzury Bar Yochay for reporting this issue.
    * feature: added the `inclusive` option to the [cosocket:receiveuntil](http://wiki.nginx.org/HttpLuaModule#tcpsock:receiveuntil) method to include the delimiter pattern string in the resulting data read. thanks Matthieu Tourne for the patch.
    * optimize: merged two successive [Nginx](nginx.html) pool allocations in `ngx_http_lua_socket_resolve_handler` to reduce overhead.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.39.
    * bugfix: [Echo Nginx Module](echo-nginx-module.html)'s configure directives was not inherited automatically by `location if` inner blocks.
    * bugfix: the old HTTP 1.0 protocol handling was wrong. we should leave that to the [Nginx](nginx.html) core and just output responses without a `Content-Length` response header.
    * bugfix: reading the [$echo_it](http://wiki.nginx.org/HttpEchoModule#.24echo_it) variable outside the [echo_foreach_split](http://wiki.nginx.org/HttpEchoModule#echo_foreach_split) loop resulted in memory invalid reads and hence segfaults; now it is evaluates to the special `not found` value. thanks baqs for reporting this.
* upgraded [Postgres Nginx Module](postgres-nginx-module.html) to 1.0rc1.
    * bugfix: memory leak might happen if nginx 1.1.14+ was used and (at least) `libpq` failed to connect to the remote database.
* upgraded the (optional) no-pool patch to the latest version, `642ae25`.
    * bugfix: we should postpone freeing the `elts` storage for `ngx_array_t` to `ngx_array_destroy` when resizing the array because at least the `ngx_rewrite` module stores external references to the array elements.

See [ChangeLog 1.0.15](changelog-1000015.html) for change log for ngx_openresty 1.0.15.x.
