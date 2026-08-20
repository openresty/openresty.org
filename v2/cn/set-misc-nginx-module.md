<!---
    @title         Set Misc Nginx 模块
    @description   set-misc-nginx-module 为 Nginx 的 rewrite 模块添加多种 set_xxx 指令，如 MD5/SHA1 摘要、SQL/JSON 转义等，扩展配置能力。
    @creator       Yichun Zhang
    @created       2011-06-21 08:36 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-26 01:10 GMT
    @changes       8
--->

This module adds various `set_xxx` directives added to [Nginx](nginx.html)'s
[rewrite module](https://wiki.nginx.org/NginxHttpRewriteModule) (MD5/SHA1, SQL/JSON
quoting, and many more).

Every directive provided by this module can be mixed freely with other nginx
rewrite module's
  directives, like `if` and `set`.

Documentation: https://wiki.nginx.org/HttpSetMiscModule

Project page: https://github.com/agentzh/set-misc-nginx-module
