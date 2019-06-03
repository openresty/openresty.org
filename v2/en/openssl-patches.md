<!---
    @title         OpenSSL patches by OpenResty
    @creator       Yichun Zhang
--->

If you are using OpenSSL 1.1.0 or older, then to support yielding operations
in nginx lua module's `ssl_session_fetch_by_lua*` directive, you need to use OpenResty's own
`openresty-openssl` [RPM/DEB packages](linux-packages.html) or just apply our
OpenSSL patches to the official OpenSSL source trees and build from source.

It is highly recommended to use OpenResty and OpenResty's official [pre-built binary packages](download.html)
to avoid all such troubles.

OpenSSL 1.1.1 or later
----------------------

You do *not* need to apply any patches to OpenSSL 1.1.1 or later. They do work out of the box. But
keep in mind, you still need to apply [Nginx core patches]() if you are *not* using OpenResty.

OpenSSL 1.1.0 series
--------------------

For OpenSSL 1.1.0c or earlier, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.1.0c-sess_set_get_cb_yield.patch)

For OpenSSL 1.1.0d or later, apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.1.0d-sess_set_get_cb_yield.patch)

OpenSSL 1.0.2 series
--------------------

Apply [this patch](https://raw.githubusercontent.com/openresty/openresty/master/patches/openssl-1.0.2h-sess_set_get_cb_yield.patch).
