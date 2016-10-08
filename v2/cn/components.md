<!---
    @title         Components
    @creator       Yichun Zhang
    @created       2011-06-21 04:24 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2015-11-23 13:15 GMT
    @changes       30
--->

下面列表中的组件被用于构建 [OpenResty](openresty.html)。所有组件均可以方便的被激活或禁止。

绝大部分组件是包含在OpenResty安装包中的，但也一部分不包含。

标准 Lua 5.1 解释器中, [DrizzleNginxModule](drizzle-nginx-module.html)、[PostgresNginxModule](postgres-nginx-module.html)和[IconvNginxModule](iconv-nginx-module.html)默认并未开启。 你需要分别加入`--with-lua51`、`--with-http_drizzle_module`、`--with-http_postgres_module`和`--with-http_iconv_module` 编译选项来开启它们，其余各组件编译选项，可对照[安装OpenResty](installation.html)说明，按需使能。

在 OpenResty 1.5.8.1 版本之前, 如果 [LuaJIT](luajit.html) 2.x 环境不具备，则将默认采用标准的Lua 5.1解释器。 所以对于早期的老版本，你需要显式的加入`--with-luajit`编译选项 ( 1.5.8.1+版本已默认开启 )来使能 [LuaJIT](luajit.html) 2.x功能.

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
