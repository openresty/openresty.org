<!---
    @title         Drizzle Nginx Module
    @creator       Yichun Zhang
    @created       2011-06-21 08:22 GMT
    @modifier      Yichun Zhang
    @modifier_link yichun-zhang
    @modified      2011-08-26 01:12 GMT
    @changes       14
--->

This is an nginx upstream module that talks to MySQL and/or Drizzle database
servers by [libdrizzle](libdrizzle.html).

This ngx_drizzle module is not enabled by default. You should specify the `--with-http_drizzle_module` optiotn
while configuring [OpenResty](openresty.html).

The [libdrizzle](libdrizzle.html) C library is no longer bundled by [OpenResty](openresty.html).
You need to download the drizzle server tarball from https://launchpad.net/drizzle.

When you get the drizzle7 release tarball, you can install libdrizzle-1.0 like
this:

```
tar xzvf drizzle7-VERSION.tar.gz
cd drizzle7-VERSION/
./configure --without-server
make libdrizzle-1.0
make install-libdrizzle-1.0
```

where `VERSION` is the drizzle7 release version number like `2011.06.20`.

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


Documentation page: http://wiki.nginx.org/HttpDrizzleModule

Project page: https://github.com/openresty/drizzle-nginx-module
