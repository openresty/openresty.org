<!---
    @title         OpenSSL patches by OpenResty
    @creator       Yichun Zhang
--->

If your are not using the OpenResty `openresty-openssl` [RPM/DEB
packages](linux-packages.html), you must apply our OpenSSL patches to the
OpenSSL source tree before building it in order to support yielding operations
in
[ssl_session_fetch_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_session_fetch_by_lua_block)
and
[ssl_certificate_by_lua*](https://github.com/openresty/lua-nginx-module#ssl_certificate_by_lua_block).

Our `openresty-openssl` pre-built packages already include these patches.

Additionally, if you are not using an official OpenResty release, you must also
apply our [NGINX core patches](nginx-ssl-patches.html) yourself.

OpenSSL 1.1.1 series
--------------------

For OpenSSL 1.1.1c or later, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.1.1c-sess_set_get_cb_yield.patch).

OpenSSL 1.1.0 series
--------------------

For OpenSSL 1.1.0c or earlier, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.1.0c-sess_set_get_cb_yield.patch).

For OpenSSL 1.1.0d or later, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.1.0d-sess_set_get_cb_yield.patch).

OpenSSL 1.0.2 series
--------------------

For OpenSSL 1.0.2, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.0.2h-sess_set_get_cb_yield.patch).
