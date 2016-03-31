<!---
    @title         Drizzle Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 08:22 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2013-10-17 23:33 GMT
    @changes       23
--->

This is an nginx upstream module that talks to MySQL and/or Drizzle database
servers by [libdrizzle](libdrizzle.html).

This ngx_drizzle module is not enabled by default. You should specify the `--with-http_drizzle_module` option
while configuring [OpenResty](openresty.html).

The [libdrizzle](libdrizzle.html) C library is no longer bundled by [OpenResty](openresty.html).
You need to download the drizzle server tarball from https://launchpad.net/drizzle.

Latest drizzle7 release does not support building libdrizzle 1.0 separately
and requires a lot of external dependencies like Boost and Protobuf which are
painful to install. The last version supporting building libdrizzle 1.0 separately
is `2011.07.21`. You can download it from here:

https://openresty.org/download/drizzle7-2011.07.21.tar.gz

When you get the drizzle7 2011.07.21 release tarball, you can install libdrizzle-1.0
like this:

```
tar xzvf drizzle7-2011.07.21.tar.gz
cd drizzle7-2011.07.21/
./configure --without-server
make libdrizzle-1.0
make install-libdrizzle-1.0
```


Please ensure that you have the `python` command point to a `python2` interpreter.
It's known that on recent Arch Linux distribution, `python` is linked to `python3` by
default, and while running `make libdrizzle-1.0` will yield the following error:

```
File "config/pandora-plugin", line 185
    print "Dependency loop detected with %s" % plugin['name']
                                           ^
SyntaxError: invalid syntax
make: *** [.plugin.scan] Error 1
```

You can fix this by pointing `python` temporarily to `python2`.

When you install the libdrizzle-1.0 library to a custom path prefix, you can
specify the libdrizzle prefix to [OpenResty](openresty.html) like this:

```
cd /path/to/ngx_openresty-VERSION/
./configure --with-libdrizzle=/path/to/drizzle --with-http_drizzle_module
```


Documentation page: https://github.com/openresty/drizzle-nginx-module#readme

Project page: https://github.com/openresty/drizzle-nginx-module

When used in conjunction with [LuaNginxModule](lua-nginx-module.html), it is
recommended to use [LuaRestyMySQLLibrary](lua-resty-mysql-library.html) instead
of this one, since it is more flexible and more memory-efficient.
