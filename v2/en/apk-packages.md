<!---
    @title         OpenResty®  Alpine APK Packages
--->

The OpenResty official APK repositories provide the following Alpine APK packages.

# openresty

This is the production build for the core OpenResty server.

This package registers `/usr/bin/openresty`, which is symbolic link to OpenResty's `nginx` executable
file, `/usr/local/openresty/nginx/sbin/nginx`. This `openresty` command should be visible to your `PATH`
environment by default. Always type `openresty` instead of `nginx` when you want to invoke the nginx
executable provided by this package. The `nginx` executable is not visible to your `PATH` environment
by default, however, to avoid any confusions with other NGINX packages and installations in the same
system.

You can also start the default OpenResty server via the command

```bash
sudo rc-service openresty start
```

Other service actions supported are `checkconfig`, `stop`, `reopen`, `reload`, and `upgrade`.

The default server prefix is `/usr/local/openresty/`. For your own OpenResty applications, it is highly
recommended to specify your own server prefix and point it to your own application directories, like this:

```bash
sudo openresty -p /opt/my-fancy-app/
```

Then you have sub-directories like `conf/`, `html/` and `logs/` under the `/opt/my-fancy-app/` directory.
This way, we can avoid polluting the OpenResty installation trees under `/usr/local/openresty/` and allow
multiple different OpenResty applications sharing the same OpenResty server installation. You will need
to edit the `/etc/conf.d/openresty` file to point to your new nginx configuration file and server prefix
path if you want to reuse the OpenRC services. Or you can make separate init scripts for each of your
OpenResty application yourself using the files `/etc/init.d/openresty` and `/etc/conf.d/openresty` as templates.

# openresty-resty

