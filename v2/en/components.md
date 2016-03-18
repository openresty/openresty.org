<!---
    @title         Components
    @creator       Yichun Zhang
    @created       2011-06-21 04:24 GMT
    @modifier      YichunZhang
    @modified      2015-11-23 13:15 GMT
    @changes       35
--->

Below lists all the components bundled in [OpenResty](openresty/). All of the components can be enabled or disabled on need.

Most of the components are enabled by default, some are not.

The standard Lua 5.1 interpreter, [DrizzleNginxModule](drizzle-nginx-module/), [PostgresNginxModule](postgres-nginx-module/), and [IconvNginxModule](iconv-nginx-module/) are not enabled by default. You need to specify the `--with-lua51`, `--with-http_drizzle_module`, `--with-http_postgres_module`, and `--with-http_iconv_module` options, respectively, to enable them while [building OpenResty](installation/).

Before the 1.5.8.1 release, the standard Lua 5.1 interpreter is enabled by default while [LuaJIT](luajit/) 2.x is not. So for earlier releases, you need to explicitly specify the `--with-luajit` option (which is the default for 1.5.8.1+) to use [LuaJIT](luajit/) 2.x.

* [LuaJIT](luajit/)
* [ArrayVarNginxModule](array-var-nginx-module/)
* [AuthRequestNginxModule](auth-request-nginx-module/)
* [CoolkitNginxModule](coolkit-nginx-module/)
* [DrizzleNginxModule](drizzle-nginx-module/)
* [EchoNginxModule](echo-nginx-module/)
* [EncryptedSessionNginxModule](encrypted-session-nginx-module/)
* [FormInputNginxModule](form-input-nginx-module/)
* [HeadersMoreNginxModule](headers-more-nginx-module/)
* [IconvNginxModule](iconv-nginx-module/)
* [StandardLuaInterpreter](standard-lua-interpreter/)
* [MemcNginxModule](memc-nginx-module/)
* [Nginx](nginx/)
* [NginxDevelKit](nginx-devel-kit/)
* [LuaCjsonLibrary](lua-cjson-library/)
* [LuaNginxModule](lua-nginx-module/)
* [LuaRdsParserLibrary](lua-rds-parser-library/)
* [LuaRedisParserLibrary](lua-redis-parser-library/)
* [LuaRestyCoreLibrary](lua-resty-core-library/)
* [LuaRestyDNSLibrary](lua-resty-dns-library/)
* [LuaRestyLockLibrary](lua-resty-lock-library/)
* [LuaRestyLrucacheLibrary](lua-resty-lrucache-library/)
* [LuaRestyMemcachedLibrary](lua-resty-memcached-library/)
* [LuaRestyMySQLLibrary](lua-resty-mysql-library/)
* [LuaRestyRedisLibrary](lua-resty-redis-library/)
* [LuaRestyStringLibrary](lua-resty-string-library/)
* [LuaRestyUploadLibrary](lua-resty-upload-library/)
* [LuaRestyUpstreamHealthcheckLibrary](lua-resty-upstream-healthcheck-library/)
* [LuaRestyWebSocketLibrary](lua-resty-web-socket-library/)
* [LuaUpstreamNginxModule](lua-upstream-nginx-module/)
* [PostgresNginxModule](postgres-nginx-module/)
* [RdsCsvNginxModule](rds-csv-nginx-module/)
* [RdsJsonNginxModule](rds-json-nginx-module/)
* [RedisNginxModule](redis-nginx-module/)
* [Redis2NginxModule](redis-2-nginx-module/)
* [RestyCLI](resty-cli/)
* [SetMiscNginxModule](set-misc-nginx-module/)
* [SrcacheNginxModule](srcache-nginx-module/)
* [XssNginxModule](xss-nginx-module/)
