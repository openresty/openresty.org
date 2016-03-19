<!---
    @title         ChangeLog 1.0.6
    @creator       Yichun Zhang
    @created       2011-09-04 08:16 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-10-07 04:57 GMT
    @changes       24
--->


#  Stable Release 1.0.6.22 - 7 October 2011
This release is exactly the same as the devel release 1.0.6.21.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1
* echo-nginx-module-0.37rc4
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.16rc2
* iconv-nginx-module-0.10rc4
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.03
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.12
* nginx-1.0.6
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.1rc8
* ngx_postgres-0.9rc1
* rds-csv-nginx-module-0.03
* rds-json-nginx-module-0.12rc5
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc2
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.6.21 - 23 September 2011
* added new option `-jN` (e.g., `-j8`, `-j10`, and etc.) to [OpenResty](openresty.html)'s
`./configure` script to allow parallel build of the dependencies like [LuaJIT](luajit.html);
thanks @Lance.

#  Mainline Version 1.0.6.19 - 23 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc8.
    * exposes the `CRC-32` API of the [Nginx](nginx.html) core to the Lua land, in the form of the `ngx.crc32_short` and `ngx.crc32_long` methods. thanks @Lance.

#  Mainline Version 1.0.6.17 - 23 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc7.
    * now `ngx.exec()` supports lua table as the second `args` argument value. thanks sexybabes.
    * implemented the `ngx.headers_sent` API to check if response headers are sent (by ngx_lua). thanks @hugozhu.

#  Mainline Version 1.0.6.15 - 22 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc5.
    * now we also return the `Last-Modified` header (if any) for the subrequest response object. thanks @cyberty and sexybabes.

#  Mainline Version 1.0.6.13 - 21 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.3.1rc4.
    * fixed an issue in `ngx.redirect`, `ngx.exit`, and `ngx.exec`: these function calls would be intercepted by Lua `pcall`/`xpcall` because they used lua exceptions; now they use lua yield just as `ngx.location.capture`. thanks @hugozhu for reporting this.

#  Stable Release 1.0.6.12 - 21 September 2011
This release is exactly the same as the devel release 1.0.6.11.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1
* echo-nginx-module-0.37rc4
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.16rc2
* iconv-nginx-module-0.10rc4
* lua-5.1.4
* lua-cjson-1.0.3
* lua-rds-parser-0.03
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.12
* nginx-1.0.6
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.1rc3
* ngx_postgres-0.9rc1
* rds-csv-nginx-module-0.03
* rds-json-nginx-module-0.12rc5
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc2
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.6.11 - 20 September 2011
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to v0.12rc4.
    * made `rds_json_ret` honor `rds_json_success_property` and `rds_json_user_property`. thanks Liseen Wan (万珣新)
    * only register our output filters when the `rds_json` directive is actually used in `nginx.conf`.
* upgraded [Rds Csv Nginx Module](rds-csv-nginx-module.html) to v0.03.
    * only register our output filters when the `rds_csv` directive is actually used in `nginx.conf`.

#  Mainline Version 1.0.6.9 - 19 September 2011
* upgraded [Lua Cjson Library](lua-cjson-library.html) to v1.0.3.

#  Mainline Version 1.0.6.7 - 18 September 2011
* added new options `--with-luajit=PATH` and `--with-lua51=PATH` to the `./configure` script.
thanks NginxUser.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to v0.1.1.

#  Mainline Version 1.0.6.5 - 15 September 2011
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to 0.12rc3.
    * implemented new directive `rds_json_root`.
    * implemented new directive `rds_json_success_property`.
    * implemented new directive `rds_json_user_property`.

#  Mainline Version 1.0.6.3 - 14 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc3.
    * implemented and documented the API for reading response headers from within Lua: `value = ngx.header.HEADER`.
    * fixed a bug when setting a multi-value response header to a single value (via writing to `ngx.header.HEADER`): the single value will be repeated on each old value.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc4.
    * fixed a bug in `echo_after_body`: when network is not perfect, data truncation might occur. we should have taken into account `NGX_AGAIN` returned by the downstream output filters. thanks Sparsh Gupta.
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to v0.16rc2.
    * fixed a bug when setting a multi-value response header to a single value: the single value will be repeated on each old value.
* applied the patch from Maxim Dounin to fix a bug in the standard ngx_gzip
module when dealing with empty flush buffers: http://mailman.nginx.org/pipermail/nginx-devel/2011-February/000730.html
* updated the no-pool-patch to eliminate the `-Wset-but-not-used` warnings issued
by gcc 4.6.0.

#  Mainline Version 1.0.6.1 - 8 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.3.1rc1.
    * fixed a bug when the both the main request and the subrequest are POST requests with a body: we should not forward the main request's `Content-Length` headers to the user subrequests. thanks 朱峰.

#  Mainline Version 1.0.6.0rc2 - 4 September 2011
* upgraded [Headers More Nginx Module](headers-more-nginx-module.html) to 0.16rc1.
    * fixed on-demand hander/filter registration trick for `HUP` signal restarts.
    * added some debugging outputs that can be enabled by the `--with-debug` option when building [Nginx](nginx.html) or [OpenResty](openresty.html).

#  Mainline Version 1.0.6.0rc1 - 4 September 2011
* based on ngx_openresty 1.0.5.1, but with nginx core upgraded to nginx 1.0.6.

See [ChangeLog1000005](changelog-1000005.html) for change log for ngx_openresty 1.0.5.x.
