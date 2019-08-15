<!---
    @title         Nginx patches by OpenResty for SSL features
    @creator       Yichun Zhang
--->

If you are not using an official OpenResty release, you must apply our NGINX
core patches to support yielding operations in
[ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block)
and
[ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block).

OpenResty releases after 1.11.2.1 already include these patches. If you are
building your own NGINX with OpenResty's Lua modules, you then must apply these
patches yourself.

Additionally, if you are not using the OpenResty `openresty-openssl` [RPM/DEB
packages](linux-packages.html), you must also apply our [OpenSSL
patches](openssl-patches.html) to support these directives.

Nginx 1.17.x series
-------------------

For Nginx 1.17.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.17.1-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.17.1-ssl_sess_cb_yield.patch).

Nginx 1.15.x series
-------------------

For Nginx 1.15.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.15.8-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.15.8-ssl_pending_session.patch).

Nginx 1.13.x versions
---------------------

For Nginx 1.13.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.13.6-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.13.6-ssl_pending_session.patch).

Nginx 1.11.x versions
---------------------

For Nginx 1.11.x cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.11.2-ssl_cert_cb_yield.patch)
and [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.11.2-ssl_pending_session.patch).
