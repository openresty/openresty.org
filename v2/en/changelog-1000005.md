<!---
    @title         ChangeLog 1.0.5
    @creator       Yichun Zhang
    @created       2011-08-09 07:17 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-09-04 03:54 GMT
    @changes       38
--->


#  Stable Release 1.0.5.1 - 4 September 2011
This release is almost the same as 1.0.5.1rc14, but upgraded [Lua Nginx Module](lua-nginx-module.html) to
v0.3.0.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1rc4
* echo-nginx-module-0.37rc2
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.15
* iconv-nginx-module-0.10rc4
* lua-5.1.4
* lua-cjson-1.0.2
* lua-rds-parser-0.03
* lua-redis-parser-0.09rc5
* memc-nginx-module-0.12
* nginx-1.0.5
* ngx_devel_kit-0.2.17
* ngx_lua-0.3.0
* ngx_postgres-0.9rc1
* rds-csv-nginx-module-0.02
* rds-json-nginx-module-0.12rc2
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc2
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.5.1rc14 - 2 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc22.
    * fixed an issue with `header_filter_by_lua` directive: it was not supported in scopes other than the location scope.

#  Mainline Version 1.0.5.1rc13 - 1 September 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to 0.2.1rc21.
    * added the `header_filter_by_lua` and `header_filter_by_lua_file` directives: http://wiki.nginx.org/HttpLuaModule#header_filter_by_lua
    * fixed issues with HTTP 1.0 HEAD requests.
* upgraded [Echo Nginx Module](echo-nginx-module.html) to 0.37rc2
    * fixed issues when errors happen in a downstream output filter.
    * fixed issues with HTTP HEAD requests.

#  Mainline Version 1.0.5.1rc12 - 31 August 2011
* now we bundle [Lua Rds Parser Library](lua-rds-parser-library.html) and enable
it by default.
* added the `--without-lua_rds_parser` option to disable the [Lua Rds Parser Library](lua-rds-parser-library.html) bundled.
* now we bundle [Rds Csv Nginx Module](rds-csv-nginx-module.html) and enable
it by default.
* added the `--without-http_rds_csv_module` option to disable [Rds Csv Nginx Module](rds-csv-nginx-module.html).

#  Mainline Version 1.0.5.1rc11 - 30 August 2011
* upgraded [Rds Json Nginx Module](rds-json-nginx-module.html) to v0.12rc2
    * fixed a bug in compact JSON mode: the column name in the resultset might not be escaped for JSON encoding.

#  Mainline Version 1.0.5.1rc10 - 29 August 2011
* upgraded [Lua Redis Parser Library](lua-redis-parser-library.html) to 0.09rc5.
    * added wiki documentation page for this Lua library: http://wiki.nginx.org/LuaRedisParser
    * added the `typename` method for converting the numeric type values returned by `parse_reply` and `parse_replies` to textual type names: http://wiki.nginx.org/LuaRedisParser#typename

