<!---
    @title         Nginx patches by OpenResty for SSL features
    @creator       Yichun Zhang
--->

If you are not using an official OpenResty release, then you need to apply our NGINX core patches
to support yielding operations in lua module's
[ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block)
and [ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block)
directives.
OpenResty releases after 1.11.2.1 already include these patches. If you are building
your own Nginx with OpenResty's lua modules, then you will have to apply the patches yourself:

Additionally, note that if you are using OpenSSL versions older than 1.1.1 such
as 1.1.0 or 1.0.2, then you must also apply our [OpenSSL
patches](openssl-patches.html). Our `openresty-openssl` pre-built packages
already include these patches.

Nginx 1.15.x series
-------------------

For Nginx 1.15.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.15.8-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.15.8-ssl_sess_cb_yield.patch).

Nginx 1.13.x versions
---------------------

For Nginx 1.13.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.13.6-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.13.6-ssl_pending_session.patch).

Nginx 1.11.x versions
---------------------

For Nginx 1.11.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.11.2-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.11.2-ssl_pending_session.patch).
