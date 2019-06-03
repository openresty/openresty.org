<!---
    @title         Nginx patches by OpenResty for SSL features
    @creator       Yichun Zhang
--->

If you are using OpenSSL 1.1.1 or later, then you need to apply our NGINX core patches
to support yielding operations in OpenResty's [ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block)
directive.
OpenResty releases after 1.15.8.1 already has this patch by default. If you are building
your own Nginx with OpenResty's lua modules, then you will have to apply the patch yourself:

If you are using OpenSSL versions older than 1.1.1, like 1.1.0, then you should not apply
this Nginx core patch at all. Instead, you need to apply our [OpenSSL patches](openssl-patches.html)
if you are not using our `openresty-openssl` pre-built packages.

Nginx 1.15.8 series
-------------------

For Nginx 1.15.8 cores, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/nginx-1.15.8-ssl_pending_session.patch).


Older Nginx versions
--------------------

No patches are provided yet.