#  Mainline Version 1.0.5.1rc9 - 27 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc19.
    * implemented the `o` regex option (i.e., the compile-once flag as Perl's `/o` modifier) for all the `ngx.re.*` API.
    * added new directive `lua_regex_cache_max_entries` to control the upper limit of the worker-process-level compiled-regex cache enabled by the `o` regex option: http://wiki.nginx.org/HttpLuaModule#lua_regex_cache_max_entries
    * now we add `ngx` and `ndk` table into `package.loaded` such that the user can write `local ngx = require 'ngx'` and `local ndk = require 'ndk'`. thanks @Lance.

#  Mainline Version 1.0.5.1rc8 - 26 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc18.
    * fixed a bug in the `ngx.re.*` regex API that look-behind assertions in PCRE regexes did not work properly.

#  Mainline Version 1.0.5.1rc7 - 26 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc17.
    * now we enable `ngx.re.*` regex API in `set_by_lua*` too.

#  Mainline Version 1.0.5.1rc6 - 25 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc16.
    * fixed github issue #52: compile error with nginx 1.0.5 on Ubuntu natty.
    * fixed issues found by gcc 4.6 `-Wunused-but-set-variable` warnings.

#  Mainline Version 1.0.5.1rc5 - 24 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc15.
    * implemented the `ngx.re.gsub()` regex API for Lua: http://wiki.nginx.org/NginxHttpLuaModule#ngx.re.gsub

#  Mainline Version 1.0.5.1rc4 - 24 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc14.
    * added support for the optional `ctx` argument to `ngx.re.match`.

#  Mainline Version 1.0.5.1rc3 - 24 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc13.
    * implemented the `ngx.re.sub()` regex API for Lua: http://wiki.nginx.org/NginxHttpLuaModule#ngx.re.sub
    * added support for anchored match modifier `a` to `ngx.re.match`, `ngx.re.gmatch`, and `ngx.re.sub`.
* upgraded [Drizzle Nginx Module](drizzle-nginx-module.html) to v0.1.1rc4
    * added new wiki documentation page: http://wiki.nginx.org/NginxHttpDrizzleModule
    * documented the `$drizzle_thread_id` variable.
    * added lots of debug outputs (enabled by the `--with-debug` option while building [Nginx](nginx.html) or [OpenResty](openresty.html)), inspired by github issue #10.

#  Mainline Version 1.0.5.1rc2 - 18 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc12.
    * implemented the `ngx.re.gmatch()` regex API for Lua: http://wiki.nginx.org/NginxHttpLuaModule#ngx.re.gmatch

#  Mainline Version 1.0.5.1rc1 - 17 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc11.
    * now `ngx.ctx = {...} ` assignment is supported.
    * made setting `ngx.header.HEADER` after sending out response headers throw out a Lua exception to help debugging issues like github issue #49. thanks Bill Donahue (ikhoyo).
    * implemented the `ngx.re.match()` regex API for Lua: http://wiki.nginx.org/NginxHttpLuaModule#ngx.re.match

#  Stable Release 1.0.5.0 - 16 August 2011
This release is the same as 1.0.5.0rc7.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1rc3
* echo-nginx-module-0.37rc1
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.15
* iconv-nginx-module-0.10rc4
* lua-5.1.4
* lua-cjson-1.0.2
* lua-redis-parser-0.09rc4
* memc-nginx-module-0.12
* nginx-1.0.5
* ngx_devel_kit-0.2.17
* ngx_lua-0.2.1rc9
* ngx_postgres-0.9rc1
* rds-json-nginx-module-0.12rc1
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc2
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.5.0rc7 - 13 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc9.
    * implemented the special `ngx.ctx` Lua table for user programmers to store per-request Lua context data for their applications. thanks 欧远宁 for suggesting this feature.

#  Mainline Version 1.0.5.0rc6 - 12 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc8.
    * now `ngx.print` and `ngx.say` allow (nested) array-like table arguments. the array elements in them will be sent piece by piece. this will avoid string concatenation for templating engines like [ltp](http://www.savarese.com/software/ltp/).

#  Mainline Version 1.0.5.0rc5 - 12 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc7.
    * implemented the `ngx.req.get_post_args()` method for fetching urlencoded POST query arguments from within Lua.
    * renamed `ngx.req.get_query_args` to `ngx.req.get_uri_args`. the former is now deprecated.
    * fixed a bug in `ngx.req.get_uri_args`: it could not be used more than once in a single request.

#  Mainline Version 1.0.5.0rc4 - 12 August 2011
* upgraded [Lua Nginx Module](lua-nginx-module.html) to v0.2.1rc5.
    * implemented the `ngx.req.get_query_args()` method to fetch parsed URL query arguments from within Lua. thanks Bertrand Mansion (golgote).
    * now we allow Lua boolean and `nil` values in arguments to `ngx.say()`, `ngx.print()`, `ngx.log()` and `print()`.

#  Mainline Version 1.0.5.0rc3 - 11 August 2011
* now we bundle the [Lua Redis Parser Library](lua-redis-parser-library.html) with
us and it is enabled by default. tested on Linux i386, Linux x86_64, Mac OS
X, FreeBSD 8.2 i386, and Solaris 11.
* added the new option `--without-lua_redis_parser` to the `./configure` script.

#  Mainline Version 1.0.5.0rc2 - 10 August 2011
* now we bundle the [Lua Cjson Library](lua-cjson-library.html) with us and
it is enabled by default. tested on Linux i386, Linux x86_64, Mac OS X, FreeBSD 8.2
i386, and Solaris 11.
* added the new option `--without-lua_cjson` to the `./configure` script.
* added `<prefix>/lualib` to the default `path` and `cpath` settings of the
ngx_lua's Lua VM.

#  Mainline Version 1.0.5.0rc1 - 9 August 2011
* based on ngx_openresty 1.0.4.2, but with nginx core upgraded to nginx 1.0.5.

See [ChangeLog1000004](changelog-1000004.html) for change log for ngx_openresty 1.0.4.x.
