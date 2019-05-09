<!---
    @title         Components
    @creator       Yichun Zhang
    @created       2011-06-21 04:24 GMT
--->

下面列表中的组件被用于构建 [OpenResty](openresty.html)。所有组件均可以方便的被激活或禁止。

绝大部分组件已内置在OpenResty安装包中，但也有一部分不包含在内。

[Drizzle Nginx 模块](drizzle-nginx-module.html)、
[Postgres Nginx 模块](postgres-nginx-module.html) 以及 [Iconv Nginx 模块](iconv-nginx-module.html) 默认并未启用。
你需要分别加入`--with-http_drizzle_module`、`--with-http_postgres_module` 和 `--with-http_iconv_module`
编译选项来开启它们，其余各组件编译选项，可对照[安装OpenResty](installation.html) 说明，按需启用。

在 OpenResty 1.5.8.1 版本之前, OpenResty 默认使用标准 Lua 5.1 解释器。所以对于老版本，
你需要显式地加入`--with-luajit` 编译选项（1.5.8.1 以后的版本已默认开启）来启用 [LuaJIT](luajit.html) 组件。

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
* [LuaRestyLimitTrafficLibrary](https://github.com/openresty/lua-resty-limit-traffic)
* [LuaRestyShellLibrary](https://github.com/openresty/lua-resty-shell)
* [LuaRestySignalLibrary](https://github.com/openresty/lua-resty-signal)
* [LuaTablePoolLibrary](https://github.com/openresty/lua-tablepool)
* [LuaUpstreamNginxModule](lua-upstream-nginx-module.html)
* [OPM](https://github.com/openresty/opm#readme)
* [PostgresNginxModule](postgres-nginx-module.html)
* [RdsCsvNginxModule](rds-csv-nginx-module.html)
* [RdsJsonNginxModule](rds-json-nginx-module.html)
* [RedisNginxModule](redis-nginx-module.html)
* [Redis2NginxModule](redis-2-nginx-module.html)
* [RestyCLI](resty-cli.html)
* [SetMiscNginxModule](set-misc-nginx-module.html)
* [SrcacheNginxModule](srcache-nginx-module.html)
* [StreamLuaNginxModule](https://github.com/openresty/stream-lua-nginx-module#readme)
* [XssNginxModule](xss-nginx-module.html)

由社区贡献的第三方 OpenResty 库可以在[opm.openresty.org](https://opm.openresty.org)
网站上找到。它们可以很容易地通过 OpenResty 自带的 [opm](https://github.com/openresty/opm#readme)
命令行工具来安装。
