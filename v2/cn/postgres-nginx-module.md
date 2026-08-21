<!---
    @title         Postgres Nginx 模块
    @description   postgres-nginx-module 是让 Nginx 直接与 PostgreSQL 通信的 upstream 模块，查询结果以 RDS 格式生成，可配合 rds-json 等模块使用。
    @creator       Yichun Zhang
    @created       2011-06-21 08:28 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-06-22 07:36 GMT
    @changes       3
--->

ngx_postgres is an upstream module that allows [Nginx](nginx.html) to communicate
directly with PostgreSQL database.

Response is generated in RDS format, so it's compatible with [Rds Json Nginx Module](rds-json-nginx-module.html) and
[Drizzle Nginx Module](drizzle-nginx-module.html) modules.

This module is not enabled by default, and you need to specify the `--with-http_postgres_module` option
while [building OpenResty](installation.html). This [Nginx](nginx.html) module
requires libpq to be installed into your system.

Project page: https://github.com/FRiCKLE/ngx_postgres
