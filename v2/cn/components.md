<!---
    @title         Components
    @creator       Yichun Zhang
    @created       2011-06-21 04:24 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-11-23 13:15 GMT
    @changes       30
--->

下面列表中的组件被用于构建 [OpenResty](openresty.html)。所有的组件可以被激活或禁止。
大部组件默认是激活的，也有部件不是。
[LuaJIT](luajit.html)、 [DrizzleNginxModule](drizzle-nginx-module.html)、[PostgresNginxModule](postgres-nginx-module.html)和[IconvNginxModule](iconv-nginx-module.html) 默认是没有激活的。您需要通过以下选项在编译
[OpenResty](openresty.html)的时候将它们各自激活， `--with-luajit`、
`--with-http_drizzle_module`、 `--with-http_postgres_module`和 `--with-http_iconv_module` 。

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
