<!---
    @title         Components
    @creator       Yichun Zhang
    @created       2011-06-21 04:24 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-11-23 13:15 GMT
    @changes       35
--->

Below lists all the components bundled in [OpenResty](openresty.html). All of
the components can be enabled or disabled on need.

Most of the components are enabled by default, some are not.

The standard Lua 5.1 interpreter, [DrizzleNginxModule](drizzle-nginx-module.html),
[PostgresNginxModule](postgres-nginx-module.html), and [IconvNginxModule](iconv-nginx-module.html) are
not enabled by default. You need to specify the `--with-lua51`, `--with-http_drizzle_module`,
`--with-http_postgres_module`, and `--with-http_iconv_module` options, respectively,
to enable them while [building OpenResty](installation.html).

Before the 1.5.8.1 release, the standard Lua 5.1 interpreter is enabled by default
while [LuaJIT](luajit.html) 2.x is not. So for earlier releases, you need to
explicitly specify the `--with-luajit` option (which is the default for 1.5.8.1+)
to use [LuaJIT](luajit.html) 2.x.

* [LuaJIT](luajit.html)
* [ArrayVarNginxModule](array-var-nginx-module.html)
* [AuthRequestNginxModule](auth-request-nginx-module.html)
* [CoolkitNginxModule](coolkit-nginx-module.html)
* [DrizzleNginxModule](drizzle-nginx-module.html)
* [EchoNginxModule](echo-nginx-module.html)
* [EncryptedSessionNginxModule](encrypted-session-nginx-module.html)
* [FormInputNginxModule](form-input-nginx-module.html)
* [HeadersMoreNginxModule](headers-more-nginx-module.html)
* [IconvNginxModule](iconv-nginx-module.html)
* [StandardLuaInterpreter](standard-lua-interpreter.html)
* [MemcNginxModule](memc-nginx-module.html)
* [Nginx](nginx.html)
* [NginxDevelKit](nginx-devel-kit.html)
* [LuaCjsonLibrary](lua-cjson-library.html)
* [LuaNginxModule](lua-nginx-module.html)
* [LuaRdsParserLibrary](lua-rds-parser-library.html)
* [LuaRedisParserLibrary](lua-redis-parser-library.html)
* [LuaRestyCoreLibrary](lua-resty-core-library.html)
* [LuaRestyDNSLibrary](lua-resty-dns-library.html)
* [LuaRestyLockLibrary](lua-resty-lock-library.html)
* [LuaRestyLrucacheLibrary](lua-resty-lrucache-library.html)
* [LuaRestyMemcachedLibrary](lua-resty-memcached-library.html)
* [LuaRestyMySQLLibrary](lua-resty-mysql-library.html)
* [LuaRestyRedisLibrary](lua-resty-redis-library.html)
* [LuaRestyStringLibrary](lua-resty-string-library.html)
* [LuaRestyUploadLibrary](lua-resty-upload-library.html)
* [LuaRestyUpstreamHealthcheckLibrary](lua-resty-upstream-healthcheck-library.html)
* [LuaRestyWebSocketLibrary](lua-resty-web-socket-library.html)
* [LuaUpstreamNginxModule](lua-upstream-nginx-module.html)
* [PostgresNginxModule](postgres-nginx-module.html)
* [RdsCsvNginxModule](rds-csv-nginx-module.html)
* [RdsJsonNginxModule](rds-json-nginx-module.html)
* [RedisNginxModule](redis-nginx-module.html)
* [Redis2NginxModule](redis-2-nginx-module.html)
* [RestyCLI](resty-cli.html)
* [SetMiscNginxModule](set-misc-nginx-module.html)
* [SrcacheNginxModule](srcache-nginx-module.html)
* [XssNginxModule](xss-nginx-module.html)