This package contains the `resty` command-line utility, which is visible to your `PATH` environment (as
`/usr/bin/resty`. To try it out, just type

```console
$ resty -e 'ngx.say("hello")'
hello
```

This package depends on the standard `perl` package and our `openresty` package to work properly.

See the [resty-cli](https://github.com/openresty/resty-cli) project for more details.

# openresty-restydoc

This package contains the OpenResty documentation tool chain and documentation data. The most useful tool
is the `restydoc` command-line utility, which should be visible to your `PATH` environment by default (as
`/usr/bin/restydoc`.

To try it out:

```bash
restydoc ngx_lua

restydoc -s content_by_lua

restydoc -s proxy_pass
```

See the output of the `restydoc -h` command for more details on its usage.

For the best result, please ensure your terminal is using the UTF-8 character encoding and both of your `perl`
and `groff` installations are modern enough. Otherwise those non-ASCII characters may not be displayed
correctly.

# openresty-opm

This package contains the command-line utility [opm](https://github.com/openresty/opm#readme) for OpenResty Package Manager. This tool can be used
to install community-contributed OpenResty packages from the central OPM package server:

https://opm.openresty.org/

# openresty-debug

This is the normal debug build of OpenResty. As compared to the `openresty` package, it has the following
differences:

* It disables C compiler optimizations in the build.
* It enables the NGINX debugging log capability.
* It enables the poll module in NGINX in addition to the default epoll module so that
the [mockeagain](https://github.com/openresty/mockeagain) testing tool can be used.
* It uses the `openresty-openssl-debug` package instead of `openresty-openssl` for the OpenSSL library.
* It enables API checks and assertions in the LuaJIT build.
* It enables the assertions in the `ngx_http_lua` module.
* It makes the `ngx_http_lua` module abort the current nginx worker process immediately upon LuaJIT allocation
failures in its GC-managed memory (the default behavior is logging an error message and gracefully quit
the current worker process).
* The default server prefix of its NGINX is `/usr/local/openresty-debug/`.
* The entry point visible to your `PATH` environment is `openresty-debug` instead of `openresty`.
* It does not come with a init script.

You should never use this package in production. This package is for development only.

This package also comes with an OpenRC init scripts, as in

```bash
sudo rc-service openresty-debug start
```

# openresty-openssl

This is our own build of the OpenSSL library. In particular, we have disabled the threads support in the build
to save some overhead.

We include our own (small) patches to support advanced SSL features in OpenResty like
[ssl_session_fetch_by_lua](https://github.com/openresty/lua-nginx-module/#ssl_session_fetch_by_lua_block).

Also, we ship our own OpenSSL package to ensure the latest
mainstream version of OpenSSL is used in OpenResty even on older systems.

# openresty-openssl-debug

This is the debug build of the OpenSSL library. As compared to `openresty-openssl`, it has the following changes:

* It disables any C compiler optimizations.
* It is Valgrind clean and free of any Valgrind false positives.
* Assembly code is disabled so we always have perfect C-land backtraces and etc.
* It is installed into the prefix `/usr/local/openresty-debug/openssl/`.

# openresty-openssl111

This is our own build of the OpenSSL v1.1.1 library. In particular, we have disabled the threads support in the build
to save some overhead.

We include our own (small) patches to support advanced SSL features in OpenResty like
[ssl_session_fetch_by_lua](https://github.com/openresty/lua-nginx-module/#ssl_session_fetch_by_lua_block).

Also, we ship our own OpenSSL package to ensure the latest
mainstream version of OpenSSL is used in OpenResty even on older systems.

# openresty-openssl111-debug

This is the debug build of the OpenSSL v1.1.1 library. As compared to `openresty-openssl`, it has the following changes:

* It disables any C compiler optimizations.
* It is Valgrind clean and free of any Valgrind false positives.
* Assembly code is disabled so we always have perfect C-land backtraces and etc.
* It is installed into the prefix `/usr/local/openresty-debug/openssl111/`.

# openresty-zlib

This is our own build of the zlib library for gzip compression. We ship our own zlib package to ensure the latest
mainstream version of zlib is used in OpenResty even on old systems.

# openresty-pcre

This is our own build of the PCRE library. We ship our own PCRE package to ensure the latest
mainstream version of PCRE is used in OpenResty even on older systems.

# openresty-pcre2

This is our own build of the PCRE2 library. We ship our own PCRE package to ensure the latest
mainstream version of PCRE2 is used in OpenResty (>= v1.25) even on older systems.

# perl-lemplate

This package provides the command-line utility, [lemplate](https://metacpan.org/pod/Lemplate),
that can compile template files in perl's TT2 templating language syntax to standalone
Lua modules for OpenResty.

The OpenResty official site, openresty.org, [uses](https://github.com/openresty/openresty.org)
Lemplate as the HTML page template compiler, for example.

# perl-test-nginx

This is our [Test::Nginx](https://github.com/openresty/test-nginx) test framework. Read the following book chapter on a complete
introduction to this test scaffold:

https://openresty.gitbooks.io/programming-openresty/content/testing/

This package is already shipped by the official Alpine community repository so we do not bother
packaging it ourselves.

# Development Packages

We provide development packages for our binary library packages `openresty-zlib`, `openresty-pcre`, `openresty-openssl`,
and `openresty-openssl-debug`. These packages contain header files or the corresponding
binary package. Their names all have a `-dev` suffix as compared to their binary counterpart. For example, we have
`openresty-zlib-dev` for `openresty-zlib`, `openresty-pcre-dev` for `openresty-pcre`, `openresty-openssl-dev` for
`openresty-opnessl`, and also `openresty-openssl-debug-dev` for `openresty-openssl-debug`.

# Debuginfo Packages

We provide debuginfo (or debug symbol) packages for those containing binary components like the `openresty` and `openresty-openssl` packages. Their
debuginfo packages just have the `-dbg` suffix in their package names, just like other standard APK packages.

For example, to install the debuginfo package for the `openresty` package, just install the `openresty-dbg` package. Similarly, the debuginfo package for the `openresty-debug` package is `openresty-debug-dbg`.

# Source

The source files used to build these packages can be found in the `openresty-packaging` GitHub repository:

https://github.com/openresty/openresty-packaging/tree/master/alpine/

# See Also

See the [Linux Packages](linux-packages.html) page for more details on our official OpenResty package repositories.
