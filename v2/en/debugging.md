<!---
    @title         Debugging
    @creator       Yichun Zhang
    @created       2013-10-06 18:12 GMT
--->

You should always check out [Nginx](nginx.html)'s error log file (specified
by the `error_log` directive in `nginx.conf`) for any errors or warnings.

If you prefer redirecting common Lua errors to the HTTP response body during
Lua development, you can put a Lua [pcall](http://www.lua.org/manual/5.1/manual.html#pdf-pcall) call
on the top level of your Lua code to catch and redirect any Lua exceptions.
But keep in mind, not all errors can be captured this way because you could
have errors when sending out the response, then it is impossible to put such
errors into the response body.

During Lua code development, you can disable the [Lua code cache](http://wiki.nginx.org/HttpLuaModule#lua_code_cache) temporarily
so that you do not have to reload the [Nginx](nginx.html) server for your (external)
Lua code changes to take effect.

Also, it is strongly recommended to follow the test-driven development workflow.
For example, [Lua Resty Redis Library](lua-resty-redis-library.html) uses the
[Test::Nginx](http://search.cpan.org/perldoc?Test%3A%3ANginx) test scaffold
to drive its (declarative) [test suite](https://github.com/agentzh/lua-resty-redis/tree/master/t/).

If you are on Linux, there are quite many real-time analysing tools based on
[systemtap](http://sourceware.org/systemtap/), which can be used to inspect
a running [Nginx](nginx.html) worker process in various ways:

https://github.com/agentzh/nginx-systemtap-toolkit

You can find additional tools in the stap++ project:

https://github.com/agentzh/stapxx

These tools can not only debug functional problems, but also profile online
servers to find performance bottlenecks.

Debugging memory issues
-----------------------

3rd-party Lua libraries or 3rd-party NGINX C modules that are not maintained by
OpenResty might be subject to memory issues since they might not go through
the same careful testing of the standard OpenResty components. In very rare
use cases, standard OpenResty components may incur memory issues as well.
To debug such memory issues which lead to either segmentation faults or
weird nondeterminism in software behaviors due to memory corruptions, we
can use Valgrind to reliably find the real culprit when the issues can be
relatively easy to reproduce.

To maximize the effectiveness of Valgrind's memcheck tool, we should at least
disable the memory pools in the NGINX core and also enforce LuaJIT to use the
system memory allocator (by default, LuaJIT uses its own memory allocator).
Furthermore, we should also enable the internal assertions in various
OpenResty core components like `ngx_lua` and LuaJIT.

To simplify the special build settings for Valgrind usage, OpenResty
provides the `openresyt-valgrind` pre-built Linux packages for various
common Linux distributions:

* https://openresty.org/en/linux-packages.html
* https://openresty.org/en/deb-packages.html#openresty-valgrind
* https://openresty.org/en/rpm-packages.html#openresty-valgrind

If your Linux system is not supported in the pre-built package repositories
yet, you can build your own openresty-valgrind by following the steps in
the openresty-valgrind's [RPM spec file](https://github.com/openresty/openresty-packaging/blob/master/rpm/SPECS/openresty-valgrind.spec#L58).

Among other things, remember to configure the following lines in your
`nginx.conf`'s top level scope to ensure nginx runs as a single non-daemon
process when being run by valgrind:

```nginx
daemon off;
master_process off;
worker_processes 1;
```

It is strongly *discouraged* to use Valgrind on non-Linux systems
like Mac OS X or macOS since Valgrind's support in those systems
are very limited and even buggy.

OpenResty's `Test::Nginx` test scaffold has provide builtin support
for running tests with Valgrind, which is referred to as the "Valgrind test mode".
You can find detailed documentation with examples in the "Programming OpenResty" book
online:

https://openresty.gitbooks.io/programming-openresty/content/testing/test-modes.html#_valgrind_mode

One limitation with Valgrind When your OpenResty application requires nontrivial
load of real traffic to reproduce or you have to enable special nginx child
processes like worker processes and cache manager processes to reproduce the
issue, then you can consider rebuilding your OpenResty with clang or gcc's
[AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer) (ASAN) tool,
which also gives much better performance.

For example, you can build OpenResty with ASAN this way:

```bash
export ASAN_OPTIONS=detect_leaks=0

./configure --with-cc="clang -fsanitize=address" \
    --with-cc-opt="-O1 -fno-omit-frame-pointer" --with-debug -j9 \
    --prefix=/usr/local/openresty-asan --with-luajit-xcflags="-DLUAJIT_USE_VALGRIND" \
    --with-no-pool-patch

make -j9
sudo make install
```

Make sure you also set the environment `ASAN_OPTIONS=detect_leaks=0` when you run
this openresty (installed under `/usr/local/openresty-asan/`) otherwise you would
see a lot of false positives on memory leaks.

We will provide the `openresty-asan` package in our official OpenResty Linux package
repositories in the near future to make this easier.

But ASAN comes with a limitation too: it cannot check memory issues happened
in just-in-time (JIT) compiled code (like the machine code generated by PCRE JIT
and LuaJIT's JIT compiler) or any hand-written assembly code as in OpenSSL or
LuaJIT's interpreter.
