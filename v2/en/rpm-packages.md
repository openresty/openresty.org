<!---
    @title         OpenResty® RPM Packages
--->

The OpenResty official Yum repositories provide the following RPM packages.

# openresty

This is the production build for the core OpenResty server.

This package registers `/usr/bin/openresty`, which is symbolic link to OpenResty's `nginx` executable
file, `/usr/local/openresty/nginx/sbin/nginx`. This `openresty` command should be visible to your `PATH`
environment by default. Always type `openresty` instead of `nginx` when you want to invoke the nginx
executable provided by this package. The `nginx` executable is not visible to your `PATH` environment
by default, however, to avoid any confusions with other NGINX packages and installations in the same
system.

You can also start the default OpenResty server via the command

```
sudo service openresty start
```

Other service actions supported are `stop`, `restart`, and `reload`.

The default server prefix is `/usr/local/openresty/`. For your own OpenResty applications, it is highly
recommended to specify your own server prefix and point it to your own application directories, like this:

```
sudo openresty -p /opt/my-fancy-app/
```

Then you have sub-directories like `conf/`, `html/` and `logs/` under the `/opt/my-fancy-app/` directory.
This way, we can avoid polluting the OpenResty installation trees under `/usr/local/openresty/` and allow
multiple different OpenResty applications sharing the same OpenResty server installation. You will need
to draft up a init script for each of your OpenResty application yourself, however. You can use the default
`/etc/init.d/openresty` init script as a template.

This package enables the dtrace static probes in the NGINX core and some NGINX C modules (like `ngx_http_lua_module`),
which can be consumed by dynamic tracing tools like SystemTap.

We use our own builds of OpenSSL (through the `openresty-openssl` package), PCRE, zlib, and LuaJIT to ensure these
critical components are up to date and well formed.

# openresty-resty

This package contains the `resty` command-line utility, which is visible to your `PATH` environment (as
`/usr/bin/resty`. To try it out, just type

```console
$ resty -e 'ngx.say("hello")'
hello
```

This package depends on the standard `perl` package and our `openresty` package to work properly.

See the [resty-cli](https://github.com/openresty/resty-cli) project for more details.

# openresty-doc

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

# openresty-valgrind

This is a special debug version of OpenResty targeting the Valgrind tool chain. Valgrind is a powerful tool
to check various kinds of memory issues, like memory leaks and memory invalid accesses. To maximize the
possibilities of catching memory bugs via Valgrind, this build does the following in addition to those
done in the `openresty-debug` package:

* It disables the memory pools used in the NGINX by applying the "[no-pool](https://github.com/openresty/no-pool-nginx)" patch.
* It enforces LuaJIT to use the system allocator instead of its own.
* It enables the internal Valgrind co-operations in the LuaJIT build through the `-DLUAJIT_USE_VALGRIND` C compiler flag.
* The default server prefix of its NGINX is `/usr/local/openresty-valgrind/`.
* The entry point visible to your `PATH` environment is `openresty-valgrind` instead of `openresty-debug`.

See the following tutorials on more details on Valgrind-based testing in the context of OpenResty:

https://openresty.gitbooks.io/programming-openresty/content/testing/test-modes.html#_valgrind_mode

# openresty-asan

This is the clang AddressSanitizer build of the Zlib library. As compared to the `openresty-debug`
package, it has the following changes:

* It uses the command `clang -fsanitize=address` to compile and link.
* It uses the C compiler options `-O1 -fno-omit-frame-pointer` in the build.
* It disables the memory pools used in the NGINX by applying the "[no-pool](https://github.com/openresty/no-pool-nginx)" patch.
* It enables the internal Valgrind co-operations in the LuaJIT build through the `-DLUAJIT_USE_VALGRIND` C compiler flag.
* The default server prefix of its NGINX is `/usr/local/openresty-asan/`.
* The entry point visible to your `PATH` environment is `openresty-asan` instead of `openresty-debug`.
* It uses the `openresty-zlib-asan`, `openresty-pcre-asan`, and `openresty-openssl-asan` packages as runtime dependencies.

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

# openresty-openssl-asan

This is the clang AddressSanitizer build of the OpenSSL library. As compared to the `openresty-openssl-debug`
package, it has the following changes:

* It uses the command `clang -fsanitize=address` to compile and link.
* It uses the `openresty-zlib-asan` package instead of `openresty-zlib` as the runtime dependency.
* It uses the C compiler options `-O1 -fno-omit-frame-pointer` in the build.
* It is installed into the prefix `/usr/local/openresty-asan/openssl/`.

# openresty-zlib

This is our own build of the zlib library for gzip compression. We ship our own zlib package to ensure the latest
mainstream version of zlib is used in OpenResty even on old systems.

# openresty-zlib-asan

This is the clang AddressSanitizer build of the Zlib library. As compared to the `openresty-zlib-debug`
package, it has the following changes:

* It uses the command `clang -fsanitize=address` to compile and link.
* It uses the C compiler options `-O1 -fno-omit-frame-pointer` in the build.
* It is installed into the prefix `/usr/local/openresty-asan/zlib/`.

# openresty-pcre

This is our own build of the PCRE library for gzip compression. We ship our own PCRE package to ensure the latest
mainstream version of PCRE is used in OpenResty even on older systems.

# openresty-pcre-asan

This is the clang AddressSanitizer build of the PCRE library. As compared to the `openresty-pcre-debug`
package, it has the following changes:

* It uses the command `clang -fsanitize=address` to compile and link.
* It uses the C compiler options `-O1 -fno-omit-frame-pointer` in the build.
* It is installed into the prefix `/usr/local/openresty-asan/pcre/`.

# perl-Lemplate

This package provides the command-line utility, [lemplate](https://metacpan.org/pod/Lemplate),
that can compile template files in perl's TT2 templating language syntax to standalone
Lua modules for OpenResty.

The OpenResty official site, openresty.org, [uses](https://github.com/openresty/openresty.org)
Lemplate as the HTML page template compiler, for example.

# perl-Test-Nginx

This is our [Test::Nginx](https://github.com/openresty/test-nginx) test framework. Read the following book chapter on a complete
introduction to this test scaffold:

https://openresty.gitbooks.io/programming-openresty/content/testing/

# Development Packages

We provide development packages for our binary library packages `openresty-zlib`, `openresty-pcre`, `openresty-openssl`,
and `openresty-openssl-debug`. These packages contain header files and static library archive files for the corresponding
binary package. Their name all have a `-devel` suffix as compared to their binary counterpart. For example, we have
`openresty-zlib-devel` for `openresty-zlib`, `openresty-pcre-devel` for `openresty-pcre`, `openresty-openssl-devel` for
`openresty-opnessl`, and also `openresty-openssl-debug-devel` for `openresty-openssl-debug`.

# Debuginfo Packages

We provide debuginfo (or debug symbol) packages for those containing binary components like the `openresty` and `openresty-openssl` packages. Their
debuginfo packages just have the `-debuginfo` suffix in their package names, just like other standard RPM packages.

For example, to install the debuginfo package for the `openresty` package, just install the `openresty-debuginfo` package. Similarly, the debuginfo package for the `openresty-debug` package is `openresty-debug-debuginfo`.

# Source

The source files used to build these packages can be found in the `openresty-packaging` GitHub repository:

https://github.com/openresty/openresty-packaging/tree/master/rpm/

# See Also

See the [Linux Packages](linux-packages.html) page for more details on our official OpenResty package repositories.
