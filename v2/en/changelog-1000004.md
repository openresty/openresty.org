<!---
    @title         ChangeLog 1.0.4
    @creator       Yichun Zhang
    @created       2011-07-08 12:22 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-09-02 07:56 GMT
    @changes       47
--->


#  Stable Release 1.0.4.2 - 9 August 2011
This release is the same as  1.0.4.2rc13.

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
* memc-nginx-module-0.12
* nginx-1.0.4
* ngx_devel_kit-0.2.17
* ngx_lua-0.2.1rc4
* ngx_postgres-0.9rc1
* rds-json-nginx-module-0.12rc1
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc2
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.4.2rc13 - 8 August 2011
* now we bundle a Perl 5 script to serve as the `install` script for [LuaJIT](luajit.html) 2.0
on Solaris. now [OpenResty](openresty.html) builds successfully on Solaris 11
with [LuaJIT](luajit.html) enabled!

#  Mainline Version 1.0.4.2rc12 - 8 August 2011
* bundled `gcc`'s `unwind-generic.h` for BSD because `unwind.h` is missing at
least on FreeBSD.

#  Mainline Version 1.0.4.2rc11 - 8 August 2011
* use absoluate paths in Makefile to prevent `-jN` errors when using bsdmake
on FreeBSD.

#  Mainline Version 1.0.4.2rc10 - 7 August 2011
* upgraded ngx_lua to v0.2.1rc4.
    * worked-around the "stack overflow" issue while using luarocks.loader and disabling `lua_code_cache`, as described as [github issue #27](https://github.com/openresty/lua-nginx-module/issues/27). thanks Patrick Crosby.

#  Mainline Version 1.0.4.2rc9 - 7 August 2011
* now we use `gmake` if it is available in `PATH` during `./configure`; also
added the `--with-make=PATH` option to allow the user to specify a custom `make` utility.

#  Mainline Version 1.0.4.2rc8 - 6 August 2011
* fixed a regression that we should use the `CC` variable instead of `HOST_CC` while
passing the `--with-cc` option to the [LuaJIT](luajit.html) 2.0 build system.
thanks @姜大炮 for reporting this issue.

#  Mainline Version 1.0.4.2rc7 - 5 August 2011
*  upgraded ngx_lua to v0.2.1rc3.
    * fixed the `zero size buf in output` alert while combining `lua_need_request_body on` + `access_by_lua/rewrite_by_lua` + `proxy_pass/fastcgi_pass`. thanks 万珣新.

#  Mainline Version 1.0.4.2rc6 - 5 August 2011
* added the `--with-pg_config` option to the `./configure` script as per 罗翼's
request.

#  Mainline Version 1.0.4.2rc5 - 5 August 2011
* added the `--with-no-pool-patch` option to the `./configure` script, to allow
enabling the no-pool patch for debugging memory issues with valgrind, for example.

#  Mainline Version 1.0.4.2rc4 - 4 August 2011
* added the `--with-libpq=DIR` option to the `./configure` script. thanks 郭颖
for suggesting this.

#  Mainline Version 1.0.4.2rc3 - 4 August 2011
* upgraded ngx_drizzle to v0.1.1rc3.
    * fixed segmentation faults on Linux i386. thanks @魏世江 and @stefanli for reporting this issue.

#  Mainline Version 1.0.4.2rc2 - 4 August 2011
* fixed a regression while specifying `--with-http_iconv_module` during `./configure`.
thanks 冯新国 for reporting this issue.

#  Mainline Version 1.0.4.2rc1 - 30 July 2011
* upgraded ngx_set_misc to 0.22rc2.
    * added the set_misc_base32_padding directive.

#  Stable Release 1.0.4.1 - 30 July 2011
This release is the same as  1.0.4.1rc6.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.03rc1
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1rc2
* echo-nginx-module-0.37rc1
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc5
* headers-more-nginx-module-0.15
* iconv-nginx-module-0.10rc4
* lua-5.1.4
* memc-nginx-module-0.12
* nginx-1.0.4
* ngx_devel_kit-0.2.17
* ngx_lua-0.2.1rc2
* ngx_postgres-0.9rc1
* rds-json-nginx-module-0.12rc1
* redis2-nginx-module-0.07
* set-misc-nginx-module-0.22rc1
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.4.1rc6 - 28 July 2011
* fixed a regression in `./configure` when enabling luajit in 1.0.4.1rc5. thanks @Lance.

#  Mainline Version 1.0.4.1rc5 - 26 July 2011
* upgraded ngx_iconv to 0.10rc3, ngx_form_input to 0.07rc5, ngx_array_var to 0.03rc1, and ngx_set_misc
to 0.22rc1.
* now `--with-debug` option also enables the `gcc -g` compilation option for
[LuaJIT](luajit.html).
* disabled target stripping in [LuaJIT](luajit.html).

#  Mainline Version 1.0.4.1rc4 - 25 July 2011
* applied the official hotfix #1 patch for [LuaJIT](luajit.html) 2.0.0 beta8.

#  Mainline Version 1.0.4.1rc3 - 23 July 2011
* now the `--with-cc` option of `./configure` also controls the C compiler used
by Lua and [LuaJIT](luajit.html). thanks @姜大炮 for reporting the issue.

#  Mainline Version 1.0.4.1rc2 - 23 July 2011
* upgraded ngx_lua to v0.2.1rc2 and ngx_redis2 to v0.07.

#  Mainline Version 1.0.4.1rc1 - 14 July 2011
* upgraded ngx_rds_json to v0.12rc1, ngx_drizzle to v0.1.1rc2, ngx_lua to v0.2.1rc1,
ngx_postgres to v0.9rc1, ngx_redis2 to v0.07rc6.
* now we no longer enable `gcc -O2` by default, because it's bad for debugging
issues.
* fixed linking issues when doing `./configure --with-cc-opt=-fast` on Mac OS
X. thanks @姜大炮.

#  Stable Release 1.0.4.0 - 12 July 2011
This release is the same as  1.0.4.0rc5.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.02
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.1rc1
* echo-nginx-module-0.37rc1
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc4
* headers-more-nginx-module-0.15
* iconv-nginx-module-0.10rc3
* lua-5.1.4
* memc-nginx-module-0.12
* nginx-1.0.4
* ngx_devel_kit-0.2.17
* ngx_lua-0.2.0
* ngx_postgres-0.8
* rds-json-nginx-module-0.11
* redis2-nginx-module-0.07rc5
* set-misc-nginx-module-0.21
* srcache-nginx-module-0.12
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 1.0.4.0rc5 - 12 July 2011
* upgraded ngx_drizzle to v0.1.1rc1.

#  Mainline Version 1.0.4.0rc4 - 11 July 2011
* upgraded ngx_echo to v0.37rc1.
* we no longer require ExtUtils::MakeMaker and Config because they're not standard
packages and are missing on a default CentOS 6 build. thanks Lance for reporting
it.

#  Mainline Version 1.0.4.0rc2 - 11 July 2011
* upgraded ngx_srcache to v0.12.

#  Mainline Version 1.0.4.0rc1 - 8 July 2011
* based on ngx_openresty 0.8.54.9, but with nginx core upgraded to nginx 1.0.4.

See [ChangeLog8054](changelog-8054.html) for change log for ngx_openresty 0.8.54.x.
