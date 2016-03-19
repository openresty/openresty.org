<!---
    @title         ChangeLog 8054
    @creator       Yichun Zhang
    @created       2011-06-21 04:31 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-07-08 11:23 GMT
    @changes       25
--->


#  Stable Release 0.8.54.9 - 8 July 2011
This release is the same as  0.8.54.9rc6.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.02
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.1.0
* echo-nginx-module-0.36
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc4
* headers-more-nginx-module-0.15
* iconv-nginx-module-0.10rc3
* lua-5.1.4
* memc-nginx-module-0.12
* nginx-0.8.54
* ngx_devel_kit-0.2.17
* ngx_lua-0.2.0
* ngx_postgres-0.8
* rds-json-nginx-module-0.11
* redis2-nginx-module-0.07rc5
* set-misc-nginx-module-0.21
* srcache-nginx-module-0.12rc6
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 0.8.54.9rc6 - 8 July 2011
* upgraded ngx_echo to v0.36 and ngx_memc to v0.12.

#  Mainline Version 0.8.54.9rc5 - 7 July 2011
* applied the subrequest loop fix patch from Maxim Dounin.

#  Mainline Version 0.8.54.9rc4 - 6 July 2011
* upgraded ngx_rds_json to v0.11, ngx_headers_more to v0.15, and ngx_drizzle
to v0.1.0.

#  Mainline Version 0.8.54.9rc3 - 5 July 2011
* upgraded ngx_drizzle to 0.0.15rc14 and ngx_lua to 0.2.0.

#  Mainline Version 0.8.54.9rc2 - 4 July 2011
* upgraded ngx_lua to 0.1.6rc18.

#  Mainline Version 0.8.54.9rc1 - 3 July 2011
* upgraded ngx_redis2 to 0.07rc5.

#  Stable Release 0.8.54.8 - 1 July 2011
This release is the same as  0.8.54.8rc2.

The following components are bundled by this release:
* LuaJIT-2.0.0-beta8
* array-var-nginx-module-0.02
* auth-request-nginx-module-0.2
* drizzle-nginx-module-0.0.15rc13
* echo-nginx-module-0.36rc6
* encrypted-session-nginx-module-0.01
* form-input-nginx-module-0.07rc4
* headers-more-nginx-module-0.15rc3
* iconv-nginx-module-0.10rc3
* lua-5.1.4
* memc-nginx-module-0.12rc2
* nginx-0.8.54
* ngx_devel_kit-0.2.17
* ngx_lua-0.1.6rc17
* ngx_postgres-0.8
* rds-json-nginx-module-0.11rc2
* redis2-nginx-module-0.07rc4
* set-misc-nginx-module-0.21
* srcache-nginx-module-0.12rc6
* upstream-keepalive-nginx-module-0.3
* xss-nginx-module-0.03rc3

#  Mainline Version 0.8.54.8rc2 - 1 July 2011
* upgraded ngx_echo to 0.36rc6, ngx_lua to 0.1.6rc17, ngx_srcache to 0.12rc6, and ngx_redis2
to 0.07rc4.

#  Mainline Version 0.8.54.8rc1 - 28 June 2011
* we no longer bundle libdrizzle because [libdrizzle 1.0](https://launchpad.net/libdrizzle) is
distributed with the drizzle server and hard to separate.
* now ngx_drizzle is disabled by default. you need to enable it via the `--with-http_drizzle_module` option.
* added `--with-libdrizzle` option to specify the (lib)drizzle installation
prefix.

#  Stable Release 0.8.54.7 - 27 June 2011
* identical to 0.8.54.7rc5.

#  Mainline Version 0.8.54.7rc5 - 27 June 2011
* we should preserve timestamps when copying bundle/ to build/ in ./configure
script. this should fix luajit build on some systems.

#  Mainline Version 0.8.54.7rc4 - 27 June 2011
upgraded ngx_xss to 0.03rc3, ngx_drizzle to 0.0.15rc11, ngx_memc to 0.12rc2, ngx_srcache
to 0.12rc5, ngx_redis2 to 0.07rc3.

#  Mainline Version 0.8.54.7rc3 - 27 June 2011
* upgraded [LuaJIT](luajit.html) to 2.0.0beta8, ngx_lua to 0.1.6rc15, and ngx_echo
to 0.36rc4.

#  Mainline Version 0.8.54.7rc2
* Upgraded [LuaNginxModule](lua-nginx-module.html) to v0.1.6rc14 and [HeadersMoreNginxModule](headers-more-nginx-module.html) to
v0.15rc3.

#  Mainline Version 0.8.54.7rc1
* Upgraded [HeadersMoreNginxModule](headers-more-nginx-module.html) to v0.15rc2
and [LuaNginxModule](lua-nginx-module.html) to v0.1.6rc13.

#  Release 0.8.54.6
* Upgraded [DrizzleNginxModule](drizzle-nginx-module.html) to 0.0.15rc10.
* Upgraded [LuaNginxModule](lua-nginx-module.html) to 0.1.6rc12.
* Upgraded [Redis2NginxModule](redis-2-nginx-module.html) to 0.07rc2.

#  Release 0.8.54.5
* Upgraded [EchoNginxModule](echo-nginx-module.html) to 0.36rc3.
* Upgraded [LuaNginxModule](lua-nginx-module.html) to 0.1.6rc9.
